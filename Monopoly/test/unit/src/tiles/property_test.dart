import "package:test/test.dart";
import "package:monopoly/src/components/tiles/property.dart";

void main() {
  setUp(() async {
    Property testProperty =
        new Property("testName", 11, "Green", 2000, 20, 10, 100);
  });
  group("some group", () {
    test("some asyncronous test", () async {
      bool someBool = true;
      expect(someBool, isTrue);
    });
  });
}
