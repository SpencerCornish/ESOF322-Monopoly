import 'tile.dart';
import '../player/player.dart';

class Utility extends Tile {
  Player _owner;
  final int _price;
  final int _mortageCost;

  bool _isMortaged = false;
  bool _isInMonopoly = false;

  Utility(String name, int location, this._price, this._mortageCost)
      : super(name, location);

  // Getters
  int get price => _price;
  int get mortgageCost => _mortageCost;
  bool get isMortgaged => _isMortaged;
  bool get isInMonopoly => _isInMonopoly;

// TODO: make this calculate the total rent, with how many owned by player, and roll of dice
//int get rent => _baseRent * ;

  calulateRent() {
    //TODO: Call Owner Player to determine how many are owned.
    if (numOwned == 1) {
      rent = rollVal * 4;
    } else if (numOwned == 2) {
      rent = rollVal * 10;
    }
    return rent;
  }

  int get totalRent => rent;
}
