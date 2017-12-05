import 'package:monopoly/src/components/board/board.dart';
import 'package:monopoly/src/components/game_factory/game_factory.dart';
import 'package:monopoly/src/data/constants.dart';

//represents concrete gameFactory for Bozeman theme
class BozemanGameFactory implements GameFactory {
  Board createBoard() {
    String file = Constants.bozemanBoardInfo;
    return new Board(file);
  }
}
