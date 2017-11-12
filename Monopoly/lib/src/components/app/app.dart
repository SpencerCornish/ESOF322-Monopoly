import 'dart:html';
import 'dart:math';
import 'dart:async';

import '../player/player.dart';
import '../board/board.dart';
import '../tiles/tile.dart';

void main() {
  App app = new App();
}

class App {
  ////////////////////
  /// Board Variables
  ////////////////////

  Board _board;

  ////////////////////
  // Player Variables
  ////////////////////

  List<Player> _playerList;
  Player _activePlayer;

  ////////////////////
  // Utility Variables
  ////////////////////

  Random random;
  bool _isStarted;
  bool _shouldRollAgain;

  ////////////////////
  // Canvas/Draw Variables
  ////////////////////

  CanvasElement _canvasBackground;
  CanvasRenderingContext2D _ctxBackground;

  CanvasElement _canvasForeground;
  CanvasRenderingContext2D _ctxForeground;

  List<HtmlElement> _buttons;

  LabelElement _statusLabel;

  // Top button control refs
  ButtonElement _rollDiceButton;
  ButtonElement _buyPropertyButton;
  ButtonElement _auctionPropertyButton;
  ButtonElement _endTurnButton;

  // Bottom button control refs
  ButtonElement _mortgagePropertyButton;
  ButtonElement _buildBuildingButton;
  ButtonElement _buyBuildingButton;
  ButtonElement _sellBuildingButton;

  App() {
    // Instantiate a board, init variables
    _board = new Board();
    _isStarted = false;
    random = new Random.secure();
    _playerList = new List<Player>();

    _playerList.add(new Player("Bryan", 10, 0, 'blue', _board));
    _playerList.add(new Player("Nate", 10, 1, 'green', _board));
    _playerList.add(new Player("Keely", 10, 2, 'orange', _board));
    _playerList.add(new Player("Spencer", 10, 3, 'red', _board));
    _playerList.add(new Player("Katy", 10, 4, 'pink', _board));
    _playerList.add(new Player("Perry", 10, 5, 'brown', _board));

    // TODO: set the active player in a better way!
    _activePlayer = _playerList.first;

    // This builds up a list of controls to add to the sidebar
    _constructButtonControls();

    // This queryselects for the proper canvas DOM elements, and sets up rendering contexts
    _constructRenderingContext();

    window.onResize.listen((e) {
      _canvasBackground.width = window.innerWidth;
      _canvasBackground.height = window.innerHeight;
      _canvasForeground.width = window.innerWidth;
      _canvasForeground.height = window.innerHeight;

      _board.resize();
      _drawBackground();
    });

    // Show the splash screen!
    new Timer(new Duration(seconds: 1), _beginDraw);

    // Start the
    new Timer.periodic(new Duration(milliseconds: 20), (Timer t) {
      _drawForeground();
    });
  }

  _beginDraw() {
    _ctxBackground.clearRect(0, 0, window.innerWidth, window.innerHeight);
    _ctxForeground.clearRect(0, 0, window.innerWidth, window.innerHeight);
    querySelector('#output').text = '';
    for (HtmlElement button in _buttons) querySelector('.top-button-container').children.add(button);
    _board.draw(_ctxBackground);
    querySelector('#output').text = '';
    _isStarted = true;
  }

  _drawForeground() {
    if (_isStarted) {
      _ctxForeground.clearRect(0, 0, window.innerWidth, window.innerHeight);
      for (Player player in _playerList) {
        player.draw(_ctxForeground);
      }
    }
  }

  _drawBackground() {
    _ctxBackground.clearRect(0, 0, window.innerWidth, window.innerHeight);
    _board.draw(_ctxBackground);
  }

  _nextPlayer() {
    if (_activePlayer == null) {
      _activePlayer = _playerList.first;
      return;
    }
    int newIndex = _playerList.indexOf(_activePlayer) + 1;
    // Check to see if we need to go back to the start of the playerlist
    if (newIndex == _playerList.length) {
      newIndex = 0;
    }
    _activePlayer = _playerList[newIndex];
    _statusLabel.text = _activePlayer.name;
  }

