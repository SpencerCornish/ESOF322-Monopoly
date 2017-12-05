import "package:test/test.dart";
import "package:monopoly/src/components/player/player.dart";
import "package:monopoly/src/components/tiles/tile.dart";
import "package:monopoly/src/components/board/board.dart";
import "package:monopoly/src/data/constants.dart";

void main() {
  Player testPlayer;
  Tile testProperty;
  Board testBoard = new Board(Constants.classicBoardInfo);

  setUp(() {
    testPlayer = new Player("John Doe", 1, 1, "Cyan", testBoard);
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
  });

  group("Player", () {
    test("creation values are correct", () {
      //tests the initial values of the player instance
      expect(testPlayer.name, "John Doe");
      expect(testPlayer.size, 1);
      expect(testPlayer.number, 1);
      expect(testPlayer.color, "Cyan");
      expect(testPlayer.board, testBoard);
      expect(testPlayer.money, 1500);
      expect(testPlayer.ownedTiles.length, 0);
    });
    test("move() works correctly", () {
      //tests the move function
      expect(testPlayer.position, 0);
      testPlayer.move(3);
      expect(testPlayer.position, 3);
      testPlayer.move(38);
      expect(testPlayer.position, 1);
      expect(testPlayer.money, 1700);
    });
    test("buyTile() works correctly", () {
      //tests the buy tile function
      //test with property
      expect(testPlayer.ownedTiles.length, 0);
      expect(testProperty.owner, null);
      testPlayer.buyTile(testProperty);
      expect(testProperty.owner, testPlayer);
      expect(testPlayer.ownedTiles.elementAt(0), testProperty);
      expect(testPlayer.money, 1440);
      //test with utility
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
      testPlayer.buyTile(testUtility);
      expect(testUtility.owner, testPlayer);
      expect(testPlayer.ownedTiles.elementAt(1), testUtility);
      expect(testPlayer.money, 1290);
      //test with railroad
      info = new List<String>();
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
      testPlayer.buyTile(testRailroad);
      expect(testRailroad.owner, testPlayer);
      expect(testPlayer.ownedTiles.elementAt(2), testRailroad);
      expect(testPlayer.money, 1090);
    });
    test("toggleMortgage() works correctly", () {
      //tests the toggleMortgage function
      expect(testProperty.isMortgaged, false);
      testPlayer.toggleMortgage(testProperty);
      expect(testProperty.isMortgaged, true);
      expect(testPlayer.money, 1530);
      testPlayer.toggleMortgage(testProperty);
      expect(testProperty.isMortgaged, false);
      expect(testPlayer.money, 1497);
    });
    test("buyBuilding() works correctly", () {
      //tests the building purchase function
      expect(testProperty.numBuildings, 0);
      expect(testPlayer.money, 1500);
      testPlayer.buyBuilding(testProperty);
      expect(testProperty.numBuildings, 0);
      expect(testPlayer.money, 1500);
      testProperty.isInMonopoly = true;
      testPlayer.buyBuilding(testProperty);
      expect(testProperty.numBuildings, 1);
      expect(testPlayer.money, 1450);
      testPlayer.buyBuilding(testProperty);
      testPlayer.buyBuilding(testProperty);
      testPlayer.buyBuilding(testProperty);
      expect(testProperty.numBuildings, 4);
      expect(testPlayer.money, 1300);
    });
    test("sellBuilding() works correctly", () {
      //tests the building sale function
      expect(testPlayer.money, 1500);
      expect(testProperty.numBuildings, 0);
      testProperty.isInMonopoly = true;
      testPlayer.buyBuilding(testProperty);
      testPlayer.sellBuilding(testProperty);
      expect(testPlayer.money, 1475);
      expect(testProperty.numBuildings, 0);
    });
    test("setName() works correctly", () {
      //tests the name setter function
      expect(testPlayer.name, "John Doe");
      testPlayer.name = "Ada Lovelace";
      expect(testPlayer.name, "Ada Lovelace");
    });
    test("payRent() works correctly", () {
      //tests the rent payment function
      expect(testPlayer.money, 1500);
      Player testOwner = new Player("Groot", 5, 2, "Brown", null);
      expect(testOwner.money, 1500);
      testPlayer.payRent(testOwner, testProperty, 5);
      expect(testPlayer.money, 1498);
      expect(testOwner.money, 1502);
    });
  });
}
