import 'tile.dart';
import '../player/player.dart';

class Railroad extends Tile {
  // Price to purchase the railroad
  final int _price;
  // Cost to the player
  final int _mortageCost;

  Player owner;

  bool _isMortaged = false;
  bool _isInMonopoly = false;

  // Owner is an optional parameter
  Railroad(
      String name, int location, this._price, this._mortageCost,
      [this.owner])

  // Getters
  //int get price => _price;

  int get mortgageCost => _mortageCost;

  bool get isMortgaged => _isMortaged;

  bool get isInMonopoly => _isInMonopoly;

  //int get rent => _calculateRent();

  /*_calculateRent() {
    // Call player owner (if !null) to determine how many of tile type are owned
    if (_numberOwned == 1) {
      return _baseRent;
    } else if (_numberOwned == 2) {
      return 50;
    } else if (_numberOwned == 3) {
      return 100;
    } else if (_numberOwned == 3) {
      return 200;
    } else {
      String error = 'error';
      print(error);
      return null;
    }
  }*/
}
