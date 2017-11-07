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
  int _rollValue;

  Player(this._name);


  //player rolls dice and moves position
  void move(){
    if(_inJail)
      getOutOfJail();
    else
      normalMove(rollDice());
  }

  int rollDice(){
    int die1 = rand.nextInt(6)+1;
    int die2 = rand.nextInt(6)+1;

    if(die1 == die2)
      _numDoubles++;
    else
      _numDoubles = 0;

    _rollValue = die1 + die2;
    return _rollValue;
  }

  void normalMove(int rollVal){

    //if the player rolls doubles 3 times in the same turn, go to jail
    if(_numDoubles == 3)
      goToJail();

    if(!_inJail){
      int nextLocation = _currentLocation + rollVal;

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
    if(p.buildings < 4) {
      for (var i = 0; i < numHouse; i++) {
        //p.buyHouse() - TODO where p.buyHouse will add the multiplier of a house
        _money -= p.buildPrice;
      }
    } else if (p.buildings == 4) {
      //build hotel not house
      _money -= p.buildPrice;
    } else {
      print("Max number of buildings reached. You cannot build anymore on this property");
    }
  }

  void sellHouse() {}

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
    String _methodToGetOut;
    switch (_methodToGetOut) {

      case 'rolled doubles':
        int roll = rollDice();
        if (_numDoubles > 1) {
          _inJail = false;
          normalMove(roll); //move rolled amount
          normalMove(rollDice()); //roll again because doubles
        } else {
          _inJail = true;
          //end turn
        }
        break;
      case 'paid bail':
        _money -= 50;
        _inJail = false;
        normalMove(rollDice());
        break;
    }
  }

  void goBankrupt() {
   /*
   if player money < amount owed
    if buildings > 0
      sell building
      check if money < amount owed
      repeat until buildings = 0 or money >= amount owed
    if money still < amount owed
      if unmortgaged properties > 0
        mortgage properties
        check if money < amount owed
        repeat until unmortgaged properties = 0 or money >= amount owed
    if money still < amount owed
      you bankrupt --> remove player from game
      display end game message
        if bank owed
          give all money to bank
          give all properties to bank
          auction all properties
        if another player owed
          give all money to player
          give all properties to player
    */
  }


  void payRent(Player owner, Player renter, int rent, Tile t) {
    owner.getPaid(t.calcRent(_rollValue));
    /*
    if(renter._money <= 0){
      goBankrupt();
      owner._money += renter._money;
      for (int i = 0; i < renter._ownedTiles.length; i++) {
        owner._ownedTiles.add(renter._ownedTiles[i]);
      }
    }
    */
  }

  void getPaid(int amt) {
    this._money += amt;
  }

  void sellDeed(Tile t) {
    //should this be a repeated method based on utility, railroad, or property?
    this._ownedTiles.remove(t);
    //update money
  }

  void tradeDeed(Player seller, Player buyer, Tile t, int tradeAmount) {
    seller.sellDeed(t);
    seller._money += tradeAmount;

    buyer.buyTile(t);
    buyer._money -= tradeAmount;

    if (t.isMortgaged) {
      String _choice;
      switch (_choice) {
        case 'repay mortgage':
          _money -= t.mortgageCost;
          break;
        case 'keep mortgaged':
          _money -= (t.mortgageCost * 0.9).round();
      }
    }
  }

  void payBank(int amt) {
    //bank.collect(amt);           //instance of bank? or should bank be static?
    this._money -= amt;
  }
}
