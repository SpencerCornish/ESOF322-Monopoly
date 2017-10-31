import 'dart:html';
import '../tiles/tile.dart';

class Board {
  int x;
  int y;
  int size;
  List<Tile> tiles;

  Board() {
    tiles = new List<Tile>();
    size = 100;
    x = (window.innerWidth / 2).toInt() - size * 5;
    y = (window.innerHeight / 2).toInt() - size * 5;
    for (int i = 0; i < 10; i++) {
      tiles.add(new Tile("name", x + i * size, y, size));
      tiles.add(new Tile("name", x, y + i * size, size));
      tiles.add(new Tile("name", x + i * size, 9 * size + y, size));
      tiles.add(new Tile("name", 9 * size + x, y + i * size, size));
    }
  }

  void draw(CanvasRenderingContext2D ctx) {
    for(Tile tile in tiles)
      tile.draw(ctx);
  }
}
