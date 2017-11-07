import "package:test/test.dart";
import "package:monopoly/src/components/player/player.dart";

void main() {
  setUp(() async {
    //Player player = new Player();
  });
  group("some group", () {
    test("some asyncronous test", () async {
      bool someBool = true;
      expect(someBool, isTrue);
    });
  });

  Player testGoBankrupt;

  Player testGetOutOfJail;

  Player testRollDice;

  Player testNormalMove;

  Player testPayRent;

  Player testSellDeed;
}
