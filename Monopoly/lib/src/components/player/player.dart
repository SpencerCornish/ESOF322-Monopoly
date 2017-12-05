import '../tiles/tile.dart';

import 'package:monopoly/src/components/board/board.dart';

class Player {
  Board _board;
  String _name;
  int _number;
  String _color;
  int _size;
  double _money;
  int _currentLocation = 0;
  List<Tile> _ownedTiles = new List<Tile>();
  int _numRailroads = 0;
  int _numUtilities = 0;
  bool isComputer;

  //getter methods
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

  //setter methods
  set position(int currentPosition) => _currentLocation = currentPosition;
  set money(double totalMoney) => _money = totalMoney;

  //create a new player
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

  //checks players tiles to see if they own a monopoly, and therefore can build
  void updateMonopoly(Tile tile) {
    List<Tile> count = new List<Tile>();
    var tileColor = tile.color;
    for (Tile curTile in _ownedTiles) {
      if (curTile.color == tileColor) {
        count.add(curTile);             //add the tile if it the same color
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
    tile.setOwner(this);
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

  //turn the tile's mortgage boolean on or off
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

  //build a building on the property
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

  //sell a building on the property
  void sellBuilding(Tile tile) {
    tile.numBuildings -= 1;
    _money += (tile.buildPrice / 2).round();
  }

  //set name of player
  void set name(String n) {
    _name = n;
  }

  //pay rent to another player
  int payRent(Player owner, Tile tile, int rollValue) {
    int rent = tile.calcRent(rollValue);
    _money -= rent;
    owner._money += rent;
    return rent;
  }
}
