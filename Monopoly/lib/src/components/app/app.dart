import 'dart:html';
import 'dart:math';
import 'dart:async';

import '../player/player.dart';
import '../computer_player/computer_player.dart';
import '../board/board.dart';
import '../tiles/tile.dart';
import '../modal_builder/modal_builder.dart';
import '../renderer/renderer.dart';

void main() {
  new App();
}

class App {
  ////////////////////
  /// GUI Variables
  ////////////////////

  Renderer renderer;

  ////////////////////
  /// Board Variables
  ////////////////////

  Board _board;

  ////////////////////
  // Player Variables
  ////////////////////

  List<Player> _playerList;
  Player _activePlayer;
  Player get activePlayer => _activePlayer;
  //ComputerPlayer computer = new ComputerPlayer(this, "robit", 10, 2, 'orange', _board);
  ComputerPlayer computer;

  ////////////////////
  // Utility Variables
  ////////////////////

  Random _random;
  bool shouldRollAgain;
  int _turnNum;
  int _turnLimit;
  bool _gameOver;

  int rollValue;

  ////////////////////
  // Canvas/Draw Variables
  ////////////////////

  List<HtmlElement> _buttons;

  LabelElement _turnLabel;
  LabelElement _nameLabel;
  LabelElement _rollLabel1;
  LabelElement _rollLabel2;
  LabelElement _infoLabel;

  // Top button control refs
  ButtonElement _rollDiceButton;
  ButtonElement _buyPropertyButton;
  ButtonElement _auctionPropertyButton;
  ButtonElement _endTurnButton;
  ButtonElement _exampleButton;

  // Bottom button control refs
  ButtonElement _mortgagePropertyButton;
  ButtonElement _buyBuildingButton;
  ButtonElement _sellBuildingButton;

  ////////////////////
  // Modal Variables
  ////////////////////
  ModalBuilder _modalComponent;

  ///////////////////////////////////
  // button availability  Variables
  ///////////////////////////////////

  bool isRollDiceAvailable = true,
      isBuyPropertyAvailable = true,
      isAuctionPropertyAvailable = true,
      isMortgagePropertyAvailable = true,
      isBuyBuildingsAvailable = true,
      isSellBuildingsAvailable = true,
      isEndTurnAvailable = true;

  App() {
    // Instantiate a board, init variables
    _board = new Board();
    _random = new Random.secure();
    _turnNum = 1;
    _turnLimit = 10;
    _gameOver = false;
    shouldRollAgain = true;

    _playerList = new List<Player>();

    _playerList.add(new Player("Bryan", 10, 0, 'blue', _board));
    //_playerList.add(new Player("Nate", 10, 1, 'green', _board));
    //_playerList.add(new Player("Keely", 10, 2, 'orange', _board));
    computer = new ComputerPlayer(this, "computer", 10, 1, 'orange', _board);
    _playerList.add(computer);
    computer.isComputer = true;
    // _playerList.add(new Player("Spencer", 10, 3, 'red', _board));
    //_playerList.add(new Player("Katy", 10, 4, 'pink', _board));
    _playerList.add(new Player("Perry", 10, 2, 'brown', _board));

    // TODO: set the active player in a better way!
    _activePlayer = _playerList.first;

    renderer = new Renderer(_board, _playerList);

    // This builds up a list of controls to add to the sidebar

    _constructButtonControls();

    // Show the splash screen, and invoke rendering
    new Timer(new Duration(seconds: 3), _startMainActivity);
  }

  _startMainActivity() {
    for (HtmlElement button in _buttons) querySelector('.top-button-container').children.add(button);
    renderer.beginDraw();
  }

