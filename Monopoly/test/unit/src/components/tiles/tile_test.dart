import "package:test/test.dart";
import "package:monopoly/src/components/tiles/tile.dart";
import "package:monopoly/src/components/player/player.dart";
import "package:monopoly/src/components/board/board.dart";

void main() {
  Tile testProperty;
  setUp(() {
    List<String> info = new List<String>();
    info.add('Mediterranean Avenue');
    info.add('Street');
    info.add('Brown');
    info.add('1');
    info.add('60');
    info.add('50');
    info.add('2');
    info.add('10');
    info.add('30');
    info.add('90');
    info.add('160');
    info.add('250');
    info.add('2');
    testProperty = new Tile(info, 0, 20, 50, 100);
    testProperty.setOwner(new Player("Test Player", 1, 1, "red", new Board()));
  });

  group("Tile", () {
    test("returns true if tile creation values are correct", () {
      //test the tile creation process
      expect(testProperty.name, "Mediterranean Avenue");
      expect(testProperty.type, "Street");
      expect(testProperty.color, "Brown");
      expect(testProperty.position, 1);
      expect(testProperty.price, 60);
      expect(testProperty.buildPrice, 50);
      expect(testProperty.baseRent, 2);
      expect(testProperty.rent1, 10);
      expect(testProperty.rent2, 30);
      expect(testProperty.rent3, 90);
      expect(testProperty.rent4, 160);
      expect(testProperty.rent5, 250);
      expect(testProperty.totalNum, 2);
    });
    test("returns true if positional functions work correctly", () {
      //test the location setting of the tile
      expect(testProperty.x, 0); //these values reflect the initial settings
      expect(testProperty.y, 20);
      testProperty.setLocation(20, 15);
      expect(testProperty.x, 20);
      expect(testProperty.y, 15);
    });
    test("returns true if dimensional functions operate correctly", () {
      //test the tile's setSize method
      expect(testProperty.width, 50);
      expect(testProperty.height, 100);
      testProperty.setSize(14, 27);
      expect(testProperty.width, 14);
      expect(testProperty.height, 27);
    });
    test("returns true if setOwner() works correctly", () {
      //test the tile's setOwner() method
      Player john = new Player("John Doe", 1, 1, "red", new Board());
      testProperty.setOwner(john);
      expect(testProperty.owner, john);
    });
    test("returns true if build() works correctly", () {
      //test the tile's build() method
      testProperty.build(4);
      expect(testProperty.numBuildings, 4);
      testProperty.build(1);
      expect(testProperty.numBuildings, 4);
      testProperty.build(7);
      expect(testProperty.numBuildings, 4);
    });
    test("returns true if calcRent() works correctly", () {
      //test the tile's calcRent() method
      testProperty.calcRent(5);
      expect(testProperty.currentRent, testProperty.baseRent);
      testProperty.build(3);
      expect(testProperty.currentRent, testProperty.rent3);
      List<String> info = new List<String>();
      info.add("Water Works");
      info.add("Utility");
      info.add("None");
      info.add("28");
      info.add("150");
      info.add("0");
      info.add("4");
      info.add("0");
      info.add("0");
      info.add("0");
      info.add("0");
      info.add("0");
      info.add("0");
      Tile testUtility = new Tile(info, 1, 1, 1, 1);
      testUtility.setOwner(new Player("Test Guy", 1, 1, "red", new Board()));
      testUtility.calcRent(11);
      expect(testUtility.currentRent, 44);
      info.clear;
      info.add("Short Line");
      info.add("Railroad");
      info.add("None");
      info.add("35");
      info.add("200");
      info.add("0");
      info.add("25");
      info.add("0");
      info.add("0");
      info.add("0");
      info.add("0");
      info.add("0");
      info.add("0");
      Tile testRailroad = new Tile(info, 1, 1, 1, 1);
      testRailroad.calcRent(0);
      expect(testRailroad.currentRent, testRailroad.baseRent);
    });
  });
}
