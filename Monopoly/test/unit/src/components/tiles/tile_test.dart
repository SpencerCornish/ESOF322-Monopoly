import "package:test/test.dart";
import "package:monopoly/src/components/tiles/tile.dart";

void main() {
  Tile testProperty;
  setUp(() async {
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

  group("Tile", () {
    group("Groupname", () {});
    test("x position", () async {
      expect(testProperty.x, 0);
      testProperty.setLocation(20, 15);
      expect(testProperty.x, 20);
    });
  });
  /*
  Tile testCalcRent;
  Tile testAuction;
  */
}