  _constructRenderingContext() {
    // Instantiate a board
    _canvasBackground = querySelector("#canvas-background");
    _ctxBackground = _canvasBackground.getContext('2d');

    _canvasForeground = querySelector("#canvas-foreground");
    _ctxForeground = _canvasForeground.getContext('2d');

    // Background canvas setup
    _canvasBackground.width = window.innerWidth ?? 1024;
    _canvasBackground.height = window.innerHeight ?? 768;
    // Foreground canvas setup
    _canvasForeground.width = window.innerWidth ?? 1024;
    _canvasForeground.height = window.innerHeight ?? 768;
  }

  _constructButtonControls() {
    _buttons = new List<HtmlElement>();

    _statusLabel = new LabelElement();
    _statusLabel.text = _playerList[0].name;
    _statusLabel.className = 'is-unselectable';
    _buttons.add(_statusLabel);

    _rollDiceButton = new ButtonElement();
    _rollDiceButton.text = 'Roll Dice';
    _rollDiceButton.classes = _constructButtonClasses('is-info');
    _rollDiceButton.onClick.listen(_handleRollDice);
    _buttons.add(_rollDiceButton);

    _buyPropertyButton = new ButtonElement();
    _buyPropertyButton.text = 'Buy Tile';
    _buyPropertyButton.classes = _constructButtonClasses('is-static');
    _buyPropertyButton.onClick.listen(_handleBuyProperty);
    _buttons.add(_buyPropertyButton);

    _auctionPropertyButton = new ButtonElement();
    _auctionPropertyButton.text = 'Auction Tile';
    _auctionPropertyButton.classes = _constructButtonClasses('is-static');
    _auctionPropertyButton.onClick.listen(_handleAuctionProperty);
    _buttons.add(_auctionPropertyButton);

    _endTurnButton = new ButtonElement();
    _endTurnButton.text = 'End Turn';
    _endTurnButton.classes = _constructButtonClasses('is-danger');
    _endTurnButton.onClick.listen(_handleEndTurn);
    _buttons.add(_endTurnButton);

    _mortgagePropertyButton = new ButtonElement();
    _mortgagePropertyButton.text = 'Mortgage Tile';
    _mortgagePropertyButton.classes = _constructButtonClasses('is-static');
    _mortgagePropertyButton.onClick.listen(_handleMortgageProperty);
    _buttons.add(_mortgagePropertyButton);

    _buyBuildingButton = new ButtonElement();
    _buyBuildingButton.text = 'Buy Buildings';
    _buyBuildingButton.classes = _constructButtonClasses('is-info');
    _buyBuildingButton.onClick.listen(_handleBuyBuilding);
    _buttons.add(_buyBuildingButton);

    _sellBuildingButton = new ButtonElement();
    _sellBuildingButton.text = 'Sell Buildings';
    _sellBuildingButton.classes = _constructButtonClasses('is-static');
    _sellBuildingButton.onClick.listen(_handleSellBuilding);
    _buttons.add(_sellBuildingButton);
  }

  _constructButtonClasses(String extraClasses, [String extraClassTwo = "a"]) => [
        'button',
        'is-success',
        'padded',
        'is-centered',
        'is-small',
        extraClasses,
        extraClassTwo,
      ];

  //
  // Button Handlers
  //

  _updateButtons() {
    Tile curTile = _board.tiles[_activePlayer.position];
    if (curTile.owner == null &&
        (curTile.type == 'Street' || curTile.type == 'Railroad' || curTile.type == 'Utility')) {
      _buyPropertyButton.classes = _constructButtonClasses('is-info');
    } else {
      _buyPropertyButton.classes = _constructButtonClasses('is-static');
    }
    if (_activePlayer.ownedTiles.length > 0) {
      _mortgagePropertyButton.classes = _constructButtonClasses('is-info');
    }
  }

  _handleRollDice(_) {
    int rollDieOne = random.nextInt(6) + 1;
    int rollDieTwo = random.nextInt(6) + 1;
    int rollValue = rollDieOne + rollDieTwo;
    // Sets should roll again if
    _shouldRollAgain = rollDieOne == rollDieTwo;
    _activePlayer.move(rollValue);
    _statusLabel.text =
        "Rolled ${_shouldRollAgain ? 'double' : 'a'} ${_shouldRollAgain ? rollDieOne.toString() + '\'s' : rollDieOne + rollDieTwo}";
    _updateButtons();
  }

