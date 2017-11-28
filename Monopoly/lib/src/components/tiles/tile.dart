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
      _numBuildings, //number of buildings built on the property
      _currentRent; //rent multiplier currently

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
    this._numBuildings = 0;
    this._currentRent = this._baseRent;
  }

  //Getters
  //general
  String get name => _name;
  String get color => _color;
  String get type => _type;
  int get mortgageCost => _mortgageCost;
  bool get isMortgaged => _isMortgaged;
  int get price => _price;
  int get x => _x;
  int get y => _y;
  int get width => _width;
  int get height => _height;
  int get position => _position;
  //property specific
  int get buildPrice => _buildPrice;
  bool get isInMonopoly => _isInMonopoly;
  int get baseRent => _baseRent;
  int get totalNum => _totalNum;
  int get rent1 => _rent1;
  int get rent2 => _rent2;
  int get rent3 => _rent3;
  int get rent4 => _rent4;
  int get rent5 => _rent5;
  int get currentRent => _currentRent;
  int get numBuildings => _numBuildings;
  Player get owner => _owner;

  // Setter for setting owner
  setOwner(Player newOwner) {
    _owner = newOwner;
    _numberOwned++; //update this counter for all the same color
  }

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
    calcRent(0);
  }

  //calulates the rent for each type of tile
  calcRent(int rollVal) {
    if (_isMortgaged) return 0;

    switch (_type) {
      case "Street":
        {
          if (_numBuildings == 0) {
            if (_isInMonopoly) {
              _currentRent = _baseRent * 2;
            } else
              _currentRent = _baseRent;
          } else if (_numBuildings == 1) {
            _currentRent = rent1;
          } else if (_numBuildings == 2) {
            _currentRent = rent2;
          } else if (_numBuildings == 3) {
            _currentRent = rent3;
          } else if (_numBuildings == 4) {
            _currentRent = rent4;
          } else if (_numBuildings == 5) {
            _currentRent = rent5;
          } else {
            String error = 'error';
            print(error);
          }
          break;
        }
      case "Railroad":
        {
          if (_numberOwned == 1) {
            _currentRent = _baseRent;
          } else if (_numberOwned == 2) {
            _currentRent = 50;
          } else if (_numberOwned == 3) {
            _currentRent = 100;
          } else if (_numberOwned == 4) {
            _currentRent = 200;
          } else {
            String error = 'error';
            print(error);
          }
          break;
        }
      case "Utility":
        {
          if (_numberOwned == 1) {
            _currentRent = rollVal * 4;
          } else if (_numberOwned == 2) {
            _currentRent = rollVal * 10;
          }
          break;
        }
      default:
        {
          _currentRent = 0;
          break;
        }
    }
    return _currentRent;
  }

  /*
  draw(CanvasRenderingContext2D ctx) {
    ctx.fillStyle = _color == 'None' ? 'White' : _color;
    ctx.strokeStyle = 'black';
    ctx.textAlign = 'center';

    ctx.strokeRect(_x, _y, _width, _height); //draw tile boarder
    ctx.fillRect(_x, _y, _width, _height); //draw tile color

    //draw indicator if tile is mortgaged
    if (_isMortgaged) {
      ctx.fillStyle = 'black';
      ctx.font = '14pt sans-serif';
      ctx.fillText('M', _x + 9 * _width / 10, _y + _height / 5);
    }

    //draw owner's name
    ctx.fillStyle = 'black';
    ctx.font = '8pt sans-serif';
    if (_owner != null)
      ctx.fillText('Owner: ' + owner.name, _x + _width / 2,
          _y + 7 * height / 10); //draw owner's name

    //write name of tile
    ctx.font = 'bold 8pt sans-serif';
    ctx.fillText(name, _x + _width / 2, _y + 9 * height / 10);

    //draw buildings
    if (numBuildings == 5) {
      ctx.fillStyle = 'red';
      ctx.fillRect(_x + _width / 2 - 10, y + height / 10, 20, 10);
    } else {
      for (int i = 0; i < numBuildings; i++) {
        ctx.fillStyle = 'green';
        ctx.fillRect(_x + ((i + 1) / 5) * _width - 5, _y + height / 10, 10, 10);
      }
    }
  } */
}
