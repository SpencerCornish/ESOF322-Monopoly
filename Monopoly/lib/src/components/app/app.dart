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

  ButtonElement _rollDiceButton;
  ButtonElement _buyPropertyButton;

  Board _board = new Board();

  App() {
    _rollDiceButton = new ButtonElement();
    _rollDiceButton.text = 'Roll Dice';
    _buttons.add(_rollDiceButton);

    _buyPropertyButton = new ButtonElement();
    _buyPropertyButton.text = 'Buy Property';
    _buttons.add(_buyPropertyButton);

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

    // Instantiate a board
    // Board should parse CSV file for tile data and create tiles
    // Board should hold a list of players in jail?

    // Instantiate players
    // Player should instantiate game_pieces/banks

    _rollDiceButton.onClick.listen((e) => print('roll the dice'));
    _buyPropertyButton.onClick.listen((e) => print('buy the property'));

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
    for(ButtonElement button in _buttons)
      querySelector('#buttons').children.add(button);
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

  _buildBoard(String boardCsv) {}
}
