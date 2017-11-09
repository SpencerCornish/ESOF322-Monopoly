import "package:test/test.dart";
import "package:monopoly/src/components/board/board.dart";

void main() {
  setUp(() {
    Board testBoard = new Board();
  });
  group("Board", () {
    test("some asyncronous test", () {
      bool someBool = true;
      expect(someBool, isTrue);
    });
  });
}
