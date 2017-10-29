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
int get position => _currentLocation;


void set name(String n) {
  this._name = n;
}

void setToken(var token) {    //token stuff

}

void setPosition(int spot) {
  this._currentLocation = spot;
}

void goToJail() {
  this._currentLocation = 10;
  this._playerInJail = true;
}

void getOutOfJail() {
  this._playerInJail = false;
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

void sellDeed(Property p) {   //should this be a repeated method based on utility, railroad, or property?
  this._ownedTiles.remove(p);
  //update money
}

void tradeDeed(Player p) {      //trading will be a difficult thing

}

void payBank(int amt) {
  //bank.collect(amt);           //instance of bank? or should bank be static?
  this._money -= amt;
}

}
