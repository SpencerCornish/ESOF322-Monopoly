import 'dart:html';
import '../player/player.dart';

class Tile {
  final String _name;

  final int _location;

  Player _owner;

  // Tile constructor

  Tile(this._name, this._location);

  // Getters
  String get name => _name;
  int get location => _location;
  Player get owner => _owner;

  // Setter for setting owner
  setOwner(Player newOwner) => _owner = newOwner;

  draw() {
    CanvasElement canvas = new CanvasElement(100, 100);
    CanvasRenderingContext2D ctx = canvas.getContext('2d');
    ctx.rect(0, 0, 100, 100);
    return canvas;
  }
}
