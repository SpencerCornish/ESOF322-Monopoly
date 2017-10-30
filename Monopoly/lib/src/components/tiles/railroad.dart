import 'tile.dart';
import 'player.dart';

class Railroad extends Tile{
  final int _price;
  final int _baseRent;
  final int _mortageCost;
  //how many RR owned

  bool _isMortaged = false;
  bool _isInMonopoly = false;
  int _numberOwned = ;
  int _rent;

  Railroad(String name, int location, this._price, this._baseRent, this._mortageCost, this._numberOwned)
      : super(name, location);

  // Getters
  int get price => _price;
  int get mortgageCost => _mortageCost;
  bool get isMortgaged => _isMortaged;
  bool get isInMonopoly => _isInMonopoly;

// TODO: make this calculate the total rent, how many owned by player
/*
  if (numberOwned = 1) {
    int get rent => _baseRent;
  }
  else if (numberOwned = 2) {
    int get rent => _baseRent * 2;
  }
  else if (numberOwned = 3) {
  int get rent => (_baseRent * 2) * 2;
  }
  else if (numberOwned = 3) {
  int get rent => ((_baseRent * 2) * 2) * 2;
  }
  else {
    throw exception???
  }
*/
}