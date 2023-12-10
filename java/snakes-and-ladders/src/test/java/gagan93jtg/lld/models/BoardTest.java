package gagan93jtg.lld.models;

import gagan93jtg.lld.errors.ObjectOutOfRange;
import org.junit.Test;

import java.security.InvalidParameterException;
import java.util.ArrayList;
import static org.junit.Assert.assertEquals;

public class BoardTest {
  Board board;
  ArrayList<Snake> snakes;
  ArrayList<Ladder> ladders;
  public BoardTest() {
    this.snakes = new ArrayList<Snake>();
    this.ladders = new ArrayList<Ladder>();
    this.board = new Board(10, snakes, ladders);
  }

  @Test
  public void testBoardSize() {
    assertEquals(board.getLastCell(), 100);
  }

  @Test(expected = InvalidParameterException.class)
  public void overlappingSnakesAndLadders() {
    Snake snake = new Snake(30, 5);
    Ladder ladder = new Ladder(5, 15);

    ladders.add(ladder);
    snakes.add(snake);

    board = new Board(10, snakes, ladders);
  }

  @Test(expected = ObjectOutOfRange.class)
  public void snakeOutOfRange() {
    Snake snake = new Snake(101, 99);
    snakes = new ArrayList<>();
    snakes.add(snake);
    board = new Board(10, snakes, new ArrayList<Ladder>());
  }

  @Test(expected = ObjectOutOfRange.class)
  public void ladderOutOfRange() {
    Ladder ladder = new Ladder(95, 101);
    ladders = new ArrayList<>();
    ladders.add(ladder);
    board = new Board(10, new ArrayList<Snake>(), ladders);
  }
}
