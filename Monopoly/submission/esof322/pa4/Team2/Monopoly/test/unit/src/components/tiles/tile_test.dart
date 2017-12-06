import "package:test/test.dart";
import "package:monopoly/src/components/tiles/tile.dart";
import "package:monopoly/src/components/player/player.dart";

void main() {
  Tile testProperty;
  Player testPlayer;

  //setup function performed every test
  setUp(() {
    //tile attribute list
    List<String> info = new List<String>()
      ..add('Mediterranean Avenue')
      ..add('Street')
      ..add('Brown')
      ..add('1')
      ..add('60')
      ..add('50')
      ..add('2')
      ..add('10')
      ..add('30')
      ..add('90')
      ..add('160')
      ..add('250')
      ..add('2');
    testProperty = new Tile(info, 0, 20, 50, 100);
    testPlayer = new Player("Test Player", 1, 1, "red", null);
    testProperty.setOwner(testPlayer);
  });

  group("Tile", () {
    //group of tile related tests
    test("creation values are correct", () {
      //test the tile creation values
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
    test("addBuilding() works correctly", () {
      //test the tile's addBuilding() method
      testProperty.addBuilding();
      expect(testProperty.numBuildings, 1);
    });
    group("calcRent()", () {
      test("works correctly for a property", () {
        //test the tile's calcRent() method on a property tile
        expect(testProperty.currentRent, testProperty.baseRent);
        testProperty.calcRent(5);
        expect(testProperty.currentRent, testProperty.baseRent);
        testProperty.addBuilding();
        testProperty.addBuilding();
        testProperty.addBuilding();
        expect(testProperty.currentRent, testProperty.rent3);
      });
      test("rent doubles when _isInMonopoly", () {
        expect(testProperty.isInMonopoly, false);
        expect(testProperty.currentRent, 2);
        testProperty.isInMonopoly = true;
        testProperty.calcRent(5);
        expect(testProperty.currentRent, 4);
      });
      test("works correctly for a property", () {
        //test the tile's calcRent() method on a property tile
        expect(testProperty.currentRent, testProperty.baseRent);
        testProperty.calcRent(5);
        expect(testProperty.currentRent, testProperty.baseRent);
        testProperty.addBuilding();
        expect(testProperty.currentRent, testProperty.rent1);
        testProperty.addBuilding();
        expect(testProperty.currentRent, testProperty.rent2);
        testProperty.addBuilding();
        expect(testProperty.currentRent, testProperty.rent3);
        testProperty.addBuilding();
        expect(testProperty.currentRent, testProperty.rent4);
        testProperty.addBuilding();
        expect(testProperty.currentRent, testProperty.rent5);
      });

      test("works correctly for a utility", () {
        //test the tile's calcRent() method on a utility tile
        List<String> info = new List<String>()
          ..add("Water Works")
          ..add("Utility")
          ..add("None")
          ..add("28")
          ..add("150")
          ..add("0")
          ..add("4")
          ..add("0")
          ..add("0")
          ..add("0")
          ..add("0")
          ..add("0")
          ..add("0");
        Tile testUtility = new Tile(info, 1, 1, 1, 1);
        testUtility.setOwner(testPlayer);
        testUtility.calcRent(11);
        expect(testUtility.currentRent, 44);
      });
      test("works correctly for a railroad", () {
        //test the tile's calcRent() method on a railroad tile
        List<String> info = new List<String>()
          ..add("Short Line")
          ..add("Railroad")
          ..add("None")
          ..add("35")
          ..add("200")
          ..add("0")
          ..add("25")
          ..add("0")
          ..add("0")
          ..add("0")
          ..add("0")
          ..add("0")
          ..add("0");
        Tile testRailroad = new Tile(info, 1, 1, 1, 1);
        expect(testRailroad.currentRent, testRailroad.baseRent);
        testRailroad.setOwner(testPlayer);
        testRailroad.calcRent(0);
        expect(testRailroad.currentRent, testRailroad.baseRent);
        testRailroad.numberOwned = 2;
        testRailroad.calcRent(0);
        expect(testRailroad.currentRent, 50);
        testRailroad.numberOwned = 3;
        testRailroad.calcRent(0);
        expect(testRailroad.currentRent, 100);
        testRailroad.numberOwned = 4;
        testRailroad.calcRent(0);
        expect(testRailroad.currentRent, 200);
      });
    });
  });
}
