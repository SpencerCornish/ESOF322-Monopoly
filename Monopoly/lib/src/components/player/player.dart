import '../tiles/tile.dart';
import 'dart:math';
import 'dart:html';

import 'package:monopoly/src/components/board/board.dart';

class Player {
  Random rand = new Random();
  Board _board;
  String _name;
  int _number;
  String _color;
  int _size;
  // Token Type: Enum here?
  int _money;
  int _numDoubles = 0;
  int _currentLocation = 0;
  List<Tile> _ownedTiles;
  bool _inJail = false;
  int _rollValue;
  int _numRailroads = 0;
  int _numUtilities = 0;

  int get money => _money;
  String get name => _name;
  //TODO get token
  int get position => _currentLocation;
  List<Tile> get ownedTiles  => _ownedTiles;

  Player(this._name, this._size, this._number, this._color, this._board) {
    _money = 1500;
    _ownedTiles = new List<Tile>();
  }

  //player rolls dice and moves position
  void move(int rollValue) {
    int nextLocation = _currentLocation + rollValue;

    if (nextLocation > 39) {
      //if the player has landed on or passed go
      nextLocation = nextLocation - 40;
      _money += 200;
    }
    _currentLocation = nextLocation;
  }

  void updateMonopoly(Tile tile) {
    List<Tile> count = new List<Tile>();
    for (Tile curTile in _ownedTiles) {
      if (curTile.color == _color) {
        count.add(curTile);
      }
      if (count.length == tile.totalNum) {
        for (Tile newMonopTile in count) newMonopTile.isInMonopoly = true;
      }
      for (Tile curTile in _board.tiles) {
        if (curTile.color == _color) {
          curTile.isInMonopoly = false;
        }
      }
    }
  }

  void buyTile(Tile tile) {
    if (tile.type == 'Railroad') {
      _numRailroads++;
    } else if (tile.type == 'Utility') {
      _numUtilities++;
    } else if (tile.type == 'Street') {
      updateMonopoly(tile);
    }
    tile.owner = this;
    _ownedTiles.add(tile);
    _money -= tile.price;
    for (int i = 0; i < _ownedTiles.length; i++)
      print(_ownedTiles[i].name);
  }

  mortgageTile(Tile tile) {
    tile.isMortgaged = true;
    _money += tile.mortgageCost;
  }

  void buyBuilding(Tile tile, int numHouse) {
    if (tile.isInMonopoly) {
      if (tile.numBuildings < 4) {
        for (int i = 0; i < numHouse; i++) {
          //build num houses player wants to buy
          _money -= tile.buildPrice; //subtract build price
          tile.addBuilding(); //add a building count on tile
        }
      } else if (tile.numBuildings == 4) {
        //build hotel
        _money -= tile.buildPrice; //subtract build price
        tile.addBuilding(); //add a building to count on tile
      } else {
        print(
            "ERROR: Max number of buildings reached. You cannot build anymore on this property");
      }
    } else
      print("ERROR: Property not in a monopoly. you cannont build");
  }

  void sellBuilding(Tile tile) {
    tile.numBuildings - 1;
    _money += (tile.buildPrice / 2).round();
  }

  void set name(String n) {
    _name = n;
  }

  void setToken(var token) {
    //TODO
  }

  void payRent(Player owner, Player renter, Tile tile) {
    int _rent = tile.calcRent(_rollValue);
    renter._money -= _rent;
    owner._money += _rent;
    //owner.getPaid(tile.calcRent(_rollValue));
  }


  void tradeProperty(Player seller, Player buyer, Tile tile, int tradeAmount) {
    //TODO trade tile for tile
    //TODO tradt hybrid for tile
    this._ownedTiles.remove(tile);

    seller._money += tradeAmount;

    buyer.buyTile(tile);
    buyer._money -= tradeAmount;

    if (tile.isMortgaged) {
      String _choice;
      switch (_choice) {
        case 'repay mortgage':
          _money -= tile.mortgageCost;
          break;
        case 'keep mortgaged':
          _money -= (tile.mortgageCost * 0.9).round();
      }
    }
  }

  void draw(CanvasRenderingContext2D ctx) {
    //draw player color on board
    ctx.fillStyle = _color;
    ctx.fillRect(
        ((_number + 1) / 8) * _board.tileWidth +
            _board.tiles[_currentLocation].x,
        (1 / 2) * _board.tileHeight + _board.tiles[_currentLocation].y,
        _size,
        _size);

    //draw player info inside of board area
    int infoX =
        (_board.x + _board.tileWidth * 1.75 + _number * _board.tileWidth * 1.25)
            .toInt();
    int infoY = (_board.y + _board.tileHeight * 2).toInt();
    ctx.fillStyle = 'black';
    ctx.font = 'bold 14pt sans-serif';
    ctx.fillText(_name, infoX, infoY); //display "player name"

    ctx.font = '10pt sans-serif';
    ctx.fillText("Money: ", infoX, infoY + 20); //display "Money:"
    ctx.font = 'bold 10pt sans-serif';
    ctx.fillText(
        '\$' + _money.toString(), infoX, infoY + 37); //display amount of money

    ctx.font = '10pt sans-serif';
    ctx.fillText(
        "Properties Owned:", infoX, infoY + 55); //display "Properties Owned:"
    ctx.font = '10pt sans-serif';

    for (Tile tile in _ownedTiles) {
      //display owned properties
      ctx.fillText(
          tile.name, infoX, infoY + 70 + _ownedTiles.indexOf(tile) * 15);
    }
  }
}
