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
  void move(int rollValue) {
    int nextLocation = _currentLocation + _rollValue;
    if (_inJail)
      getOutOfJail();
    else {
      if (rollValue == 0) {
        _rollValue = rollDice();

      } else if (rollValue >= 2) {
        _rollValue = rollValue;

      } else {
        print("invalid entry");
      }

      if (nextLocation > 39) {
        //if the player has landed on or passed go
        _currentLocation = nextLocation - 40;
        _money += 200;
      }

      _currentLocation = nextLocation;
      setPosition(nextLocation);

      if (_numDoubles > 0) //if the player rolled doubles move again
        move(rollValue);
    }
  }

  int rollDice() {
    int die1 = rand.nextInt(6) + 1;
    int die2 = rand.nextInt(6) + 1;

    if (die1 == die2)
      _numDoubles++;
    else
      _numDoubles = 0;

    _rollValue = die1 + die2;
    return _rollValue;
  }

  void buyTile(Tile t) {
    t.owner = this;
    properties.add(t);
  }

  void buyBuilding(Tile p, int numHouse) {
    if (p.isInMonopoly) {
      //TODO check that player is building evenly
      if (p.numBuildings < 4) {
        for (var i = 0; i < numHouse; i++) {
          _money -= p.buildPrice;
          p.addBuilding();
        }
      } else if (p.numBuildings == 4) { //build hotel
        _money -= p.buildPrice;
        p.addBuilding();
      } else {
        print("ERROR: Max number of buildings reached. You cannot build anymore on this property");
      }
    }
    else
      print ("ERROR: Property not in a monopoly. you cannont build");
  }

  void sellBuilding(Tile t) {
    t.numBuildings - 1;
    _money += (t.buildPrice / 2).round();
  }

  List<Tile> get properties => _ownedTiles;
  int get money => _money;
  String get name => _name;
  //TODO get token
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
    int _attempts = 0;
    String _methodToGetOut;
    switch (_methodToGetOut) {
      case 'rolled doubles':
        int roll = rollDice();
        if (_numDoubles > 1) {
          _inJail = false;
          move(roll); //move rolled amount
          move(0); //roll again because doubles
        } else if (_numDoubles < 1) { //after 3 tries paid bail and continue turn
          if (_attempts >= 3) {
            _money -= 50;
            _inJail = false;
            move(roll);
          } else {
            _inJail = true;
            _attempts++;
          }
        }
        else {
          _inJail = true;
          //end turn
        }
        break;
      case 'paid bail':
        _money -= 50;
        _inJail = false;
        move(0);
        break;
    }
  }

  /*
  don't need this for assignment
  void goBankrupt() {
   if player money < amount owed
    if buildings > 0
      sell building
      check if money < amount owed
      repeat until buildings = 0 or money >= amount owed
    if money still < amount owed
      if un-mortgaged properties > 0
        mortgage properties
        check if money < amount owed
        repeat until un-mortgaged properties = 0 or money >= amount owed
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
  }
  */

  void payRent(Player owner, Player renter, int rent, Tile t) {
    owner.getPaid(t.calcRent(_rollValue));
  }

  void getPaid(int amt) {
    this._money += amt;
  }

  void tradeProperty(Player seller, Player buyer, Tile t, int tradeAmount) {
    this._ownedTiles.remove(t);;
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

  //do we need this??
  void payBank(int amt) {
    this._money -= amt;
  }
}
