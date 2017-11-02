import "package:test/test.dart";
import "package:monopoly/src/components/tiles/tile.dart";

void main() {
  setUp(() async {
    Tile testTile =
    new Tile("testName", 11, 11, 3, "Green", 100, 70, 50,/* player, */ 30);
  });
  group("some group", () {
    test("some asyncronous test", () async {
      bool someBool = true;
      expect(someBool, isTrue);
    });
  });
}