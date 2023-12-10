package gagan93jtg.lld.models;

public class Snake {
  private int start;
  private int end;

  public Snake(int start, int end) {
    this.start = start;
    this.end = end;

    validateSnake();
  }

  public int getStart() {
    return start;
  }

  public int getEnd() {
    return end;
  }

  private void validateSnake() {
    if (end > start) {
      throw new IllegalArgumentException("A snake should end at a lower position than start position");
    }
  }
}
