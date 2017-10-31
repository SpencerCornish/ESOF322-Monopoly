import 'dart:html';
import 'dart:async';

CanvasElement canvas = querySelector("#canvas");
CanvasRenderingContext2D ctx = canvas.getContext('2d');

class App {
  App() {
    canvas.width = window.innerWidth ?? 1024;
    canvas.height = window.innerHeight ?? 768;

    Timer tempLoadingTimeout =
        new Timer(new Duration(seconds: 4), _changeStuff);
  }

  _changeStuff() {
    querySelector('#output').text = 'Your Dart app is running.';
    ctx.fillStyle = 'red';
    ctx.fillRect(100, 100, 250, 250);
  }
}
