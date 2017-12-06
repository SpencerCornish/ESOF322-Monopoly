import 'package:monopoly/src/components/board/board.dart';
import 'package:monopoly/src/components/game_factory/game_factory.dart';
import 'package:monopoly/src/data/constants.dart';

//represents a concrete gameFactory for classic theme
class StandardGameFactory implements GameFactory {
  Board createBoard() {
    String file = Constants.classicBoardInfo;
    return new Board(file);
  }
}
