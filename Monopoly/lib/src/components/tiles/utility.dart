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

/*
  if (_numberOwned = 1) {
    int get rent => 4 * _diceAmount;
  }
  else if (_numerOwned = 2) {
    int get rent => 10 * _diceAmount;
  }
*/

}