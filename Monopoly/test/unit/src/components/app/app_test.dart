import "package:test/test.dart";
import "package:monopoly/src/components/app/app.dart";

void main() {
  App testApp;
  setUp(() {
    testApp = new App();
  });
  group("App", () {
    test("setup completion is correct", () {
      //test that setup initializes values correctly
      expect(testApp.random, isNot(null));
      expect(testApp.turnNum, 1);
      expect(testApp.turnLimit, 10);
      expect(testApp.gameOver, false);
      expect(testApp.shouldRollAgain, true);
      expect(testApp.playerList.length, 6);
      expect(testApp.renderer, isNot(null));
    });
    test("button setup is correct", () {
      //test that button setup initializes values correctly
      expect(testApp.buttons.length, 13);
      expect(testApp.buttons.elementAt(5).text, "Roll Dice");
      expect(testApp.buttons.elementAt(8).text, "Mortgage Property");
    });
    test("updateButtons functions correctly", () {
      //tests initial setup of updateButtons()
      testApp.updateButtons();
      expect(testApp.isRollDiceAvailable, true);
      expect(testApp.isBuyPropertyAvailable, false);
      expect(testApp.isAuctionPropertyAvailable, false);
      expect(testApp.isMortgagePropertyAvailable, false);
      expect(testApp.isBuyBuildingsAvailable, false);
      expect(testApp.isSellBuildingsAvailable, false);
      expect(testApp.isEndTurnAvailable, false);
    });
    test("nextPlayer() works correctly", () {
      //test that nextPlayer() advances the current player
      expect(testApp.activePlayer, testApp.playerList.first);
      testApp.nextPlayer();
      expect(testApp.activePlayer, testApp.playerList.elementAt(2));
      testApp.nextPlayer();
      expect(testApp.activePlayer, testApp.playerList.elementAt(3));
    });
  });
}
