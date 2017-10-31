import "package:test/test.dart";
import "package:monopoly/src/components/tiles/railroad.dart";

void main() {
  setUp(() async {
    Railroad testRailroad = new Railroad("Doot Doot Railroad", 99, 400, 20);
  });
  group("some group", () {
    test("some asyncronous test", () async {
      bool someBool = true;
      expect(someBool, isTrue);
    });
  });
}
