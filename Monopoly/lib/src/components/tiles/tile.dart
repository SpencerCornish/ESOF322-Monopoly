import '../player/player.dart';

class Tile {
  final String _name;

  //TODO: Can this be inferred from the board/who needs to know this?
  final int _location;

  Player _owner;

  // Tile constructor

  Tile(this._name, this._location);

  // Getters
  String get name => _name;
  int get location => _location;
  Player get owner => _owner;

  // Setter for setting owner
  setOwner(Player newOwner) => _owner = newOwner;
}
