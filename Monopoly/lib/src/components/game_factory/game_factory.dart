import 'package:monopoly/src/components/board/board.dart';

//interface for abstract factory, allows board creation
abstract class GameFactory {
  Board createBoard();
}
