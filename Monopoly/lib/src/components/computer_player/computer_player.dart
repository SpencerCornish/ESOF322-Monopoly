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
  bool rollingDice;

  //bool _shouldRollAgain = false;

  ComputerPlayer(
      this._app, String name, int size, int number, String color, Board board)
      : super(name, size, number, color, board) {
    _random = new Random.secure();
  }

  computerTurn() {
    rollingDice = true;
    rollDice();
    checkButtons();
  }

  landOnProperty() {
    Tile tile = super.board.tiles[position];
    if (tile.isOwned) {
      //property is owned
      _app.isBuyPropertyAvailable = false;
      if (super.money > tile.calcRent(_app.rollValue)) {
        //if money is greater than rent
        super.payRent(tile.owner, tile, _app.rollValue); //pay rent
        print("comp paid rent");
      } else {
        super.payRent(tile.owner, tile, _app.rollValue);
        print("not enough money");
      }
    }
    if (tile.owner == null &&
        (tile.type == 'Street' ||
            tile.type == 'Railroad' ||
            tile.type == 'Utility')) {
      _app.isBuyPropertyAvailable = true;
      if (super.money > tile.price) {
        _app.shouldAuction = false;
        super.buyTile(tile); //if enough --> buy
        _app.drawBackground();
        print("comp tile purchased");
      } else {
        _app.handleAuctionProperty(null);
        print("comp auction time");
      }
    }
    }


      /*
      if (super.money < tile.calcRent(_app.rollValue)) {
        //if money is less than rent
        do {
          if (_app.isMortgagePropertyAvailable) {
            //check if possible to mortgage
            _app.handleComputerMortgageProperty; // mortgage
            print("comp might have mortgaged a thing");
          } else {
            //if can not mortgage
            if (_app.isSellBuildingsAvailable) {
              //check if possible to sell building
              // super.sellBuilding(tile); //if yes sell building
              print("comp sold a building");
            } else {
              super.payRent(
                  tile.owner, tile, _app.rollValue); //pay rent --> go negative
              print("comp paid rent");
              break;
            }
          }
        } while (super.money < tile.calcRent(_app.rollValue));
      }
    } else {
      if (super.money > tile.price) {
        super.buyTile(tile); //if enough --> buy
        print("comp tile purchased");
        _app.isBuyPropertyAvailable = false;
      } else {
        _app.handleAuctionProperty;
        print("comp auction time");
      }
    }
  }
  */

  checkButtons() {
    Tile tile = super.board.tiles[position];
    // if end turn is available and should roll again is true
    if (_app.shouldRollAgain && _app.isRollDiceAvailable) {
      computerTurn();
    }

    landOnProperty();

    //if build house is available
    if (_app.isBuyBuildingsAvailable) {
      if (super.money > tile.buildPrice && tile.numBuildings < 1) {
        //if num owned < 1 and have enough money
        super.buyBuilding(tile);
        print("comp building purchased");
      }
    }
  }

  rollDice() {
    int rollDieOne = _random.nextInt(6) + 1;
    int rollDieTwo = _random.nextInt(6) + 1;
    rollValue = rollDieOne + rollDieTwo;
    if (rollDieOne == rollDieTwo) {
      print("rolled doubles");
      print(rollValue);
      _app.shouldRollAgain = true;
      _app.isRollDiceAvailable = true;
      _app.isEndTurnAvailable = false;
    } else {
      _app.shouldRollAgain = false;
      _app.isRollDiceAvailable = false;
      _app.isEndTurnAvailable = true;
    }

    // Sets should roll again if the dice are the same value
    //_shouldRollAgain = rollDieOne == rollDieTwo;
    this.move(rollValue);
    rollingDice = false;
  }
}
