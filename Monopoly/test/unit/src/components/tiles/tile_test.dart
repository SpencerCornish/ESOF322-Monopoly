import "package:test/test.dart";
import "package:monopoly/src/components/tiles/tile.dart";
import "package:monopoly/src/components/player/player.dart";

void main() {
  Tile testProperty;
  Player testPlayer;

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
    testPlayer = new Player("Test Player", 1, 1, "red", null);
    testProperty.setOwner(testPlayer);
  });

  group("Tile", () {
    test("creation values are correct", () {
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
    test("positional values are correct", () {
      //test the location setting of the tile
      expect(testProperty.x, 0); //these values reflect the initial settings
      expect(testProperty.y, 20);
      testProperty.setLocation(20, 15);
      expect(testProperty.x, 20);
      expect(testProperty.y, 15);
    });
    test("dimensional functions operate correctly", () {
      //test the tile's setSize method
      expect(testProperty.width, 50);
      expect(testProperty.height, 100);
      testProperty.setSize(14, 27);
      expect(testProperty.width, 14);
      expect(testProperty.height, 27);
    });
    test("setOwner() works correctly", () {
      //test the tile's setOwner() method
      Player john = new Player("John Doe", 1, 1, "red", null);
      testProperty.setOwner(john);
      expect(testProperty.owner, john);
    });
    test("build() works correctly", () {
      //test the tile's build() method
      testProperty.build(4);
      expect(testProperty.numBuildings, 4);
      testProperty.build(1);
      expect(testProperty.numBuildings, 4);
      testProperty.build(7);
      expect(testProperty.numBuildings, 4);
    });

    test("calcRent() works correctly for a property", () {
      //test the tile's calcRent() method on a property tile
      testProperty.calcRent(5);
      expect(testProperty.currentRent, testProperty.baseRent);
      testProperty.build(3);
      expect(testProperty.currentRent, testProperty.rent3);
    });

    test("calcRent() works correctly for a utility", () {
      //test the tile's calcRent() method on a utility tile
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
      testUtility.setOwner(testPlayer);
      testUtility.calcRent(11);
      expect(testUtility.currentRent, 44);
    });
    test("calcRent() works correctly for a railroad", () {
      //test the tile's calcRent() method on a railroad tile
      List<String> info = new List<String>();
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
      testRailroad.setOwner(testPlayer);
      testRailroad.calcRent(0);
      expect(testRailroad.currentRent, testRailroad.baseRent);
    });
  });
}
