import 'dart:html';
import 'dart:async';

import '../tiles/tile.dart';
import '../board/board.dart';
import '../player/player.dart';
import 'dart:math';

//App.dart controls the drawing flow, but renderer allows real drawing
class Renderer {
  CanvasElement _canvasBackground;
  CanvasRenderingContext2D _ctxBackground;

  CanvasElement _canvasForeground;
  CanvasRenderingContext2D _ctxForeground;

  Board _boardRef;

  List<Player> _playerListRef;

  Renderer(this._boardRef, this._playerListRef) {
    // Instantiate a board
    _canvasBackground = querySelector("#canvas-background");
    _ctxBackground = _canvasBackground.getContext('2d');

    _canvasForeground = querySelector("#canvas-foreground");
    _ctxForeground = _canvasForeground.getContext('2d');

    // Background canvas setup
    _canvasBackground.width = window.innerWidth ?? 1024;
    _canvasBackground.height = window.innerHeight ?? 768;
    // Foreground canvas setup
    _canvasForeground.width = window.innerWidth ?? 1024;
    _canvasForeground.height = window.innerHeight ?? 768;
  }

  //initialize the board in GUI
  beginDraw() {
    _ctxBackground.clearRect(0, 0, window.innerWidth, window.innerHeight);
    _ctxForeground.clearRect(0, 0, window.innerWidth, window.innerHeight);
    querySelector('#output').text = '';
    drawBoard();
    querySelector('#output').text = '';

    new Timer.periodic(new Duration(milliseconds: 20), (Timer t) {
      _drawForeground();
    });

    window.onResize.listen((e) {
      _canvasBackground.width = window.innerWidth;
      _canvasBackground.height = window.innerHeight;
      _canvasForeground.width = window.innerWidth;
      _canvasForeground.height = window.innerHeight;
      resizeBoard();
      drawBackground();
    });
  }

  _drawForeground() {
    _ctxForeground.clearRect(0, 0, window.innerWidth, window.innerHeight);
    for (Player player in _playerListRef) {
      drawPlayer(player);
    }
  }

  //draw each tile
  void drawBoard() {
    drawTiles();
  }

  drawBackground() {
    _ctxBackground.clearRect(0, 0, window.innerWidth, window.innerHeight);
    drawBoard();
  }

  //if screen size changes, resize the board to that resolution
  void resizeBoard() {
    //resize size of tile
    _boardRef.tileWidth = (window.innerWidth - 50) ~/ 11;
    _boardRef.tileWidth = _boardRef.tileWidth * 10 ~/ 11; //leave room on left side for buttons
    _boardRef.tileHeight = (window.innerHeight - 50) ~/ 11;

    //reset _boardRef x and y location
    _boardRef.x = (window.innerWidth / 2 - _boardRef.tileWidth * 5).toInt();
    _boardRef.y = (window.innerHeight / 2 - _boardRef.tileHeight * 5.5).toInt();

    //reset location and size of each tile
    for (int i = 0; i < 10; i++) {
      _boardRef.tiles[i].setLocation(_boardRef.x + i * _boardRef.tileWidth, _boardRef.y);
      _boardRef.tiles[i].setSize(_boardRef.tileWidth, _boardRef.tileHeight);
      _boardRef.tiles[i + 10]
          .setLocation(10 * _boardRef.tileWidth + _boardRef.x, _boardRef.y + i * _boardRef.tileHeight);
      _boardRef.tiles[i + 10].setSize(_boardRef.tileWidth, _boardRef.tileHeight);
      _boardRef.tiles[i + 20]
          .setLocation((10 - i) * _boardRef.tileWidth + _boardRef.x, 10 * _boardRef.tileHeight + _boardRef.y);
      _boardRef.tiles[i + 20].setSize(_boardRef.tileWidth, _boardRef.tileHeight);
      _boardRef.tiles[i + 30].setLocation(_boardRef.x, (10 - i) * _boardRef.tileHeight + _boardRef.y);
      _boardRef.tiles[i + 30].setSize(_boardRef.tileWidth, _boardRef.tileHeight);
    }
  }

