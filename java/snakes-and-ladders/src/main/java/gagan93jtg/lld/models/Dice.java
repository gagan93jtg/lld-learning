package gagan93jtg.lld.models;

public class Dice {
  private int range;

  public Dice(int range) {
    this.range = range;
  }

  public int roll() {
    return (int) ((Math.random() * 10000) % range);
  }
}
