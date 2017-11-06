import 'dart:html';
import '../player/player.dart';

class Tile {
  //general
  final String _name;
  final String _color;
  final int _price;
  final int _baseRent;
  final int _mortgageCost;
  int _x;
  int _y;
  int _size;
  bool _isMortgaged = false;
  Player _owner;
  int _numberOwned;
  String _type;
  int _rollVal;

  //property specific
  final int _buildingPrice;
  int _numBuildings;
  bool _isInMonopoly = false;

  // Tile constructor
  Tile(this._name, this._x, this._y, this._size, this._color, this._price,
      this._baseRent, this._mortgageCost, this._buildingPrice);

  // Getters
  //general
  String get name => _name;
  String get color => _color;
  //board.csv does not have the mortgage values
  int get mortgageCost => _mortgageCost;
  bool get isMortgaged => _isMortgaged;
  int get price => _price;
  int get x => _x;
  int get y => y;
  Player get owner => _owner;

  //property specific
  int get buildingPrice => _buildingPrice;

  bool get isInMonopoly => _isInMonopoly;

  // Setter for setting owner
  set owner(Player newOwner) => _owner = newOwner;
  setLocation(int x, int y) {
    _x = x;
    _y = y;
  }

  setSize(int size) => _size = size;

  draw(CanvasRenderingContext2D ctx) {
    ctx.strokeStyle = 'red';
    ctx.strokeRect(_x, _y, _size, _size);
  }

  //calulates the rent for each type of tile
  calcRent() {
    switch (_type) {
      case 'Street':
        if (_numberOwned = null) {
          return _baseRent;
        } else if (_numberOwned == 1) {
          return _rent1;
        } else if (_numberOwned == 2) {
          return _rent2;
        } else if (_numberOwned == 3) {
          return _rent3;
        } else if (_numberOwned == 4) {
          return _rent4;
        } else if (_numberOwned == 5) {
          return _rent5;
        } else {
          String error = 'error';
          print(error);
        }
        break;

      case 'Railroad':
        if (_numberOwned == 1) {
          return _baseRent;
        } else if (_numberOwned == 2) {
          return 50;
        } else if (_numberOwned == 3) {
          return 100;
        } else if (_numberOwned == 3) {
          return 200;
        } else {
          String error = 'error';
          print(error);
        }
        break;

      case 'Utility':
        if (_numberOwned == 1) {
          return _rollVal * 4;
        } else if (_numberOwned == 2) {
          return _rollVal * 10;
        }
        break;

      case 'Special':
        break;
    }
  }
}
