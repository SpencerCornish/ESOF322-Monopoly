import '../tiles/tile.dart';

import 'package:monopoly/src/components/board/board.dart';

class Player {
  Board _board;
  String _name;
  int _number;
  String _color;
  int _size;
  // Token Type: Enum here?
  double _money;
  int _currentLocation = 0;
  List<Tile> _ownedTiles = new List<Tile>();
  int _numRailroads = 0;
  int _numUtilities = 0;

  double get money => _money;
  String get name => _name;
  int get position => _currentLocation;
  int get numRailroads => _numRailroads;
  int get numUtilities => _numUtilities;
  int get size => _size;
  int get number => _number;
  int get currentLocation => _currentLocation;
  String get color => _color;
  Board get board => _board;

  List<Tile> get ownedTiles => _ownedTiles;

  Player(this._name, this._size, this._number, this._color, this._board) {
    _money = 1500.0;
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
      for (Tile newMonopTile in count) newMonopTile.isInMonopoly = true;
    } else {
      for (Tile curTile in _board.tiles) {
        if (curTile.color == tileColor) {
          curTile.isInMonopoly = false;
        }
      }
    }
  }

  // Optional parameter is only used when a tile is won in an auction
  void buyTile(Tile tile, [int fromAuction]) {
    tile.owner = this;
    _ownedTiles.add(tile);
    _money -= fromAuction ?? tile.price;

    if (tile.type == 'Railroad') {
      _numRailroads++;
    } else if (tile.type == 'Utility') {
      _numUtilities++;
    } else if (tile.type == 'Street') {
      updateMonopoly(tile);
    }
  }

  toggleMortgage(Tile tile) {
    // If mortgaged, unmortgage the tile
    if (tile.isMortgaged) {
      tile.isMortgaged = false;
      _money -= (tile.mortgageCost * 1.10);
    } else {
      tile.isMortgaged = true;
      _money += tile.mortgageCost;
    }
  }

  void buyBuilding(Tile tile) {
    if (tile.isInMonopoly) {
      if (tile.numBuildings < 4) {
        //build house
        _money -= tile.buildPrice; //subtract build price
        tile.addBuilding(); //add a building count on tile
      } else if (tile.numBuildings == 4) {
        //build hotel
        //check if conditions are met to build hotel (check each color tile for 4 buildings)
        _money -= tile.buildPrice; //subtract build price
        tile.addBuilding(); //add a building to count on tile
      }
    }
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
    _money -= rent;
    owner._money += rent;
    return rent;
  }

/*
  void draw(CanvasRenderingContext2D ctx) {
    //draw player token on board
    ctx.fillStyle = _color;
    ctx.beginPath();
    ctx.arc(
        ((_number + 1) / 8) * _board.tileWidth +
            _board.tiles[_currentLocation].x,
        (2 / 5) * _board.tileHeight + _board.tiles[_currentLocation].y,
        _size / 2,
        0,
        PI * 2);
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
    ctx.fillText('\$' + _money.toStringAsFixed(2), infoX,
        infoY + 37); //display amount of money

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
  */
}
