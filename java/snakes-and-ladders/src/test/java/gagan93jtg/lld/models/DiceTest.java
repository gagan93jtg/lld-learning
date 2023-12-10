package gagan93jtg.lld.models;


import org.junit.Test;

public class DiceTest {

  Dice dice;

  public DiceTest() {
    this.dice = new Dice(10);
  }

  @Test
  public void testDiceRoll() {
    int value = dice.roll();
    assert (value < 10);
  }
}
