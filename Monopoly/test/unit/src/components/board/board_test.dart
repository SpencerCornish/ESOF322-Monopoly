import "package:test/test.dart";
import "package:monopoly/src/components/board/board.dart";

void main() {
  Board testBoard;
  setUp(() {
    testBoard = new Board();
  });
  group("Board", () {
    test("returns true if readInfo() reads correctly", () {
      List<String> list = testBoard.readInfo();
      expect(list.elementAt(0), "Go");
      expect(list.elementAt(7), "0");
      expect(list.elementAt(14), "Street");
    });
  });
}