  nextPlayer() {
    print("getting next player");

    if (_activePlayer == null) {
      _activePlayer = _playerList.first;
      return;
    }
    int newIndex = _playerList.indexOf(_activePlayer) + 1;

    // Check to see if we need to go back to the start of the playerlist
    if (newIndex == _playerList.length) {
      newIndex = 0;
      _turnNum++;
      _turnLabel.text = "Turn: " + _turnNum.toString();
    }
    if (_turnNum > _turnLimit) {
      _gameOver = true;
      _calcWinner();
      updateButtons();
      return;
    }
    _activePlayer = _playerList[newIndex];
    _nameLabel.text = _activePlayer.name;
    _rollLabel2.text = 'none';
    print(activePlayer.name);

    if (_activePlayer.isComputer) {
      _handleComputerPlayer();
    }
  }

  _calcWinner() {
    Player winner = _playerList[0];
    for (Player player in _playerList) {
      if (player.money > winner.money) winner = player;
    }
    _infoLabel.text = "Winner: " + winner.name;
  }

  _constructButtonControls() {
    _buttons = new List<HtmlElement>();

    _nameLabel = new LabelElement();
    _nameLabel.text = _playerList[0].name;
    _nameLabel.className = 'nameLabel';
    _buttons.add(_nameLabel);

    _turnLabel = new LabelElement();
    _turnLabel.text = "Turn: " + _turnNum.toString();
    _turnLabel.className = 'is-unselectable';
    _buttons.add(_turnLabel);

    _rollLabel1 = new LabelElement();
    _rollLabel1.text = 'Dice Values:';
    _rollLabel1.className = 'is-unselectable';
    _buttons.add(_rollLabel1);

    _rollLabel2 = new LabelElement();
    _rollLabel2.text = 'none';
    _rollLabel2.className = 'is-unselectable';
    _buttons.add(_rollLabel2);

    _rollDiceButton = new ButtonElement();
    _rollDiceButton.text = 'Roll Dice';
    _rollDiceButton.classes = _constructButtonClasses('is-info');
    _rollDiceButton.onClick.listen(handleRollDice);
    _buttons.add(_rollDiceButton);

    _buyPropertyButton = new ButtonElement();
    _buyPropertyButton.text = 'Buy Property';
    _buyPropertyButton.classes = _constructButtonClasses('is-info');
    _buyPropertyButton.disabled = true;
    _buyPropertyButton.onClick.listen(_handleBuyProperty);
    _buttons.add(_buyPropertyButton);

    _auctionPropertyButton = new ButtonElement();
    _auctionPropertyButton.text = 'Auction Property';
    _auctionPropertyButton.classes = _constructButtonClasses('is-info');
    _auctionPropertyButton.disabled = true;
    _auctionPropertyButton.onClick.listen(handleAuctionProperty);
    _buttons.add(_auctionPropertyButton);

    _mortgagePropertyButton = new ButtonElement();
    _mortgagePropertyButton.text = 'Mortgage Property';
    _mortgagePropertyButton.classes = _constructButtonClasses('is-info');
    _mortgagePropertyButton.disabled = true;
    _mortgagePropertyButton.onClick.listen(_handleMortgageProperty);
    _buttons.add(_mortgagePropertyButton);

    _buyBuildingButton = new ButtonElement();
    _buyBuildingButton.text = 'Buy Buildings';
    _buyBuildingButton.classes = _constructButtonClasses('is-info');
    _buyBuildingButton.disabled = true;
    _buyBuildingButton.onClick.listen(_handleBuyBuilding);
    _buttons.add(_buyBuildingButton);

    _sellBuildingButton = new ButtonElement();
    _sellBuildingButton.text = 'Sell Buildings';
    _sellBuildingButton.classes = _constructButtonClasses('is-info');
    _sellBuildingButton.disabled = true;
    _sellBuildingButton.onClick.listen(_handleSellBuilding);
    _buttons.add(_sellBuildingButton);

    _endTurnButton = new ButtonElement();
    _endTurnButton.text = 'End Turn';
    _endTurnButton.disabled = true;
    _endTurnButton.classes = _constructButtonClasses('is-danger');
    _endTurnButton.onClick.listen(_handleEndTurn);
    _buttons.add(_endTurnButton);

    _exampleButton = new ButtonElement();
    _exampleButton.text = 'Setup Example';
    _exampleButton.disabled = false;
    _exampleButton.classes = _constructButtonClasses('is-warning');
    _exampleButton.onClick.listen(_handleExampleSetup);
    _buttons.add(_exampleButton);

    _infoLabel = new LabelElement();
    _infoLabel.text = null;
    _infoLabel.className = 'is-unselectable';
    _buttons.add(_infoLabel);
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

  updateButtons() {
    print("updating buttons");
    //if game is over make all buttons disabled
    if (_gameOver) {
      _rollDiceButton.disabled = true;
      _buyPropertyButton.disabled = true;
      _auctionPropertyButton.disabled = true;
      _mortgagePropertyButton.disabled = true;
      _buyBuildingButton.disabled = true;
      _sellBuildingButton.disabled = true;
      _endTurnButton.disabled = true;
      return;
    }

    //update roll button
    if (_activePlayer.isComputer) {
      _rollDiceButton.disabled = true;
      if (!shouldRollAgain) {
        isRollDiceAvailable = false;
      } else {
        isRollDiceAvailable = true;
      }
    } else {
      if (!shouldRollAgain) {
        _rollDiceButton.disabled = true;
        isRollDiceAvailable = false;
      } else {
        _rollDiceButton.disabled = false;
        isRollDiceAvailable = true;
      }
    }

    //update buy property button & auction property button

    if (_activePlayer.isComputer) {
      _buyPropertyButton.disabled = true;
      _auctionPropertyButton.disabled = true;
      Tile curTile = _board.tiles[_activePlayer.position];
      if (curTile.owner == null &&
          (curTile.type == 'Street' || curTile.type == 'Railroad' || curTile.type == 'Utility')) {
        isBuyPropertyAvailable = true;
        isAuctionPropertyAvailable = true;
      } else {
        isBuyPropertyAvailable = false;
        isAuctionPropertyAvailable = false;
      }
      //if player doesn't have enough money
      if (_activePlayer.money < curTile.price) {
        isBuyPropertyAvailable = false;
      }
    } else {
      Tile curTile = _board.tiles[_activePlayer.position];
      if (curTile.owner == null &&
          (curTile.type == 'Street' || curTile.type == 'Railroad' || curTile.type == 'Utility')) {
        _buyPropertyButton.disabled = false;
        isBuyPropertyAvailable = true;
        _auctionPropertyButton.disabled = false;
        isAuctionPropertyAvailable = true;
      } else {
        _buyPropertyButton.disabled = true;
        isBuyPropertyAvailable = false;
        _auctionPropertyButton.disabled = true;
        isAuctionPropertyAvailable = false;
      }
      //if player doesn't have enough money
      if (_activePlayer.money < curTile.price) {
        _buyPropertyButton.disabled = true;
        isBuyPropertyAvailable = false;
      }
    }

    //update mortgage button
    if (_activePlayer.isComputer) {
      _mortgagePropertyButton.disabled = true;
      if (_activePlayer.ownedTiles.length > 0) {
        isMortgagePropertyAvailable = true;
      } else {
        isMortgagePropertyAvailable = false;
      }
    } else {
      if (_activePlayer.ownedTiles.length > 0) {
        _mortgagePropertyButton.disabled = false;
        isMortgagePropertyAvailable = true;
      } else {
        _mortgagePropertyButton.disabled = true;
        isMortgagePropertyAvailable = false;
      }
    }

    //update buy building button
    if (activePlayer.isComputer) {
      _buyBuildingButton.disabled = true;
      _sellBuildingButton.disabled = true;
      _endTurnButton.disabled = true;
      Tile curTile = _board.tiles[_activePlayer.position];
      bool canBuild = false;
      bool canSellBuildings = false;
      for (Tile tile in _activePlayer.ownedTiles) {
        if (tile.numBuildings > 0) {
          canBuild = true;
          canSellBuildings = true;
          break;
        }
        if (tile.isInMonopoly) {
          canBuild = true;
          break;
        }
      }
      if (canBuild) {
        isBuyBuildingsAvailable = true;
      } else {
        isBuyBuildingsAvailable = false;
      }
      if (canSellBuildings) {
        isSellBuildingsAvailable = true;
      } else {
        isSellBuildingsAvailable = false;
      }

      //update end turn button
      if (shouldRollAgain ||
          (curTile.owner == null &&
              (curTile.type == 'Street' || curTile.type == 'Railroad' || curTile.type == 'Utility'))) {
        isEndTurnAvailable = false;
      } else {
        isEndTurnAvailable = true;
      }
    } else {
      Tile curTile = _board.tiles[_activePlayer.position];
      bool canBuild = false;
      bool canSellBuildings = false;
      for (Tile tile in _activePlayer.ownedTiles) {
        if (tile.numBuildings > 0) {
          canBuild = true;
          canSellBuildings = true;
          break;
        }
        if (tile.isInMonopoly) {
          canBuild = true;
          break;
        }
      }
      if (canBuild) {
        _buyBuildingButton.disabled = false;
        isBuyBuildingsAvailable = true;
      } else {
        _buyBuildingButton.disabled = true;
        isBuyBuildingsAvailable = false;
      }
      if (canSellBuildings) {
        _sellBuildingButton.disabled = false;
        isSellBuildingsAvailable = true;
      } else {
        _sellBuildingButton.disabled = true;
        isSellBuildingsAvailable = false;
      }
      //update end turn button
      if (shouldRollAgain ||
          (curTile.owner == null &&
              (curTile.type == 'Street' || curTile.type == 'Railroad' || curTile.type == 'Utility'))) {
        _endTurnButton.disabled = true;
        isEndTurnAvailable = false;
      } else {
        _endTurnButton.disabled = false;
        isEndTurnAvailable = true;
      }
    }
  }

  handleRollDice(_) {
    int rollDieOne = _random.nextInt(6) + 1;
    int rollDieTwo = _random.nextInt(6) + 1;
    rollValue = rollDieOne + rollDieTwo;
    // Sets should roll again if the dice are the same value
    shouldRollAgain = rollDieOne == rollDieTwo;
    _activePlayer.move(rollValue);
    _rollLabel2.text =
        "${shouldRollAgain ? 'Double ' + rollDieOne.toString() + '\'s' : rollDieOne.toString() + '&' + rollDieTwo.toString()}";

    //pay rent if necessary
    Tile curTile = _board.tiles[_activePlayer.position];
    if (curTile.owner != null && curTile.owner != _activePlayer) {
      int amount = _activePlayer.payRent(curTile.owner, curTile, rollValue);
      _infoLabel.text = 'Paid ' + curTile.owner.name + ' \$' + amount.toString() + '.';
    }
    //display cost if unowned
    else if (curTile.owner == null &&
        (curTile.type == 'Street' || curTile.type == 'Railroad' || curTile.type == 'Utility'))
      _infoLabel.text = 'Cost: \$' + curTile.price.toString();
    //otherwise display nothing
    else {
      _infoLabel.text = null;
    }
    updateButtons();
  }

  _handleComputerPlayer() async {
    print("handle comp player");
    if (activePlayer.isComputer) {
      print("deactivate buttons");
      _rollDiceButton.disabled = true;
      _buyPropertyButton.disabled = true;
      _auctionPropertyButton.disabled = true;
      _mortgagePropertyButton.disabled = true;
      _buyBuildingButton.disabled = true;
      _sellBuildingButton.disabled = true;
      _endTurnButton.disabled = true;
      print("comp turn");
      await computer.computerTurn();

      if (!shouldRollAgain) {
        print("comp turn end");
        //activePlayer.isComputer = false;
        shouldRollAgain = true;
        nextPlayer();
        updateButtons();
      } else {
        print("comp turn roll again");
        await _handleComputerPlayer();
      }
    }
  }

  _handleBuyProperty(_) {
    _activePlayer.buyTile(_board.tiles[_activePlayer.position]);
    renderer.drawBackground();
    updateButtons();
  }

  _handleEndTurn(_) {
    print("end of turn");
    shouldRollAgain = true;
    _infoLabel.text = null;
    updateButtons();
    nextPlayer();
  }

  handleAuctionProperty(_) {
    print("handel auction prop");
    new ModalBuilder.auctionModal(
        "Auction", _board.tiles[_activePlayer.position], _playerList, _activePlayer, this, renderer);
    updateButtons();
  }

  _handleMortgageProperty(_) {
    //_displayListModal
    _modalComponent = new ModalBuilder.listModal(
        "Choose a tile - Mortgage", _activePlayer.ownedTiles, _handleMortgage, this, renderer,
        mortgage: true);
    updateButtons();
  }

  handleComputerMortgageProperty(_) {
    for (int i; i < _activePlayer.ownedTiles.length;) {
      if (!_activePlayer.ownedTiles[i].isMortgaged) {
        _activePlayer.ownedTiles[i].isMortgaged = true;
        _activePlayer.money -= _activePlayer.ownedTiles[i].mortgageCost;
        break;
      } else {
        i++;
      }
    }
    updateButtons();
  }

  _handleBuyBuilding(_) {
    List<Tile> filteredList = new List<Tile>();
    for (Tile tile in _activePlayer.ownedTiles) {
      if (tile.isInMonopoly && tile.numBuildings < 5) filteredList.add(tile);
    }
    _modalComponent = new ModalBuilder.listModal(
        "Choose a tile - Buy Building", filteredList, _handleBuildingPurchase, this, renderer,
        showNumBuildings: true);
    updateButtons();
  }

  _handleSellBuilding(_) {
    List<Tile> filteredList = new List<Tile>();
    for (Tile tile in _activePlayer.ownedTiles) {
      if (tile.numBuildings > 0) filteredList.add(tile);
    }
    _modalComponent = new ModalBuilder.listModal(
        "Choose a tile - Sell Building", filteredList, _handleBuildingSell, this, renderer,
        showNumBuildings: true);

    updateButtons();
  }

  ////////////
  /// Modal handlers
  ////////////

  // Modal click handlers

  _handleMortgage(MouseEvent event) {
    Element target = event.target;
    for (Tile tile in _activePlayer.ownedTiles)
      if (target.classes.contains("tile-action-${tile.hashCode}")) {
        _activePlayer.toggleMortgage(tile);
        _modalComponent.closeModal();
        _modalComponent = null;
      }
  }

  _handleBuildingPurchase(MouseEvent event) {
    Element target = event.target;
    for (Tile tile in _activePlayer.ownedTiles)
      if (target.classes.contains("tile-action-${tile.hashCode}")) {
        _activePlayer.buyBuilding(tile);
        _modalComponent.closeModal();
        _modalComponent = null;
      }
  }

  _handleBuildingSell(MouseEvent event) {
    Element target = event.target;
    for (Tile tile in _activePlayer.ownedTiles)
      if (target.classes.contains("tile-action-${tile.hashCode}")) {
        _activePlayer.sellBuilding(tile);
        _modalComponent.closeModal();
        _modalComponent = null;
      }
  }

  _handleExampleSetup(_) {
    _playerList[0].buyTile(_board.tiles[1], 0);
    _playerList[0].buyTile(_board.tiles[3], 0);
    _board.tiles[1].addBuilding();
    _board.tiles[3].addBuilding();
    renderer.drawBackground();
    updateButtons();
  }
}
