import 'tile.dart';
import 'player.dart';

class Railroad extends Tile {
  final int _price;
  static final int _baseRent = 25;
  final int _mortageCost;

  bool _isMortaged = false;
  bool _isInMonopoly = false;

  //static int _numberOwned = ;
  //static int _rent;

  Railroad(String name, int location, this._price, this._baseRent,
      this._mortageCost, this._numberOwned)
      : super(name, location);

  // Getters
  int get price => _price;

  int get mortgageCost => _mortageCost;

  bool get isMortgaged => _isMortaged;

  bool get isInMonopoly => _isInMonopoly;

// TODO: make this calculate the total rent, how many owned by player

  int rent = 0;
  ClaculateRent(int numOwned, int baseRent) {
    if (numOwned == 1) {
      rent = _baseRent;
    }

    else if (numOwned == 2) {
      rent = 50;
    }

    else if (numOwned == 3) {
      rent = 100;
    }

    else if (numOwned == 3) {
      rent = 200;
    }

    else {
      String error = 'error';
      print(error);
    }
    return rent;
  }
  int get totalRent => rent;
}