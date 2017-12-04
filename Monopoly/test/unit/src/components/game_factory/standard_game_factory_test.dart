import "package:test/test.dart";
import "package:monopoly/src/components/game_factory/standard_game_factory.dart";
import "package:monopoly/src/components/board/board.dart";
import "package:monopoly/src/data/constants.dart";

void main() {
  setUp(() {});
  group("Standard Game Factory", () {
    test("createBoard() creates standard board", () {
      StandardGameFactory classicBoard = new StandardGameFactory();
      Board testBoard = classicBoard.createBoard();
      List<String> list = testBoard.readInfo(Constants.classicBoardInfo);
      expect(list.elementAt(0), "Go");
      expect(list.elementAt(7), "0");
      expect(list.elementAt(14), "Street");
    });
  });
}
