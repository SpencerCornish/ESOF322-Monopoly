import "package:test/test.dart";
//import "package:monopoly/src/components/tiles/utility.dart";

void main() {
  setUp(() async {
    //Utility utility = new Utility("NWE", 99, 9000, 20);
  });
  group("some group", () {
    test("some asyncronous test", () async {
      bool someBool = true;
      expect(someBool, isTrue);
    });
  });
}
