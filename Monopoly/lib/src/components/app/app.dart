import 'dart:html';
import 'dart:async';

import '../player/player.dart';
import '../board/board.dart';

void main() {
  App app = new App();
}

class App {
  List<Player> _playerList;
  //Board _gameBoard;

  CanvasElement _canvasBackground;
  CanvasRenderingContext2D _ctxBackground;

  CanvasElement _canvasForeground;
  CanvasRenderingContext2D _ctxForeground;

  List<HtmlElement> _buttons = new List<HtmlElement>();

  LabelElement _statusLabel;

  // Top button control refs
  LinkElement _rollDiceButton;
  LinkElement _buyPropertyButton;
  LinkElement _auctionPropertyButton;
  LinkElement _endTurnButton;

  // Bottom button control refs
  LinkElement _mortgagePropertyButton;
  LinkElement _buildBuildingButton;
  LinkElement _buyBuildingButton;
  LinkElement _sellBuildingButton;

  Board _board = new Board();

  App() {
    _constructButtonControls();
    // Instantiate a board
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

    Timer loadingSplashScreenTimeout = new Timer(new Duration(seconds: 1), _beginDraw);
  }

  _beginDraw() {
    _ctxBackground.clearRect(0, 0, window.innerWidth, window.innerHeight);
    _ctxForeground.clearRect(0, 0, window.innerWidth, window.innerHeight);
    querySelector('#output').text = '';
    for (ButtonElement button in _buttons) querySelector('.top-button-container').children.add(button);
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

  _constructButtonControls() {
    _statusLabel = new LabelElement();
    _statusLabel.text = ':)';
    _statusLabel.className = 'is-unselectable';
    _buttons.add(_statusLabel);

    _rollDiceButton = new LinkElement();
    _rollDiceButton.text = 'Roll Dice';
    _rollDiceButton.classes = _constructButtonClasses('is-info');
    _rollDiceButton.onClick(_rollDice);
    _buttons.add(_rollDiceButton);

    _buyPropertyButton = new LinkElement();
    _buyPropertyButton.text = 'Buy Tile';
    _buyPropertyButton.classes = _constructButtonClasses('is-static');
    _rollDiceButton.onClick(_rollDice);
    _buttons.add(_buyPropertyButton);

    _auctionPropertyButton = new LinkElement();
    _auctionPropertyButton.text = 'Auction Tile';
    _auctionPropertyButton.classes = _constructButtonClasses('is-static');
    _rollDiceButton.onClick(_rollDice);
    _buttons.add(_auctionPropertyButton);

    _endTurnButton = new LinkElement();
    _endTurnButton.text = 'End Turn';
    _endTurnButton.classes = _constructButtonClasses('is-danger');
    _rollDiceButton.onClick(_rollDice);
    _buttons.add(_endTurnButton);

    _mortgagePropertyButton = new LinkElement();
    _mortgagePropertyButton.text = 'Mortgage Tiles';
    _rollDiceButton.classes = _constructButtonClasses('is-info');
    _rollDiceButton.onClick(_rollDice);
    _buttons.add(_mortgagePropertyButton);

    _buyBuildingButton = new LinkElement();
    _buyBuildingButton.text = 'Buy Buildings';
    _buyBuildingButton.classes = _constructButtonClasses('is-info');
    _rollDiceButton.onClick(_rollDice);
    _buttons.add(_buyBuildingButton);

    _sellBuildingButton = new LinkElement();
    _sellBuildingButton.text = 'Sell Buildings';
    _sellBuildingButton.classes = _constructButtonClasses('is-static');
    _rollDiceButton.onClick(_rollDice);
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
  _buildBoard(String boardCsv) {}

  _rollDice() {}
}
