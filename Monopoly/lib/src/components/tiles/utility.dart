import 'tile.dart';

class Utility extends Tile {
  final int _price;
  final int _baseRent;
  final int _mortageCost;

  int _rent;
  int _numberOwned;
  int _diceAmount;

  bool _isMortaged = false;
  bool _isInMonopoly = false;

  Utility(String name, int location, this._price, this._baseRent, this._mortageCost)
      : super(name, location);

  // Getters
  int get price => _price;
  int get mortgageCost => _mortageCost;
  bool get isMortgaged => _isMortaged;
  bool get isInMonopoly => _isInMonopoly;

// TODO: make this calculate the total rent, with how many owned by player, and roll of dice
//int get rent => _baseRent * ;

  int rent = 0;
  calcRent(int numOwned, int rollVal) {
    if (numOwned == 1) {
      rent = rollVal * 4;
    }

    else if (numOwned == 2) {
      rent = rollVal * 10;
    }

    return rent;
  }
  int get totalRent => rent;
}