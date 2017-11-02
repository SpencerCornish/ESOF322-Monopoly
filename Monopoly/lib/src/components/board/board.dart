import 'dart:html';
import '../tiles/tile.dart';

class Board {
  int x;
  int y;
  int size;
  String color;
  int price;
  int baseRent;
  int mortgage;
  int buildingPrice;
  List<Tile> tiles;

  Board() {
    tiles = new List<Tile>();
    size = 75;
    x = (window.innerWidth / 2 - size * 5.5).toInt();
    y = (window.innerHeight / 2 - size * 5.5).toInt();
    for (int i = 0; i < 10; i++) {
      tiles.add(new Tile("name", x + i * size, y, size, color, price, baseRent, mortgage, buildingPrice));
      tiles.add(new Tile("name", x, y + (i+1) * size, size, color, price, baseRent, mortgage, buildingPrice));
      tiles.add(new Tile("name", x + (i+1) * size, 10 * size + y, size, color, price, baseRent, mortgage, buildingPrice));
      tiles.add(new Tile("name", 10 * size + x, y + i * size, size, color, price, baseRent, mortgage, buildingPrice));
    }
  }

  void draw(CanvasRenderingContext2D ctx) {
    for(Tile tile in tiles)
      tile.draw(ctx);
  }
}