  _handleBuyProperty(_) {
    _activePlayer.buyTile(_board.tiles[_activePlayer.position]);
    _updateButtons();
  }

  _handleEndTurn(_) {
    _nextPlayer();
    _updateButtons();
  }

  _handleAuctionProperty(_) {
    print("Auctioning not yet implemented!");
    _updateButtons();
  }

  _handleMortgageProperty(_) {
    _displayListModal("Choose a tile to Mortgage", _activePlayer.ownedTiles, _handleMortgage, mortgage: true);
    //_updateButtons();
  }

  _handleBuyBuilding(_) {
    _displayListModal("Choose a tile to build upon", _activePlayer.ownedTiles, _handleBuildingPurchase,
        showNumBuildings: true);
  }

  _handleSellBuilding(_) {
    _displayListModal("Choose a tile to sell a building", _activePlayer.ownedTiles, _handleBuildingSell,
        showNumBuildings: true);
  }

  ////////////
  /// Modal handlers
  ////////////

  String _displayListModal(String title, List<Tile> selectionList, Function onClickFunction,
      {bool showNumBuildings = false, bool mortgage = false}) {
    // Core modal elements
    Element modal = querySelector('.modal');
    Element modalBackground = querySelector('.modal-background');
    Element closeButton = querySelector('.delete');

    // User defined modal elements
    Element modalTitle = querySelector('.modal-card-title');
    Element modalTable = querySelector('.modal-table-sel');

    // Set the Title String
    modalTitle.text = title;
    // Set the modal to visible
    modal.className = "modal is-active";
    String tableItems = _buildNodes(selectionList, modalTable, onClickFunction, showNumBuildings, mortgage);

    // Closing handlers
    closeButton.onClick.listen((e) {
      modal.className = "modal";
      modalTable.children.clear();
    });
    modalBackground.onClick.listen((e) {
      modal.className = "modal";
      modalTable.children.clear();
    });
  }

  _buildNodes(List<Tile> tileList, Element modalTable, Function onClickFunction, bool showNumBuildings, bool mortgage) {
    NodeValidatorBuilder validator = new NodeValidatorBuilder.common();
    validator.allowInlineStyles();
    NodeTreeSanitizer sanitizer = new NodeTreeSanitizer(validator);
    for (Tile tile in tileList) {
      modalTable.insertAdjacentHtml(
          "beforeend",
          """
          <tr>
            <th><a class="button is-static is-small" style="background-color:${tile.color}"><span class="icon is-small">
            <td class="is-unselectable">${tile.name}</td>
            <td><p class="has-text-${mortgage ? 'success' : 'danger'} is-unselectable">\$${mortgage ? tile.mortgageCost : tile.buildPrice}</p></td>
            ${showNumBuildings ? '<td><p class="is-unselectable">${tile.numBuildings} Building${tile.numBuildings == 1 ? '' : 's'}</p></td>' : '' }
            <td><a class="button is-small is-info is-outlined tile-action-${tile.hashCode}">Select</a></td>
          </tr>
          """,
          treeSanitizer: sanitizer);
      LinkElement button = querySelector('.tile-action-${tile.hashCode}');
      button.onClick.listen(onClickFunction);
    }
  }

  // Modal click handlers

  _handleMortgage(MouseEvent event) {
    Element target = event.target;
    for (Tile tile in _activePlayer.ownedTiles)
      if (target.classes.contains("tile-action-${tile.hashCode}")) {
        _activePlayer.mortgageTile(tile);
        _closeModal();
      }
  }

  _handleBuildingPurchase(MouseEvent event) {
    Element target = event.target;
    for (Tile tile in _activePlayer.ownedTiles)
      if (target.classes.contains("tile-action-${tile.hashCode}")) {
        _activePlayer.buyBuilding(tile, 1);
        _closeModal();
      }
  }

  _handleBuildingSell(MouseEvent event) {
    Element target = event.target;
    for (Tile tile in _activePlayer.ownedTiles)
      if (target.classes.contains("tile-action-${tile.hashCode}")) {
        _activePlayer.sellBuilding(tile);
        _closeModal();
      }
  }

  _closeModal() {
    Element closeButton = querySelector('.delete');
    closeButton?.click();
  }
}
