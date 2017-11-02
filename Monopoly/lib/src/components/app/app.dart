import 'dart:html';
import 'dart:async';

import '../player/player.dart';
import '../board/board.dart';

CanvasElement _canvasBackground = querySelector("#canvas-background");
CanvasRenderingContext2D _ctxBackground = _canvasBackground.getContext('2d');

CanvasElement _canvasForeground = querySelector("#canvas-foreground");
CanvasRenderingContext2D _ctxForeground = _canvasForeground.getContext('2d');

Board _board = new Board();

void main() {
  App app = new App();
}

class App {
  List<Player> _playerList;
  //Board _gameBoard;

  App() {
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
    querySelector('#output').text = 'Your Dart app is running.';
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
