import 'dart:html';
import 'dart:async';

CanvasElement canvas = querySelector("#canvas");
CanvasRenderingContext2D ctx = canvas.getContext('2d');

void main() {
  canvas.width = window.innerWidth;
  canvas.height = window.innerHeight;

  Timer tempLoadingTimeout = new Timer(new Duration(seconds: 4), _changeStuff);
}

void _changeStuff() {
  querySelector('#output').text = 'Your Dart app is running.';
  ctx.fillStyle = 'red';
  ctx.fillRect(100, 100, 250, 250);
}
