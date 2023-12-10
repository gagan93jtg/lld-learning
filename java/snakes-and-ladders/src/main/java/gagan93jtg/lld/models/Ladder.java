package gagan93jtg.lld.models;

public class Ladder {
  private int start;
  private int end;

  public Ladder(int start, int end) {
    this.start = start;
    this.end = end;

    validateLadder();
  }

  public int getStart() {
    return start;
  }

  public int getEnd() {
    return end;
  }

  private void validateLadder() {
    if (start > end) {
      throw new IllegalArgumentException("A ladder should start at a smaller value and end at higher value");
    }
  }
}