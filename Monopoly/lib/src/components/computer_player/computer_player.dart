import 'dart:math';
import 'dart:html';

import '../app/app.dart';
import '../player/player.dart';
import '../board/board.dart';
import '../tiles/tile.dart';

class ComputerPlayer extends Player {
  App _app;
  int rollValue;
  Random _random;
  bool _shouldRollAgain;

  ComputerPlayer(
      this._app, String name, int size, int number, String color, Board board)
      : super(name, size, number, color, board) {}

  computerTurn(Tile tile) {

    rollDice();
    print("you rolled");
    super.move(_app.rollValue);
    print("you moved");

    if (_app.isBuyPropertyAvailable) {
      landOnProperty(tile);
      checkAvailableButtons(tile);
    }
    else
      checkAvailableButtons(tile);
  }

  landOnProperty(Tile tile) {
    if (tile.isOwned) {
      //property is owned
      if (super.money > tile.calcRent(_app.rollValue)) {
        //if money is greater than rent
        super.payRent(tile.owner, tile, _app.rollValue); //pay rent
        print("you paid rent");
      }

      if (super.money < tile.calcRent(_app.rollValue)) {
        //if money is less than rent
        do {
          if (_app.isMortgagePropertyAvailable) {
            //check if possible to mortgage
            _app.handleComputerMortgageProperty; // mortgage
            print("you might have mortgaged a thing");
          } else {
            //if can not mortgage
            if (_app.isSellBuildingsAvailable) {
              //check if possible to sell building
              super.sellBuilding(tile); //if yes sell building
              print("you sold a building");
            } else {
              super.payRent(
                  tile.owner, tile, _app.rollValue); //pay rent --> go negative
                  print("you paid rent");
              break;
            }
          }
        } while (super.money < tile.calcRent(_app.rollValue));
      }
    }
    else {
      if (super.money > tile.price) {
        super.buyTile(tile); //if enough --> buy
        print("tile purchased");
      } else {
        _app.handleAuctionProperty;
        print("auction time");
      }
    }
  }

  checkAvailableButtons(Tile tile) {
    if (_app.isBuyBuildingsAvailable) {
      if (super.money > tile.buildPrice && tile.numBuildings < 1) {
        //if num owned < 1 and have enough money
        super.buyBuilding(tile);
        print("building purchased");
      }
    }

    if(!_app.isEndTurnAvailable) {
      computerTurn(tile);
      print("rolled ");
    }

    if(!_app.isBuyBuildingsAvailable && _app.isEndTurnAvailable) {
      _app.handleEndTurn;
      print("end of computer turn");
    }
  }

  rollDice() {
    int rollDieOne = _random.nextInt(6) + 1;
    int rollDieTwo = _random.nextInt(6) + 1;
    rollValue = rollDieOne + rollDieTwo;
    print("roll value");
    // Sets should roll again if the dice are the same value
    _shouldRollAgain = rollDieOne == rollDieTwo;
    _app.activePlayer.move(rollValue);
  }

}
