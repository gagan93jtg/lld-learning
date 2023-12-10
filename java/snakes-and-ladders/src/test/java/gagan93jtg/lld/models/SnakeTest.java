package gagan93jtg.lld.models;

import org.junit.Test;
import static org.junit.Assert.assertEquals;

public class SnakeTest {
  @Test(expected =  IllegalArgumentException.class)
  public void testInvalidSnake() {
    new Snake(10, 30);
  }

  public void testValidSnake() {
    Snake snake = new Snake(30, 10);
    assertEquals(snake.getEnd(), 10);
    assertEquals(snake.getStart(), 30);
  }
}
