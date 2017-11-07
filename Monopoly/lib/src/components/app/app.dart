import 'dart:html';
import 'dart:async';

import '../player/player.dart';
import '../board/board.dart';

void main() {
  App app = new App();
}

class App {
  List<Player> _playerList = new List<Player>();

  CanvasElement _canvasBackground;
  CanvasRenderingContext2D _ctxBackground;

  CanvasElement _canvasForeground;
  CanvasRenderingContext2D _ctxForeground;
  Board _board = new Board();
  bool _isStarted = false;

  App() {
    _canvasBackground = querySelector("#canvas-background");
    _ctxBackground = _canvasBackground.getContext('2d');

    _canvasForeground = querySelector("#canvas-foreground");
    _ctxForeground = _canvasForeground.getContext('2d');
    _board = new Board();

    // Background canvas setup
    _canvasBackground.width = window.innerWidth ?? 1024;
    _canvasBackground.height = window.innerHeight ?? 768;
    // Foreground canvas setup
    _canvasForeground.width = window.innerWidth ?? 1024;
    _canvasForeground.height = window.innerHeight ?? 768;

    _playerList.add(new Player("Bryan", 10, 0, 'blue', _board));
    _playerList.add(new Player("Nate", 10, 1, 'green', _board));
    _playerList.add(new Player("Keely", 10, 2, 'orange', _board));
    _playerList.add(new Player("Spencer", 10, 3, 'red', _board));
    _playerList.add(new Player("Keely", 10, 4, 'pink', _board));
    _playerList.add(new Player("Spencer", 10, 5, 'brown', _board));

    window.onResize.listen((e) {
      _canvasBackground.width = window.innerWidth;
      _canvasBackground.height = window.innerHeight;
      _canvasForeground.width = window.innerWidth;
      _canvasForeground.height = window.innerHeight;

      _board.resize();
      _drawBackground();
    });

    Timer loadingSplashScreenTimeout =
        new Timer(new Duration(seconds: 1), _beginDraw);
    new Timer.periodic(new Duration(milliseconds: 20), (Timer t) {
      _drawForeground();
    });
  }

  _beginDraw() {
    _ctxBackground.clearRect(0, 0, window.innerWidth, window.innerHeight);
    _ctxForeground.clearRect(0, 0, window.innerWidth, window.innerHeight);
    querySelector('#output').text = 'Your Dart app is running.';
    _board.draw(_ctxBackground);
    _isStarted = true;
  }

  _drawForeground() {
    if (_isStarted){
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

}
