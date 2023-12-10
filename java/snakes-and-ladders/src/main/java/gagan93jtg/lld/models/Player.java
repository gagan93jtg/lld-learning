package gagan93jtg.lld.models;

public class Player {
  private String name;
  private Colors color;
  private int currentCell;

  private boolean won;

  public Player(String name, Colors color) {
    this.name = name;
    this.color = color;
    this.currentCell = -1;
    this.won = false;
  }

  public String getName() {
    return name;
  }

  public Colors getColor() {
    return color;
  }

  public int getCurrentCell() {
    return currentCell;
  }

  public void setCurrentCell(int currentCell) {
    this.currentCell = currentCell;
  }

  public void setWon(boolean won) {
    this.won = won;
  }

  public boolean isWon() {
    return won;
  }

  public enum Colors {
    BLUE,
    RED,
    GREEN,
    YELLOW
  }
}
