package gagan93jtg.lld.models;

import gagan93jtg.lld.errors.HitTrailError;
import org.junit.Test;

import java.util.ArrayList;

import static org.junit.Assert.assertEquals;

public class SnakeTest {
  @Test
  public void testInvalidMove() {
    Snake snake = new Snake(3, 10);
    snake.move(ValidDirection.LEFT);

    assertEquals(snake.getCoordinates().get(0), new Coordinate(1, 1));
    assertEquals(snake.getCoordinates().get(1), new Coordinate(2, 1));
    assertEquals(snake.getCoordinates().get(2), new Coordinate(3, 1));
  }

  @Test
  public void testSnakeGrowth() {
    Snake snake = new Snake(3, 10);
    snake.move(ValidDirection.RIGHT);
    snake.move(ValidDirection.RIGHT);
    snake.move(ValidDirection.RIGHT);

    assertEquals(snake.getCoordinates().size(), 4);
  }

  @Test
  public void testRightWallEdge() {
    Snake snake = new Snake(3, 10);
    ArrayList<Coordinate> coordinates = new ArrayList<>();
    coordinates.add(new Coordinate(8, 1));
    coordinates.add(new Coordinate(9, 1));
    coordinates.add(new Coordinate(10, 1));
    snake.setCoordinates(coordinates);
    snake.move(ValidDirection.RIGHT);

    assertEquals(snake.getCoordinates().get(snake.getCoordinates().size() - 1), new Coordinate(1, 1));
  }

  @Test
  public void testLeftWallEdge() {
    Snake snake = new Snake(3, 10);
    ArrayList<Coordinate> coordinates = new ArrayList<>();
    coordinates.add(new Coordinate(3, 1));
    coordinates.add(new Coordinate(2, 1));
    coordinates.add(new Coordinate(1, 1));
    snake.setCoordinates(coordinates);
    snake.setLastDirection(ValidDirection.LEFT);
    snake.move(ValidDirection.LEFT);

    assertEquals(snake.getCoordinates().get(snake.getCoordinates().size() - 1), new Coordinate(10, 1));
  }

  @Test
  public void testTopWallEdge() {
    Snake snake = new Snake(3, 10);
    ArrayList<Coordinate> coordinates = new ArrayList<>();
    coordinates.add(new Coordinate(4, 3));
    coordinates.add(new Coordinate(4, 2));
    coordinates.add(new Coordinate(4, 1));
    snake.setCoordinates(coordinates);
    snake.setLastDirection(ValidDirection.TOP);
    snake.move(ValidDirection.TOP);

    assertEquals(snake.getCoordinates().get(snake.getCoordinates().size() - 1), new Coordinate(4, 10));
  }

  @Test
  public void testBottomWallEdge() {
    Snake snake = new Snake(3, 10);
    ArrayList<Coordinate> coordinates = new ArrayList<>();
    coordinates.add(new Coordinate(4, 8));
    coordinates.add(new Coordinate(4, 9));
    coordinates.add(new Coordinate(4, 10));
    snake.setCoordinates(coordinates);
    snake.setLastDirection(ValidDirection.BOTTOM);
    snake.move(ValidDirection.BOTTOM);

    assertEquals(snake.getCoordinates().get(snake.getCoordinates().size() - 1), new Coordinate(4, 1));
  }

  @Test(expected = HitTrailError.class)
  public void hittingTailSimpleWay() {
    Snake snake = new Snake(3, 10);
    for (int i = 0; i < 20; i++)
      snake.move(ValidDirection.RIGHT);
    snake.move(ValidDirection.RIGHT);
  }

  @Test(expected = HitTrailError.class)
  public void hittingTailComplexWay() {
    Snake snake = new Snake(3, 10);
    for (int i = 0; i < 15; i++)
      snake.move(ValidDirection.RIGHT);
    snake.move(ValidDirection.BOTTOM);
    snake.move(ValidDirection.LEFT);
    snake.move(ValidDirection.TOP);
  }
}
