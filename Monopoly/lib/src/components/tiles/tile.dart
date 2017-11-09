import 'dart:html';
import '../player/player.dart';

class Tile {
  //general
  String _name, _type, _color;
  int _position, //position of tile on board
      _price, //price to buy tile
      _buildPrice, //price to build on this tile
      _baseRent, //rent of tile without monopoly or building
      _rent1,
      _rent2,
      _rent3,
      _rent4,
      _rent5, //rents of upgraded tile
      _totalNum, //number of tiles of this type
      _mortgageCost, //money gained from mortgaging this tile
      _x,
      _y, //x and y location of tile on canvas
      _width,
      _height, //width and height of tile in pixels
      _numberOwned, //number of this type of tile the owner owns
      _numBuildings, //number of buildings owned
      _currentRent; //current rent of property

  bool _isMortgaged, //if this tile is mortgaged
      _isInMonopoly; //if the owner owns all tiles of this type
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
  String get type => _type;
  bool get isInMonopoly => _isInMonopoly;
  int get mortgageCost => _mortgageCost;
  bool get isMortgaged => _isMortgaged;
  int get price => _price;
  int get x => _x;
  int get y => _y;
  int get width => _width;
  int get height => _height;
  Player get owner => _owner;
  int get numBuildings => _numBuildings;
  int get totalNum => _totalNum;
  //property specific
  int get buildPrice => _buildPrice;

  // Setter for setting owner
  set owner(Player newOwner) => _owner = newOwner;
  set isInMonopoly(bool value) => _isInMonopoly = value;
  set isMortgaged(bool value) => _isMortgaged = value;
  set numBuildings(int buildings) => _numBuildings = buildings;

  setLocation(int x, int y) {
    _x = x;
    _y = y;
  }

  setSize(int width, int height) {
    _width = width;
    _height = height;
  }

  addBuilding() {
    _numBuildings++;
  }

  //calulates the rent for each type of tile
  calcRent(int rollVal) {
    switch (_type) {
      case 'Street':
        if (_numBuildings == 0) {
          if (_isInMonopoly) {
            return _baseRent * 2;
          } else {
            return _baseRent;
          }
        } else if (_numBuildings == 1) {
          return _rent1;
        } else if (_numBuildings == 2) {
          return _rent2;
        } else if (_numBuildings == 3) {
          return _rent3;
        } else if (_numBuildings == 4) {
          return _rent4;
        } else if (_numBuildings == 5) {
          return _rent5;
        } else {
          String error = 'error';
          print(error);
        }
        break;

      case 'Railroad':
        if (owner.numRailroads == 1) {
          return _baseRent;
        } else if (owner.numRailroads == 2) {
          return 50;
        } else if (owner.numRailroads == 3) {
          return 100;
        } else if (owner.numRailroads == 3) {
          return 200;
        } else {
          String error = 'error';
          print(error);
        }
        break;

      case 'Utility':
        if (owner.numUtilities == 1) {
          return rollVal * 4;
        } else if (owner.numUtilities == 2) {
          return rollVal * 10;
        }
        break;

      case 'mortgaged':
        if (_isMortgaged) {
          return null;
        }
        break;
    }
  }

  draw(CanvasRenderingContext2D ctx) {
    ctx.fillStyle = _color == 'None' ? 'White' : _color;
    ctx.strokeStyle = 'black';
    ctx.textAlign = 'center';

    ctx.strokeRect(_x, _y, _width, _height); //draw tile boarder
    ctx.fillRect(_x, _y, _width, _height); //draw tile color
    ctx.fillStyle = 'black';
    ctx.font = '8pt sans-serif';
    ctx.fillText(name, _x + _width / 2,
        _y + (9 * _height) / 10); //write name 9/10 of the way down the tile
  }
}
