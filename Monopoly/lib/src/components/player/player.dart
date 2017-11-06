import '../tiles/tile.dart';
import 'dart:math';

class Player {
  Random rand = new Random();

  String _name;
  // Token Type: Enum here?
  int _money;
  int _numDoubles = 0;
  int _currentLocation = 0;
  List<Tile> _ownedTiles;
  bool _inJail = false;

  Player(this._name);


  //player rolls dice and moves position
  void move(){
    if(_inJail)
      jailMove();
    else
      normalMove();
  }

  void jailMove(){
    
  }

  void normalMove(){
    int die1 = rand.nextInt(6)+1;
    int die2 = rand.nextInt(6)+1;

    if(die1 == die2)
      _numDoubles++;
    else
      _numDoubles = 0;

    //if the player rolls doubles 3 times in the same turn, go to jail
    if(_numDoubles == 3)
      goToJail();

    if(!_inJail){
      int nextLocation = _currentLocation + die1 + die2;

      if (nextLocation > 39) { //if the player has landed on or passed go
        _currentLocation = nextLocation - 40;
        _money += 200;
      }

      _currentLocation = nextLocation;

      if (_numDoubles > 0) //if the player rolled doubles move again
        move();
    }
  }

  void buyTile(Tile t) {
    t.owner = this;
    _money -= t.price;
    properties.add(t);

  }

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
    _inJail = true;
  }

  void getOutOfJail() {
    _inJail = false;
  }

  void goBankrupt() {
    //display end game message
    if (this.money == 0) {
      print("You went BANKRUPT! Game Over!");
    }
    /*
    if (moneyOwed to Player) {
    give all property to player
    give all properties to player
    } else (moneyOwed to bank) {
    give all money to bank
    give all properties to bank
      auction off all properties right away
    }
    */
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
}
