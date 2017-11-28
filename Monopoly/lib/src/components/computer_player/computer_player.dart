import '../app/app.dart';
import '../player/player.dart';
import '../board/board.dart';
import '../tiles/tile.dart';

class ComputerPlayer extends Player {
  App _app;

  ComputerPlayer(
      this._app, String name, int size, int number, String color, Board board)
      : super(name, size, number, color, board) {}

  void computerTurn(Tile tile) {

    super.move(_app.rollValue); //roll

    //check available buttons

    //if buy property is available
    if (_app.isBuyPropertyAvailable) {
      //check money
      if (super.money > tile.price) {
        super.buyTile(tile); //if enough --> buy
      } else {
        _app.handleAuctionProperty;
      }
    } else {
      //else --> property not available to buy
      if (super.money > tile.calcRent(_app.rollValue)) {
        //if money > rent
        super.payRent(tile.owner, tile, _app.rollValue); //pay rent
      }
      if (super.money < tile.calcRent(_app.rollValue)) {
        // if money < rent
        if (_app.isMortgagePropertyAvailable) {
          //check if mortgage is available
          //TODO mortgage property
          //TODO check money and repeat above
        } else {
          //if no
          if (_app.isSellBuildingsAvailable) {
            //is sell building available
            super.sellBuilding(tile);
            //TODO check money and repeat above
          } else {
            super.payRent(
                tile.owner, tile, _app.rollValue); //pay rent --> go negative
          }
        }
      }
    }

    //if buy buildings is available
    if (_app.isBuyBuildingsAvailable) {
      if (super.money > tile.buildPrice && tile.numBuildings < 1) {
        //if num owned < 1 and have enough money
        super.buyBuilding(tile);
      }
    }

    //if nothing else available && end turn available
    if (!_app.isBuyPropertyAvailable &&
        !_app.isBuyBuildingsAvailable &&
        _app.isRollDiceAvailable) {
      //end turn
    }
    if (!_app.isBuyPropertyAvailable &&
        !_app.isBuyBuildingsAvailable &&
        !_app.isRollDiceAvailable) {
      super.move(_app.rollValue); //roll again
    }
  }
}
