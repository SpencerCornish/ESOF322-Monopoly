import "package:test/test.dart";
import "package:monopoly/src/components/tiles/tile.dart";

void main() {
  Tile testProperty;
  setUp(() async {
    testProperty = new Tile("testName", 0, 0, 11, "Green", 2000, 20, 10, 100);
  });

  group("Tile", () {
    group("Groupname", () {});
    test("x position", () async {
      expect(testProperty.x, 0);
      testProperty.setLocation(20, 15);
      expect(testProperty.x, 20);
    });
  });
}
