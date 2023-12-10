package gagan93jtg.lld.services;

import gagan93jtg.lld.models.Ladder;
import gagan93jtg.lld.models.Player;
import gagan93jtg.lld.models.Snake;
import org.junit.Test;

import java.util.ArrayList;

import static org.junit.Assert.assertEquals;

public class GameServiceTest {
  GameService gameService;
  Player gaganPlayer, soniaPlayer;

  public GameServiceTest() {
    ArrayList<Player> players = getPlayers();
    ArrayList<Snake> snakes = getSnakes();
    ArrayList<Ladder> ladders = getLadders();
    int boardSize = 10;
    int diceRange = 6;

    this.gameService = new GameService(players, snakes, ladders, boardSize, diceRange);
  }

  @Test
  public void testDiceValuesToStartGame() {
    gameService.takeTurn(gaganPlayer, 4);
    assertEquals(gaganPlayer.getCurrentCell(), -1);
    gameService.takeTurn(soniaPlayer, 1);
    assertEquals(soniaPlayer.getCurrentCell(), 1);
  }

  @Test
  public void testNormalDiceMovement() {
    gaganPlayer.setCurrentCell(1);
    gameService.takeTurn(gaganPlayer, 4);
    assertEquals(gaganPlayer.getCurrentCell(), 5);
  }

  @Test
  public void testSnake() {
    gaganPlayer.setCurrentCell(29);
    gameService.takeTurn(gaganPlayer, 3);
    assertEquals(gaganPlayer.getCurrentCell(), 10);
  }

  @Test
  public void testLadder() {
    gaganPlayer.setCurrentCell(25);
    gameService.takeTurn(gaganPlayer, 3);
    assertEquals(gaganPlayer.getCurrentCell(), 74);
  }

  @Test
  public void testBoundaryCondition() {
    gaganPlayer.setCurrentCell(99);
    gameService.takeTurn(gaganPlayer, 3);
    assertEquals(gaganPlayer.getCurrentCell(), 99);
  }

  public void testPlayerWon() {
    gaganPlayer.setCurrentCell(99);
    gameService.takeTurn(gaganPlayer, 1);
    assertEquals(gaganPlayer.isWon(), true);
  }

  private ArrayList<Player> getPlayers() {
    ArrayList<Player> players = new ArrayList<>();
    this.gaganPlayer = new Player("Gagan", Player.Colors.BLUE);
    this.soniaPlayer = new Player("Sonia", Player.Colors.RED);
    players.add(gaganPlayer);
    players.add(soniaPlayer);

    return players;
  }

  private ArrayList<Snake> getSnakes() {
    ArrayList<Snake> snakes = new ArrayList<>();
    snakes.add(new Snake(36, 6));
    snakes.add(new Snake(32, 10));
    snakes.add(new Snake(37, 5));
    snakes.add(new Snake(63, 18));
    snakes.add(new Snake(88, 24));
    snakes.add(new Snake(97, 56));

    return snakes;
  }

  private ArrayList<Ladder> getLadders() {
    ArrayList<Ladder> ladders = new ArrayList<>();
    ladders.add(new Ladder(3, 38));
    ladders.add(new Ladder(4, 14));
    ladders.add(new Ladder(28, 74));
    ladders.add(new Ladder(71, 92));

    return ladders;
  }
}
