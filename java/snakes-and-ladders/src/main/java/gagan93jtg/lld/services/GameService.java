package gagan93jtg.lld.services;

import gagan93jtg.lld.models.*;

import java.util.ArrayList;

public class GameService {
  private Board board;
  private Dice dice;
  private ArrayList<Player> players;
  private ArrayList<Snake> snakes;
  private ArrayList<Ladder> ladders;

  public GameService(ArrayList<Player> players, ArrayList<Snake> snakes, ArrayList<Ladder> ladders, int boardSize, int diceRange) {
    this.players = players;
    this.snakes = snakes;
    this.ladders = ladders;
    this.board = new Board(boardSize, snakes, ladders);
    this.dice = new Dice(diceRange);
  }

  public Board getBoard() {
    return board;
  }

  public void run() {
    while (true) {
      Player player = players.remove(0);
      takeTurn(player, dice.roll());

      if (player.getCurrentCell() == board.getLastCell()) {
        player.setWon(true);
        System.out.println("Player " + player.getName() + " is winner");
        break;
      } else {
        players.add(player);
      }
    }
  }

  public void takeTurn(Player player, int diceValue) {
    if (player.getCurrentCell() == -1) {
      if (diceValue == 1) {
        player.setCurrentCell(1);
      }
    } else if (player.getCurrentCell() + diceValue > board.getLastCell()) {
      System.out.println("Player current position " + player.getCurrentCell() + " plus dice value " + diceValue + " shall cross the board limit. Hence nullifying");
    } else {
      player.setCurrentCell(player.getCurrentCell() + diceValue);
      if (board.getSnakePoints().containsKey(player.getCurrentCell())) {
        int destination = board.getSnakePoints().get(player.getCurrentCell());
        System.out.println("[" + player.getName() + "] cut by snake. Now goes from " + player.getCurrentCell() + " to " + destination);
        player.setCurrentCell(destination);
      } else if (board.getLadderPoints().containsKey(player.getCurrentCell())) {
        int destination = board.getLadderPoints().get(player.getCurrentCell());
        System.out.println("[" + player.getName() + "] promoted by ladder. Now goes from " + player.getCurrentCell() + " to " + destination);
        player.setCurrentCell(destination);
      } else {
        System.out.println("[" + player.getName() + "] Current position " + player.getCurrentCell() + " after dice value : " + diceValue);
      }
    }
  }
}
