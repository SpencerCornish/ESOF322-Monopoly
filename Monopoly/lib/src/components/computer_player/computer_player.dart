import '../app/app.dart';
import '../player/player.dart';
import '../board/board.dart';

class ComputerPlayer extends Player {

  App _app;


  ComputerPlayer(this._app, String name, int size, int number, String color, Board board ) : super(name, size, number, color, board);


}


