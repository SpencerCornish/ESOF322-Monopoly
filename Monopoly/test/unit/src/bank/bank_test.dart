import "package:test/test.dart";

void main() {
  setUp(() async {
    // Bank bank = new Bank();
  });
  group("some group", () {
    test("some asyncronous test", () async {
      bool someBool = true;
      expect(someBool, isTrue);
    });
  });
}
