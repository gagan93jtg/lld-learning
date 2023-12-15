package gagan93jtg.lld.models;

public class Coordinate {
  private int x, y;

  public Coordinate(int x, int y) {
    this.x = x;
    this.y = y;
  }

  public int getX() {
    return x;
  }

  public int getY() {
    return y;
  }

  public void setX(int x) {
    this.x = x;
  }

  public void setY(int y) {
    this.y = y;
  }

  @Override
  public boolean equals(Object obj) {
    Coordinate otherObject = (Coordinate) obj;
    return x == otherObject.x && y == otherObject.y;
  }

  @Override
  public String toString() {
    return this.x + ", " + this.y;
  }
}
