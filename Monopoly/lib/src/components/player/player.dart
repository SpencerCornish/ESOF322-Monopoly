import '../tiles/tile.dart';
import 'dart:html';

import 'package:monopoly/src/components/board/board.dart';

class Player {
  String _name;
  int _number;
  String _color;
  int _size;
  // Token Type: Enum here?
  int _money;
  int _currentLocation = 0;
  List<Tile> _ownedTiles;
  bool _playerInJail = false;
  Board _board;

  Player(this._name, this._size, this._number, this._color, this._board) {}

  void buyTile(Tile t) {}

/*
void buyProperty(Property p) {
  _money -= p.price;
  _ownedTiles.add(p);
}

void buyRailroad(Railroad r) {

}

void buyUtility(Utility u) {

}
*/

  void buyHouse(Tile p, int numHouse) {
    //we should be able to work buy hotel into this
    for (var i = 0; i < numHouse; i++) {
      //p.buyHouse() - TODO where p.buyHouse will add the multiplier of a house
      _money -= p.buildPrice;
    }
  }

  List<Tile> get properties => _ownedTiles;
  int get money => _money;
  String get name => _name;
//get token
  int get position => _currentLocation;

  void set name(String n) {
    _name = n;
  }

  void setToken(var token) {
    //TODO
  }

  void setPosition(int spot) {
    _currentLocation = spot;
  }

  void goToJail() {
    _currentLocation = 10;
    _playerInJail = true;
  }

  void getOutOfJail() {
    _playerInJail = false;
  }

  void goBankrupt() {
    //display end game message
  }

  void payRent(Player to, int rent) {
    to.getPaid(rent);
  }

  void getPaid(int amt) {
    this._money += amt;
  }

  void sellDeed(Tile t) {
    //should this be a repeated method based on utility, railroad, or property?
    this._ownedTiles.remove(t);
    //update money
  }

  void tradeDeed(Player p) {
    //trading will be a difficult thing
  }

  void payBank(int amt) {
    //bank.collect(amt);           //instance of bank? or should bank be static?
    this._money -= amt;
  }

  void draw(CanvasRenderingContext2D ctx){
    ctx.fillStyle = _color;
    ctx.fillRect(((_number+1)/8)*_board.tileWidth+_board.tiles[_currentLocation].x, (1/2)*_board.tileHeight+_board.tiles[_currentLocation].y, _size, _size);
  }
}
