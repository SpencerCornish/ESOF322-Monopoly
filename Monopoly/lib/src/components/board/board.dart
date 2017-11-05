import 'dart:html';
import '../tiles/tile.dart';
import '../../data/constants.dart';

class Board {
  int x;
  int y;
  List<Tile> tiles;
  int tileSize;

  Board() {
    tiles = new List<Tile>(40);

    if(window.innerWidth > window.innerHeight)
      tileSize = ((window.innerHeight-50)~/11);
    else
      tileSize = ((window.innerWidth-50)~/11);
    x = (window.innerWidth / 2 - tileSize * 5.5).toInt();
    y = (window.innerHeight / 2 - tileSize * 5.5).toInt();

    List<String> spaces = readInfo();
    for (int i = 0; i < 10; i++) {                              //loop through each row
      int k = i * 13;                                           //starting index
      List<String> temp = new List<String>();                   //temporary strings indicating a single tile attribute list
      for (int j = k; j < k + 13; j++) {                        //loop through the size of a tile and initialize the tile attributes
        temp.add(spaces.elementAt(j));
      }
      k += 130;                                                 //iterate the counter for the overall string by a side of the board (bottom to left)
      print(temp);
      tiles[i] = new Tile(temp, x + i * tileSize, y, tileSize);                 //create a new tile on bottom
      temp.clear();                                             //reset the tile attribute list for a new tile

      for (int j = k; j < k + 13; j++) {
        temp.add(spaces.elementAt(j));
      }
      k += 130;                                                 //iterate the counter for the overall string by a side of the board (left to top)
      print(temp);
      tiles[i+10] = new Tile(temp, 10 * tileSize + x, y + i * tileSize, tileSize);           //create a new tile on left
      temp.clear();

      for (int j = k; j < k + 13; j++) {
        temp.add(spaces.elementAt(j));
      }
      k += 130;                                                 //iterate the counter for the overall string by a side of the board (top to right)
      print(temp);
      tiles[i+20] = new Tile(temp, (10-i) * tileSize + x, 10 * tileSize + y, tileSize);           //create a new tile on top
      temp.clear();

      for (int j = k; j < k + 13; j++) {
        temp.add(spaces.elementAt(j));
      }
      print(temp);
      tiles[i+30] = new Tile(temp, x, (10-i) * tileSize + y, tileSize);                 //create a new tile on right
    }
    for(Tile tile in tiles)
      print(tile.name);
  }

  List<String> readInfo() {
    String file = boardInfo;
    List<String> t = file.split(",");
    return t;
  }


  void draw(CanvasRenderingContext2D ctx) {
    for (Tile tile in tiles) tile.draw(ctx);
  }

  void resize(){
    //resize size of tile
    if(window.innerWidth > window.innerHeight)
      tileSize = (window.innerHeight-50)~/11;
    else
      tileSize = (window.innerWidth-50)~/11;

    //reset board x and y location
    x = (window.innerWidth / 2 - tileSize * 5.5).toInt();
    y = (window.innerHeight / 2 - tileSize * 5.5).toInt();

    //reset location and size of each tile
    for (int i = 0; i < 10; i++) {
      tiles[i].setLocation(x + i * tileSize, y);
      tiles[i].setSize(tileSize);
      tiles[i+10].setLocation(10 * tileSize + x, y + i * tileSize);
      tiles[i+10].setSize(tileSize);
      tiles[i+20].setLocation((10-i) * tileSize + x, 10 * tileSize + y);
      tiles[i+20].setSize(tileSize);
      tiles[i+30].setLocation(x, (10-i) * tileSize + y);
      tiles[i+30].setSize(tileSize);
    }
  }
}
