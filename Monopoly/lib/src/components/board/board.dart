import 'dart:html';
import '../tiles/tile.dart';

class Board {
  int x;
  int y;
  int tileSize;
  List<Tile> tiles;

  Board() {
    tiles = new List<Tile>();
    if(window.innerWidth > window.innerHeight)
      tileSize = ((window.innerHeight-50)/11).toInt();
    else
      tileSize = ((window.innerWidth-50)/11).toInt();
    x = (window.innerWidth / 2 - tileSize * 5.5).toInt();
    y = (window.innerHeight / 2 - tileSize * 5.5).toInt();
    for (int i = 0; i < 10; i++) {
      tiles.add(new Tile("name", x + i * tileSize, y, tileSize));
      tiles.add(new Tile("name", x, y + (i+1) * tileSize, tileSize));
      tiles.add(new Tile("name", x + (i+1) * tileSize, 10 * tileSize + y, tileSize));
      tiles.add(new Tile("name", 10 * tileSize + x, y + i * tileSize, tileSize));
    }
  }

  void draw(CanvasRenderingContext2D ctx) {
    for(Tile tile in tiles)
      tile.draw(ctx);
  }

  void resize(){
    if(window.innerWidth > window.innerHeight)
      tileSize = ((window.innerHeight-50)/11).toInt();
    else
      tileSize = ((window.innerWidth-50)/11).toInt();
    x = (window.innerWidth / 2 - tileSize * 5.5).toInt();
    y = (window.innerHeight / 2 - tileSize * 5.5).toInt();
    tiles = new List<Tile>();
    for (int i = 0; i < 10; i++) {
      tiles.add(new Tile("name", x + i * tileSize, y, tileSize));
      tiles.add(new Tile("name", x, y + (i+1) * tileSize, tileSize));
      tiles.add(new Tile("name", x + (i+1) * tileSize, 10 * tileSize + y, tileSize));
      tiles.add(new Tile("name", 10 * tileSize + x, y + i * tileSize, tileSize));
    }
  }
}
