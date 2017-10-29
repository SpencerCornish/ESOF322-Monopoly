import '../tiles/tile.dart';
import '../tiles/property.dart';
import '../tiles/railroad.dart';
import '../tiles/utility.dart';

class Player {
  String _name;
  // Token Type: Enum here?
  int _money = 1500;
  int _currentLocation = 0;
  List<Tile> _ownedTiles;
  bool _playerInJail = false;

Player(this._name) {}

void buyProperty(Property p) {
  this._money -= p.price;
  this._ownedTiles.add(p);
}

void buyHouse(Property p, int numHouse) {   //we should be able to work buy hotel into this
  for (var i = 0; i < numHouse; i++) {
    //p.buyHouse() - TODO where p.buyHouse will add the multiplier of a house
    this._money -= p.housePrice;
  }
}

void buyRailroad(Railroad r) {

}

void buyUtility(Utility u) {

}

List<Tile> get properties => _ownedTiles;
int get money => _money;
String get name => _name;
//get token

void set name(String n) {
  this._name = n;
}

void set







}
