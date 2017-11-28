import 'dart:html';
import '../tiles/tile.dart';

class GUI {

  GUI(){}

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
}