  //draw each individual tile
  drawTiles() {
    for (Tile tile in _boardRef.tiles) {
      _ctxBackground.fillStyle = tile.color == 'None' ? 'White' : tile.color;
      _ctxBackground.strokeStyle = 'black';
      _ctxBackground.textAlign = 'center';

      _ctxBackground.strokeRect(tile.x, tile.y, tile.width, tile.height); //draw tile boarder
      _ctxBackground.fillRect(tile.x, tile.y, tile.width, tile.height); //draw tile color

      //draw indicator if tile is mortgaged
      if (tile.isMortgaged) {
        _ctxBackground.fillStyle = 'black';
        _ctxBackground.font = '14pt sans-serif';
        _ctxBackground.fillText('M', tile.x + 9 * tile.width / 10, tile.y + tile.height / 5);
      }

      //draw owner's name
      _ctxBackground.fillStyle = 'black';
      _ctxBackground.font = '8pt sans-serif';
      if (tile.owner != null)
        _ctxBackground.fillText(
            'Owner: ' + tile.owner.name, tile.x + tile.width / 2, tile.y + 7 * tile.height / 10); //draw owner's name

      //write name of tile
      _ctxBackground.font = 'bold 8pt sans-serif';
      _ctxBackground.fillText(tile.name, tile.x + tile.width / 2, tile.y + 9 * tile.height / 10);

      //draw buildings
      if (tile.numBuildings == 5) {
        _ctxBackground.fillStyle = 'red';
        _ctxBackground.fillRect(tile.x + tile.width / 2 - 10, tile.y + tile.height / 10, 20, 10);
      } else {
        for (int i = 0; i < tile.numBuildings; i++) {
          _ctxBackground.fillStyle = 'green';
          _ctxBackground.fillRect(tile.x + ((i + 1) / 5) * tile.width - 5, tile.y + tile.height / 10, 10, 10);
        }
      }
    }
  }

  //draw player tokens
  void drawPlayer(Player player) {
    //draw player token on board
    _ctxForeground.fillStyle = player.color;
    _ctxForeground.beginPath();
    _ctxForeground.arc(
        ((player.number + 1) / 8) * player.board.tileWidth + player.board.tiles[player.currentLocation].x,
        (2 / 5) * player.board.tileHeight + player.board.tiles[player.currentLocation].y,
        player.size / 2,
        0,
        PI * 2);
    _ctxForeground.closePath();
    _ctxForeground.fill();

    //draw player info inside of board area
    int infoX =
        (player.board.x + player.board.tileWidth * 1.75 + player.number * player.board.tileWidth * 1.25).toInt();
    int infoY = (player.board.y + player.board.tileHeight * 2).toInt();
    _ctxForeground.fillStyle = player.color;
    _ctxForeground.font = 'bold 14pt sans-serif';
    _ctxForeground.fillText(player.name, infoX, infoY); //display "player name"

    _ctxForeground.fillStyle = 'black';
    _ctxForeground.font = '10pt sans-serif';
    _ctxForeground.fillText("Money: ", infoX, infoY + 20); //display "Money:"
    _ctxForeground.font = 'bold 10pt sans-serif';
    _ctxForeground.fillText('\$' + player.money.toStringAsFixed(2), infoX, infoY + 37); //display amount of money

    _ctxForeground.font = '10pt sans-serif';
    _ctxForeground.fillText("Properties Owned:", infoX, infoY + 55); //display "Properties Owned:"
    _ctxForeground.font = '10pt sans-serif';

    for (Tile tile in player.ownedTiles) {
      //display owned properties
      _ctxForeground.fillText(tile.name, infoX, infoY + 70 + player.ownedTiles.indexOf(tile) * 15);
    }
  }
}
