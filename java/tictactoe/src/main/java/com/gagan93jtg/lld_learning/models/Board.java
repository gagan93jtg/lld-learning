package com.gagan93jtg.lld_learning.models;

import com.gagan93jtg.lld_learning.errors.BoardCellOccupiedError;
import com.gagan93jtg.lld_learning.errors.InvalidCoordinatesError;

import java.util.Arrays;

public class Board {
  int size;
  String[][] cells;

  int numberOfMoves;

  public Board(int size) {
    this.size = size;
    cells = new String[size][size];
    this.numberOfMoves = 0;
  }

  public void place(String symbol, int x, int y) throws InvalidCoordinatesError, BoardCellOccupiedError {
    if (x >= size || y >= size) {
      throw new InvalidCoordinatesError("X and Y should be within bounds of board size: " + size);
    }

    if (cells[x][y] != null) {
      throw new BoardCellOccupiedError("Board cell at [" + x + "," + y + "] is already occupied");
    }

    cells[x][y] = symbol;
    this.numberOfMoves++;
  }

  public void print() {
    String line = "";
    for (int i = 0; i < size * size; i++) {
      line += "-";
    }
    System.out.println(line);
    for (int i = 0; i < size; i++) {
      String rowLine = "";
      for (int j = 0; j < size; j++) {
        rowLine += (cells[i][j] + " ");
      }
      System.out.print(rowLine);
    }
    System.out.println(line);
  }

  public boolean hasWinner() {
    // no point checking winner case if atleast half board is empty
    if (((size * 2) - 1) > numberOfMoves) {
      return false;
    }

    return hasHorizontalWinner() || hasVerticalWinner() || hasDiagonalWinner();
  }

  public boolean hasDraw() {
    return size * size == numberOfMoves;
  }

  private boolean hasHorizontalWinner() {
    for (int i = 0; i < size; i++) {
      if (Arrays.stream(cells[i]).allMatch(el -> el != null && el.equals("O")) || Arrays.stream(cells[i]).allMatch(el -> el != null &&  el.equals("X")))
        return true;
    }

    return false;
  }

  private boolean hasVerticalWinner() {
    for (int col = 0; col < size; col++) {
      boolean allOs = true;
      boolean allXs = true;
      for (int row = 0; row < size; row++) {
        if (cells[row][col] != "O") {
          allOs = false;
        }
        if (cells[row][col] != "X") {
          allXs = false;
        }
      }
      if (allOs || allXs) {
        return true;
      }
    }
    return false;
  }

  private boolean hasDiagonalWinner() {
    return hasStraightDiagonalWinner() || hasOppositeDiagonalWinner();
  }

  private boolean hasStraightDiagonalWinner() {
    String firstElement = cells[0][0];
    for (int i = 0; i < size; i++) {
      if (cells[i][i] != firstElement)
        return false;
    }
    return true;
  }

  private boolean hasOppositeDiagonalWinner() {
    String firstElement = cells[0][size - 1];
    for (int i = size - 1; i > 0; i--) {
      if (cells[i][size - i - 1] != firstElement)
        return false;
    }

    return true;
  }
}
