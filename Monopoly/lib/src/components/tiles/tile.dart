import 'dart:html';
import '../player/player.dart';

class Tile {
  //general
  String _name, _type, _color;
  int _position, _price, _buildPrice, _baseRent, _rent1, _rent2, _rent3, _rent4, _rent5, _totalNum, _mortgageCost, _x, _y, _width, _height, _numberOwned, _rollVal;
  bool _isMortgaged, _isInMonopoly;
  Player _owner;

  // Tile constructor - adds a tile with name, type of tile, color, position on
  // board, price to buy, price to build, base rent (without buildings), the
  // rent amount for each building configuration, the number of the color of
  // tile, the mortgage cost of the tile, the number of the monopoly owned, and
  // flags for if it is mortgaged or in a monopoly
  Tile(List<String> attr, this._x, this._y, this._width, this._height) {
    this._name = attr.elementAt(0);
    this._type = attr.elementAt(1);
    this._color = attr.elementAt(2);
    this._position = int.parse(attr.elementAt(3));
    this._price = int.parse(attr.elementAt(4));
    this._buildPrice = int.parse(attr.elementAt(5));
    this._baseRent = int.parse(attr.elementAt(6));
    this._rent1 = int.parse(attr.elementAt(7));
    this._rent2 = int.parse(attr.elementAt(8));
    this._rent3 = int.parse(attr.elementAt(9));
    this._rent4 = int.parse(attr.elementAt(10));
    this._rent5 = int.parse(attr.elementAt(11));
    this._totalNum = int.parse(attr.elementAt(12));
    this._mortgageCost = (this._price / 2).round();
    this._numberOwned = 0;
    this._isMortgaged = false;
    this._isInMonopoly = false;
  }

  // Getters
  //general
  String get name => _name;
  String get color => _color;
  //board.csv does not have the mortgage values
  int get mortgageCost => _mortgageCost;
  bool get isMortgaged => _isMortgaged;
  int get price => _price;
  int get x => _x;
  int get y => _y;
  int get width => _width;
  int get height => _height;
  Player get owner => _owner;

  //property specific
  int get buildPrice => _buildPrice;
  bool get isInMonopoly => _isInMonopoly;

  // Setter for setting owner
  setOwner(Player newOwner) => _owner = newOwner;
  setLocation(int x, int y) {
    _x = x;
    _y = y;
  }

  setSize(int width, int height){
    _width = width;
    _height = height;
  }

  draw(CanvasRenderingContext2D ctx) {
    if(_color == 'None')
      ctx.fillStyle = 'white';
    else
      ctx.fillStyle = _color;
    ctx.strokeStyle = 'black';
    ctx.textAlign = 'center';

    ctx.strokeRect(_x, _y, _width, _height); //draw tile boarder
    ctx.fillRect(_x, _y, _width, _height);   //draw tile color
    ctx.strokeText(name, _x+_width/2, _y+(9*_height)/10); //write name 9/10 of the way down the tile
  }

  //calulates the rent for each type of tile
  calcRent() {
    switch (_type) {
      case 'Street':
        /* need info from board.csv to get rentBuild1, rentBUild2,...
        if (_numBuildings = null) {
          return _baseRent;
        } else if (_numBuildings == 1) {
          return rentBuild1;
        } else if (_numBuildings == 2) {
          return rentBuild2;
        } else if (_numBuildings == 3) {
          return rentBuild3;
        } else if (_numBuildings == 4) {
          return rentBuild4;
        } else if (_numBuildings == 5) {
          return rentBuild5;
        } else {
          String error = 'error';
          print(error);
        }
        */
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
