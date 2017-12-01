import "package:test/test.dart";
import "package:monopoly/src/components/board/board.dart";
import 'package:monopoly/src/data/constants.dart';

void main() {
  Board testBoard;
  setUp(() {
    testBoard = new Board(Constants.classicBoardInfo);
  });
  group("Board", () {
    test("readInfo() reads correctly", () {
      List<String> list = testBoard.readInfo(Constants.classicBoardInfo);
      expect(list.elementAt(0), "Go");
      expect(list.elementAt(7), "0");
      expect(list.elementAt(14), "Street");
    });
  });
}
