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
  bool _shouldRollAgain = false;

  ComputerPlayer(
      this._app, String name, int size, int number, String color, Board board)
      : super(name, size, number, color, board) {
    _random = new Random.secure();
  }

  computerTurn(Tile tile) {
    if(_app.isRollDiceAvailable){
      rollDice();
      _app.updateButtons();
    }

    if (_app.isBuyBuildingsAvailable) {
      if (super.money > tile.buildPrice && tile.numBuildings < 1) {
        //if num owned < 1 and have enough money
        super.buyBuilding(tile);
        print("computer building purchased");
      }
      _app.updateButtons();
    }

    if(_app.isBuyPropertyAvailable) {
      landOnProperty(tile);
      _app.updateButtons();
    }

    if(!_app.isEndTurnAvailable) {
      computerTurn(tile);
      _app.updateButtons();
    } else {
      _app.handleEndTurn;
      //endCompTurn();
      print("end of computer turn");
    }



    /*
    if(_app.isRollDiceAvailable){
      rollDice();
      print("you rolled");
    } else {
      _app.handleEndTurn;
      print("end of turn");
    }

    if (_app.isBuyPropertyAvailable) {
      landOnProperty(tile);
      checkAvailableButtons(tile);
    } else
      checkAvailableButtons(tile);
   // _app.handleEndTurn;
   */
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

  /*
  checkAvailableButtons(Tile tile) {

    if(_app.isRollDiceAvailable){
      rollDice();
      print("you rolled");
    } else {
      _app.handleEndTurn;
      print("end of turn");
    }

    if (_app.isBuyBuildingsAvailable) {
      if (super.money > tile.buildPrice && tile.numBuildings < 1) {
        //if num owned < 1 and have enough money
        super.buyBuilding(tile);
        print("building purchased");
      }
    }

    if(_app.isBuyPropertyAvailable) {
      landOnProperty(tile);
    }

    if(!_app.isEndTurnAvailable) {
      computerTurn(tile);
      print("rolled ");
    }

    if(_app.isEndTurnAvailable) {
      _app.handleEndTurn;
      print("end of computer turn");
    }
  }
  */

  rollDice() {
    int rollDieOne = _random.nextInt(6) + 1;
    int rollDieTwo = _random.nextInt(6) + 1;
    rollValue = rollDieOne + rollDieTwo;
    print(" computer roll value");
    if(rollDieOne == rollDieTwo) {
      print("computer doubles");
      _shouldRollAgain = true;
      _app.isRollDiceAvailable = true;
      _app.isEndTurnAvailable = false;
    } else {
      print("dont roll");
      _shouldRollAgain = false;
      _app.isRollDiceAvailable = false;
      _app.isEndTurnAvailable = true;
    }

    // Sets should roll again if the dice are the same value
    //_shouldRollAgain = rollDieOne == rollDieTwo;
    this.move(rollValue);
    print("computer you moved");
    //_app.updateButtons();
  }

  endCompTurn() {

    _app.updateButtons();
    _app.nextPlayer();

  }


}
