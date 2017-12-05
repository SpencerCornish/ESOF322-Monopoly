import 'dart:async';
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

  Future computerTurn() async {
    await rollDice();
    await checkButtons();
  }

  /*
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
        _app.renderer.drawBackground();
        print("comp tile purchased");
      } else {
        _app.handleAuctionProperty(null);
        print("comp auction time");
      }
    }
  }
  */

  checkButtons() async {
    Tile tile = super.board.tiles[position];

    //landOnProperty();

    //if land on property
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
      //if tile is not owned
      _app.isBuyPropertyAvailable = true;
      if (super.money > tile.price) {
        super.buyTile(tile); //if enough --> buy
        _app.renderer.drawBackground();
        print("comp tile purchased");
      } else {
        _app.handleAuctionProperty(null);
        Element _modal = querySelector('.modal');
        while (_modal.classes.contains('is-active')) {
          print("boop");
          await new Future.delayed(const Duration(seconds: 1));
        }
        print("comp auction time");
      }
    }

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
    // int rollDieOne = 2;
    // int rollDieTwo = 2;
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
    this.move(rollValue);
    rollingDice = false;
  }
}
