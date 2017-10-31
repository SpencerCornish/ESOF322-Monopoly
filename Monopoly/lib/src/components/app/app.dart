import 'dart:html';
import 'dart:async';

import '../player/player.dart';
import '../board/board.dart';
import '../tiles/tile.dart';

CanvasElement _canvasBackground = querySelector("#canvas-background");
CanvasRenderingContext2D _ctxBackground = _canvasBackground.getContext('2d');

CanvasElement _canvasForeground = querySelector("#canvas-foreground");
CanvasRenderingContext2D _ctxForeground = _canvasForeground.getContext('2d');

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

    Timer loadingSplashScreenTimeout =
        new Timer(new Duration(seconds: 1), _beginDraw);
  }

  _beginDraw() {
    querySelector('#output').text = 'Your Dart app is running.';
    _ctxBackground.fillStyle = 'red';
    _ctxBackground.fillRect(100, 100, 250, 250);
    _ctxForeground.fillStyle = 'green';
    _ctxForeground.fillRect(100, 100, 200, 200);
    Tile tile = new Tile("Bro", 2);
    tile.draw(_ctxForeground);
  }

  _drawForeground() {}
  _drawBackground() {}
  _addPlayers() {
    // Create 4 mock players
    for (int i = 0; i < 4; i++) {
      Player newPlayer = new Player();
      _playerList.add(newPlayer);
    }
  }

  _buildBoard(String boardCsv) {}
}
