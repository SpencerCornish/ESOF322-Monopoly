import "package:test/test.dart";
//import "package:monopoly/src/components/app/app.dart";

void main() {
  setUp(() async {
    //App app = new App();
  });
  group("some group", () {
    test("some asyncronous test", () async {
      bool someBool = true;
      expect(someBool, isTrue);
    });
  });
}
