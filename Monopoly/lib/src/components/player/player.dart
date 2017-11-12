import '../tiles/tile.dart';
import 'dart:math';
import 'dart:html';

import 'package:monopoly/src/components/board/board.dart';

class Player {
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
  int _numRailroads = 0;
  int _numUtilities = 0;

  int get money => _money;
  String get name => _name;
  int get position => _currentLocation;
  List<Tile> get ownedTiles => _ownedTiles;
  int get numRailroads => _numRailroads;
  int get numUtilities => _numUtilities;

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
    var tileColor = tile.color;
    for (Tile curTile in _ownedTiles) {
      if (curTile.color == tileColor) {
        count.add(curTile);
      }
    }
    if (count.length == tile.totalNum) {
      for (Tile newMonopTile in count)
        newMonopTile.isInMonopoly = true;
    }
    else {
      for (Tile curTile in _board.tiles) {
        if (curTile.color == tileColor) {
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
    print(tile.owner.name);
    _ownedTiles.add(tile);
    _money -= tile.price;
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
      print("ERROR: Property not in a monopoly. You can not build");
  }

  void sellBuilding(Tile tile) {
    tile.numBuildings -= 1;
    _money += (tile.buildPrice / 2).round();
  }

  void set name(String n) {
    _name = n;
  }

  int payRent(Player owner, Tile tile, int rollValue) {
    int rent = tile.calcRent(rollValue);
    print(rent);
    _money -= rent;
    owner._money += rent;
    return rent;
  }

  void tradeProperty(Player seller, Player buyer, Tile tile, int tradeAmount) {
    //TODO trade tile for tile
    //TODO trade hybrid for tile
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
    //draw player token on board
    ctx.fillStyle = _color;

    ctx.beginPath();
    ctx.arc(((_number + 1) / 8) * _board.tileWidth +
        _board.tiles[_currentLocation].x, (2 / 5) * _board.tileHeight + _board.tiles[_currentLocation].y,
        _size/2, 0, PI*2);
    ctx.closePath();
    ctx.fill();

    //draw player info inside of board area
    int infoX =
        (_board.x + _board.tileWidth * 1.75 + _number * _board.tileWidth * 1.25)
            .toInt();
    int infoY = (_board.y + _board.tileHeight * 2).toInt();
    ctx.fillStyle = _color;
    ctx.font = 'bold 14pt sans-serif';
    ctx.fillText(_name, infoX, infoY); //display "player name"

    ctx.fillStyle = 'black';
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
