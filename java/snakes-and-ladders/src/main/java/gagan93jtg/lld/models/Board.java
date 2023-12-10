package gagan93jtg.lld.models;

import gagan93jtg.lld.errors.ObjectOutOfRange;

import java.security.InvalidParameterException;
import java.util.ArrayList;
import java.util.HashMap;

public class Board {
  private int size;
  private HashMap<Integer, Integer> snakePoints, ladderPoints, allPoints;

  public Board(int size, ArrayList<Snake> snakes, ArrayList<Ladder> ladders) {
    this.size = size;
    this.allPoints = new HashMap<>();

    markSnakes(snakes);
    markLadders(ladders);
  }

  public int getLastCell() {
    return size * size;
  }

  public HashMap<Integer, Integer> getSnakePoints() {
    return snakePoints;
  }

  public HashMap<Integer, Integer> getLadderPoints() {
    return ladderPoints;
  }

  private void markSnakes(ArrayList<Snake> snakes) {
    this.snakePoints = new HashMap<>();
    for (Snake snake : snakes) {
      int snakeStartValue = allPoints.putIfAbsent(snake.getStart(), 1) == null ? 0 : 1;
      int snakeEndValue = allPoints.putIfAbsent(snake.getEnd(), 1) == null ? 0 : 1;

      if (snakeStartValue == 1 || snakeEndValue == 1) {
        throw new InvalidParameterException("Snake overlaps with existing snake or ladder " + snake.getStart() + ", " + snake.getEnd());
      }

      if (snake.getStart() > getLastCell()) {
        throw new ObjectOutOfRange("Snake start value " + snake.getStart() + " is out of board range " + getLastCell());
      }
      snakePoints.put(snake.getStart(), snake.getEnd());
    }
  }

  private void markLadders(ArrayList<Ladder> ladders) {
    this.ladderPoints = new HashMap<>();
    for (Ladder ladder : ladders) {
      int ladderStartValue = allPoints.putIfAbsent(ladder.getStart(), 1) == null ? 0 : 1;
      int ladderEndValue = allPoints.putIfAbsent(ladder.getEnd(), 1) == null ? 0 : 1;

      if (ladderStartValue == 1 || ladderEndValue == 1) {
        throw new InvalidParameterException("Ladder overlaps with existing ladder or snake " + ladder.getStart() + ", " + ladder.getEnd());
      }

      if (ladder.getEnd() > getLastCell()) {
        throw new ObjectOutOfRange("Ladder start value " + ladder.getStart() + " is out of board range " + getLastCell());
      }
      ladderPoints.put(ladder.getStart(), ladder.getEnd());
    }
  }
}
