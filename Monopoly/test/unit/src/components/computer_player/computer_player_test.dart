import "package:test/test.dart";
import "package:monopoly/src/components/computer_player/computer_player.dart";

void main() {
  ComputerPlayer cp;
  setUp(() {
    cp = new ComputerPlayer(null, "Test Comp", 0, 1, "black", null);
  });
  group("Computer Player", () {
    test("creation values are correct", () {
      //tests the variable initialization for a computer player
      expect(cp.name, "Test Comp");
      expect(cp.size, 0);
      expect(cp.number, 1);
      expect(cp.color, "black");
      expect(cp.board, null);
    });
  });
}
