import 'package:monopoly/src/components/board/board.dart';

abstract class GameFactory{
  Board createBoard();
}