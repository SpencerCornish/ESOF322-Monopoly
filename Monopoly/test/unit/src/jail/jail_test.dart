import "package:test/test.dart";

void main() {
  setUp(() async {
// Jail jail = new Jail();
  });
  group("some group", () {
    test("some asyncronous test", () async {
      bool someBool = true;
      expect(someBool, isTrue);
    });
  });
}
