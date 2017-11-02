import 'dart:html';
import 'dart:io' as fileStuff;
import 'dart:convert';
import 'dart:async';
import '../tiles/tile.dart';

class Board {
  int x;
  int y;
  List<Tile> tiles;
  int tileSize;

  Board() {
    String color;
    int price;
    int baseRent;
    int mortgage;
    int buildingPrice;
    tiles = new List<Tile>();

    Future<List<String>> spaces = readInfo();
    Completer c = new Completer();
    c.complete(spaces);
    

    if(window.innerWidth > window.innerHeight)
      tileSize = ((window.innerHeight-50)/11).toInt();
    else
      tileSize = ((window.innerWidth-50)/11).toInt();
    x = (window.innerWidth / 2 - tileSize * 5.5).toInt();
    y = (window.innerHeight / 2 - tileSize * 5.5).toInt();

    for (int i = 0; i < 10; i++) {
      tiles.add(new Tile("name", x + i * tileSize, y, tileSize, color, price, baseRent,
          mortgage, buildingPrice));
      tiles.add(new Tile("name", x, y + (i + 1) * tileSize, tileSize, color, price,
          baseRent, mortgage, buildingPrice));
      tiles.add(new Tile("name", x + (i + 1) * tileSize, 10 * tileSize + y, tileSize, color,
          price, baseRent, mortgage, buildingPrice));
      tiles.add(new Tile("name", 10 * tileSize + x, y + i * tileSize, tileSize, color,
          price, baseRent, mortgage, buildingPrice));
    }
  }

  Future<List<String>> readInfo() async {
    var file = await new fileStuff.File('../data/board.csv').readAsString();
    List<String> t = file.split(",");
    return t;
  }


  void draw(CanvasRenderingContext2D ctx) {
    for (Tile tile in tiles) tile.draw(ctx);
  }

  void resize(){
    //resize size of tile
    if(window.innerWidth > window.innerHeight)
      tileSize = ((window.innerHeight-50)/11).toInt();
    else
      tileSize = ((window.innerWidth-50)/11).toInt();

    //reset board x and y location
    x = (window.innerWidth / 2 - tileSize * 5.5).toInt();
    y = (window.innerHeight / 2 - tileSize * 5.5).toInt();

    //reset location and size of each tile
    for (int i = 0; i < 10; i++) {
      tiles[i].setLocation(x + i * tileSize, y);
      tiles[i].setSize(tileSize);
      tiles[i+10].setLocation(x, y + (i + 1) * tileSize);
      tiles[i+10].setSize(tileSize);
      tiles[i+20].setLocation(x + (i + 1) * tileSize, 10 * tileSize + y);
      tiles[i+20].setSize(tileSize);
      tiles[i+30].setLocation(10 * tileSize + x, y + i * tileSize);
      tiles[i+30].setSize(tileSize);
    }
  }
}
