import 'dart:html';
import '../tiles/tile.dart';
import '../board/board.dart';
import '../player/player.dart';
import 'dart:math';

class Renderer {

  void drawBoard(CanvasRenderingContext2D ctx, Board board) {
    for (Tile tile in board.tiles) drawTile(ctx, tile);
  }

  void resizeBoard(Board board) {
    //resize size of tile
    board.tileWidth = (window.innerWidth - 50) ~/ 11;
    board.tileWidth = board.tileWidth * 10 ~/ 11; //leave room on left side for buttons
    board.tileHeight = (window.innerHeight - 50) ~/ 11;

    //reset board x and y location
    board.x = (window.innerWidth / 2 - board.tileWidth * 5).toInt();
    board.y = (window.innerHeight / 2 - board.tileHeight * 5.5).toInt();

    //reset location and size of each tile
    for (int i = 0; i < 10; i++) {
      board.tiles[i].setLocation(board.x + i * board.tileWidth, board.y);
      board.tiles[i].setSize(board.tileWidth, board.tileHeight);
      board.tiles[i + 10].setLocation(10 * board.tileWidth + board.x, board.y + i * board.tileHeight);
      board.tiles[i + 10].setSize(board.tileWidth, board.tileHeight);
      board.tiles[i + 20].setLocation((10 - i) * board.tileWidth + board.x, 10 * board.tileHeight + board.y);
      board.tiles[i + 20].setSize(board.tileWidth, board.tileHeight);
      board.tiles[i + 30].setLocation(board.x, (10 - i) * board.tileHeight + board.y);
      board.tiles[i + 30].setSize(board.tileWidth, board.tileHeight);
    }
  }

  drawTile(CanvasRenderingContext2D ctx, Tile tile) {
    ctx.fillStyle = tile.color == 'None' ? 'White' : tile.color;
    ctx.strokeStyle = 'black';
    ctx.textAlign = 'center';

    ctx.strokeRect(tile.x, tile.y, tile.width, tile.height); //draw tile boarder
    ctx.fillRect(tile.x, tile.y, tile.width, tile.height); //draw tile color

    //draw indicator if tile is mortgaged
    if (tile.isMortgaged) {
      ctx.fillStyle = 'black';
      ctx.font = '14pt sans-serif';
      ctx.fillText('M', tile.x + 9 * tile.width / 10, tile.y + tile.height / 5);
    }

    //draw owner's name
    ctx.fillStyle = 'black';
    ctx.font = '8pt sans-serif';
    if (tile.owner != null)
      ctx.fillText('Owner: ' + tile.owner.name, tile.x + tile.width / 2,
          tile.y + 7 * tile.height / 10); //draw owner's name

    //write name of tile
    ctx.font = 'bold 8pt sans-serif';
    ctx.fillText(tile.name, tile.x + tile.width / 2, tile.y + 9 * tile.height / 10);

    //draw buildings
    if (tile.numBuildings == 5) {
      ctx.fillStyle = 'red';
      ctx.fillRect(tile.x + tile.width / 2 - 10, tile.y + tile.height / 10, 20, 10);
    } else {
      for (int i = 0; i < tile.numBuildings; i++) {
        ctx.fillStyle = 'green';
        ctx.fillRect(tile.x + ((i + 1) / 5) * tile.width - 5, tile.y + tile.height / 10, 10, 10);
      }
    }
  }


  void drawPlayer(CanvasRenderingContext2D ctx, Player player) {
    //draw player token on board
    ctx.fillStyle = player.color;
    ctx.beginPath();
    ctx.arc(
        ((player.number + 1) / 8) * player.board.tileWidth +
            player.board.tiles[player.currentLocation].x,
        (2 / 5) * player.board.tileHeight + player.board.tiles[player.currentLocation].y,
        player.size / 2,
        0,
        PI * 2);
    ctx.closePath();
    ctx.fill();

    //draw player info inside of board area
    int infoX =
        (player.board.x + player.board.tileWidth * 1.75 + player.number * player.board.tileWidth * 1.25)
            .toInt();
    int infoY = (player.board.y + player.board.tileHeight * 2).toInt();
    ctx.fillStyle = player.color;
    ctx.font = 'bold 14pt sans-serif';
    ctx.fillText(player.name, infoX, infoY); //display "player name"

    ctx.fillStyle = 'black';
    ctx.font = '10pt sans-serif';
    ctx.fillText("Money: ", infoX, infoY + 20); //display "Money:"
    ctx.font = 'bold 10pt sans-serif';
    ctx.fillText('\$' + player.money.toStringAsFixed(2), infoX,
        infoY + 37); //display amount of money

    ctx.font = '10pt sans-serif';
    ctx.fillText(
        "Properties Owned:", infoX, infoY + 55); //display "Properties Owned:"
    ctx.font = '10pt sans-serif';

    for (Tile tile in player.ownedTiles) {
      //display owned properties
      ctx.fillText(
          tile.name, infoX, infoY + 70 + player.ownedTiles.indexOf(tile) * 15);
    }
  }

}
