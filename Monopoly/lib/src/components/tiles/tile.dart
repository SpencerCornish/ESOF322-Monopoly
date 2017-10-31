import 'dart:html';
import '../player/player.dart';

class Tile {
  final String _name;

  final int _x;
  final int _y;
  final int _size;

  Player _owner;

  // Tile constructor

  Tile(this._name, this._x, this._y, this._size);

  // Getters
  String get name => _name;
  int get x => _x;
  int get y => y;
  Player get owner => _owner;

  // Setter for setting owner
  setOwner(Player newOwner) => _owner = newOwner;

  draw(CanvasRenderingContext2D ctx) {
    ctx.strokeStyle = 'red';
    ctx.strokeRect(_x, _y, _size, _size);
  }
}
