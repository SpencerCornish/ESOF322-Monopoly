import 'dart:html';
import 'dart:math';
import 'dart:async';

import '../player/player.dart';
import '../board/board.dart';

void main() {
  App app = new App();
}

class App {
  List<Player> _playerList;
  Player _activePlayer;
  //Board _gameBoard;
  Random random = new Random.secure();

  CanvasElement _canvasBackground;
  CanvasRenderingContext2D _ctxBackground;

  CanvasElement _canvasForeground;
  CanvasRenderingContext2D _ctxForeground;

  List<HtmlElement> _buttons = new List<HtmlElement>();

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

  Board _board;

  App() {
    _constructButtonControls();

    // Instantiate a board
    _board = new Board();
    // Board should parse CSV file for tile data and create tiles
    // Board should hold a list of players in jail?
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

    // Instantiate players
    // Player should instantiate game_pieces/banks

    window.onResize.listen((e) {
      _canvasBackground.width = window.innerWidth;
      _canvasBackground.height = window.innerHeight;
      _canvasForeground.width = window.innerWidth;
      _canvasForeground.height = window.innerHeight;

      _board.resize();
      _beginDraw();
    });

    Timer loadingSplashScreenTimeout =
        new Timer(new Duration(seconds: 1), _beginDraw);
  }

  _beginDraw() {
    _ctxBackground.clearRect(0, 0, window.innerWidth, window.innerHeight);
    _ctxForeground.clearRect(0, 0, window.innerWidth, window.innerHeight);
    querySelector('#output').text = '';
    for (ButtonElement button in _buttons)
      querySelector('.top-button-container').children.add(button);
    _board.draw(_ctxBackground);
  }

  _drawForeground() {}
  _drawBackground() {}
  _addPlayers() {
    // Create 4 mock players
    for (int i = 0; i < 4; i++) {
      Player newPlayer = new Player('player');
      _playerList.add(newPlayer);
    }
  }

  _nextPlayer() {
    if (_activePlayer == null) {
      _activePlayer = _playerList.first;
      return;
    }
    int newIndex = _playerList.indexOf(_activePlayer) + 1;
    // Check to see if we need to go back to the start of the playerlist
    if (newIndex > _playerList.length) {
      _playerList.indexOf(_playerList.first);
      return;
    }
    _activePlayer = _playerList[newIndex];
  }

  _constructButtonControls() {
    _statusLabel = new LabelElement();
    _statusLabel.text = ':)';
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
    _mortgagePropertyButton.text = 'Mortgage Tiles';
    _mortgagePropertyButton.classes = _constructButtonClasses('is-info');
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

  _constructButtonClasses(String extraClasses, [String extraClassTwo = "a"]) =>
      [
        'button',
        'is-success',
        'padded',
        'is-centered',
        'is-small',
        extraClasses,
        extraClassTwo,
      ];
  _buildBoard(String boardCsv) {}

  //
  // Button Handlers
  //

  _handleRollDice(_) {
    int rollVal = random.nextInt(6);
    //_activePlayer.move(rollVal);
    _statusLabel.text = "Rolled a ${rollVal}";
  }

  _handleBuyProperty(_) {
    _activePlayer.buyTile(_board.tiles[_activePlayer.position]);
  }

  _handleEndTurn(_) {
    _nextPlayer();
  }

  _handleAuctionProperty(_) {
    print("Auctioning not yet implemented!");
  }

  _handleMortgageProperty(_) {
    print("followup ticket is coming to construct modals :-)");
    // _displayModal(".mortgage-modal");
  }

  _handleBuyBuilding(_) {
    print("followup ticket is coming to construct modals :-)");
    // _displayModal(".mortgage-modal");
  }

  _handleSellBuilding(_) {
    print("followup ticket is coming to construct modals :-)");
    // _displayModal(".mortgage-modal");
  }
}
