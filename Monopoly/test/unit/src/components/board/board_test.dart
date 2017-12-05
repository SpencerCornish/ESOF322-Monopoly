import "package:test/test.dart";
import "package:monopoly/src/components/board/board.dart";
import 'package:monopoly/src/data/constants.dart';

void main() {
  Board testBoard;
  Board testBoard2;
  setUp(() {
    testBoard = new Board(Constants.classicBoardInfo);
    testBoard2 = new Board(Constants.bozemanBoardInfo);
  });
  group("Board", () {
    test("readInfo() reads correctly for classic board", () {
      List<String> list = testBoard.readInfo(Constants.classicBoardInfo);
      expect(list.elementAt(0), "Go");
      expect(list.elementAt(7), "0");
      expect(list.elementAt(14), "Street");
      expect(list.elementAt(39), "Baltic Avenue");
    });
    test("readInfo() reads correctly for Bozeman board", () {
      List<String> list = testBoard2.readInfo(Constants.bozemanBoardInfo);
      expect(list.elementAt(0), "Go");
      expect(list.elementAt(7), "0");
      expect(list.elementAt(13), "Beall Avenue");
      expect(list.elementAt(39), "Villard Street");
    });
  });
}
