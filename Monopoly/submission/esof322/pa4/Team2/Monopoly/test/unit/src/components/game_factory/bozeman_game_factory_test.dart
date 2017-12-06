import "package:test/test.dart";
import "package:monopoly/src/components/game_factory/bozeman_game_factory.dart";
import "package:monopoly/src/components/board/board.dart";
import "package:monopoly/src/data/constants.dart";

void main() {
  setUp(() {});
  group("Bozeman Game Factory", () {
    test("createBoard() creates standard board", () {
      BozemanGameFactory bozemanBoard = new BozemanGameFactory();
      Board testBoard = bozemanBoard.createBoard();
      List<String> list = testBoard.readInfo(Constants.bozemanBoardInfo);
      expect(list.elementAt(0), "Go");
      expect(list.elementAt(7), "0");
      expect(list.elementAt(13), "Beall Avenue");
    });
  });
}
