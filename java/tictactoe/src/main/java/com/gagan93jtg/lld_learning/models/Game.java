package com.gagan93jtg.lld_learning.models;

import com.gagan93jtg.lld_learning.errors.*;
import com.gagan93jtg.lld_learning.services.Runner;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

public class Game {
  public static final String[] VALID_SYMBOLS = {"O", "X"};
  List players = new ArrayList<Player>();
  Board board;
  Player lastTurn;
  String winner;
  boolean isDraw = false;

  public Game(int boardSize) {
    this.board = new Board((boardSize));
  }

  public void addPlayer(String name, String symbol) throws MoreThanTwoPlayersNotSupportedError, InvalidSymbolError, DuplicateSymbolError, PlayerInformationMissingError {
    checkIfMorethanTwoPlayers();
    checkIfSymbolInvalid(symbol);
    checkDuplicateSymbol(symbol);
    checkDuplicatePlayerName(name);

    Player player = new Player(name, symbol);
    if (players.isEmpty()) {
      lastTurn = player;
    }
    players.add(player);
  }

  public void play(int x, int y) throws InvalidCoordinatesError, BoardCellOccupiedError {
    board.place(lastTurn.symbol, x, y);
    if (Runner.printMatrix()) {
      board.print();
    }
    checkWinner();
    checkDraw();
    switchTurn();
  }

  public List<Player> getPlayers() {
    return players;
  }

  private void checkWinner() {
    if (board.hasWinner()) {
      this.winner = lastTurn.name;
      System.out.println("Winner: " + winner);
    }
  }

  private void checkDraw() {
    if (board.hasDraw()) {
      this.isDraw = true;
      System.out.println("Game Draw !");
    }
  }

  private void switchTurn() {
    this.lastTurn = (Player) (lastTurn == players.get(0) ? players.get(1) : players.get(0));
  }

  private void checkIfSymbolInvalid(String symbol) throws InvalidSymbolError {
    if (!Arrays.asList(VALID_SYMBOLS).contains(symbol)) {
      throw new InvalidSymbolError("The symbol: " + symbol + " is not valid.");
    }
  }

  private void checkDuplicateSymbol(String symbol) throws DuplicateSymbolError {
    if (players.isEmpty())
      return;

    Player firstPlayer = (Player)(players.get(0));
    if (firstPlayer.symbol == symbol) {
      throw new DuplicateSymbolError("Symbol already used by some other player");
    }
  }

  private void checkDuplicatePlayerName(String name) throws DuplicateSymbolError {
    if (players.isEmpty())
      return;

    Player firstPlayer = (Player)(players.get(0));
    if (firstPlayer.name == name) {
      throw new DuplicateSymbolError("Name already used by some other player");
    }
  }

  private void checkIfMorethanTwoPlayers() throws MoreThanTwoPlayersNotSupportedError {
    if (players.size() == 2) {
      throw new MoreThanTwoPlayersNotSupportedError("More than two players not supported");
    }
  }
}

