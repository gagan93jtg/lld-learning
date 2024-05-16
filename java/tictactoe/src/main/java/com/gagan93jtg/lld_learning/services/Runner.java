package com.gagan93jtg.lld_learning.services;

import com.gagan93jtg.lld_learning.errors.*;
import com.gagan93jtg.lld_learning.models.Game;

public class Runner {

  Game game;

  public Runner() {
    this.game = new Game(3);
  }

  public void addPlayers() throws PlayerInformationMissingError, InvalidSymbolError, MoreThanTwoPlayersNotSupportedError, DuplicateSymbolError {
    game.addPlayer("Gagan1", "O");
    game.addPlayer("Gagan2", "X");
  }

  public void play() throws InsufficientPlayersError, InvalidCoordinatesError, BoardCellOccupiedError {
    if (game.getPlayers().size() < 2) {
      throw new InsufficientPlayersError("Atleast two players must be present to play the game");
    }

    game.play(1, 1); // Gagan1 places 0 on the center
    game.play(0, 2); // Gagan2 places X on the top right
    game.play(2, 0); // Gagan1 places 0 on bottom left
    game.play(2, 2); // Gagan2 places X on bottom right
    game.play(0, 0); // Gagan1 places 0 on top left
    game.play(0, 1); // Gagan2 places X on top center
    game.play(1, 0); // Gagan1 places 0 on left middle and wins
  }

  public static boolean printMatrix() {
    return true;
  }

  public static void main (String...args) throws InsufficientPlayersError, InvalidCoordinatesError, BoardCellOccupiedError, PlayerInformationMissingError, InvalidSymbolError, MoreThanTwoPlayersNotSupportedError, DuplicateSymbolError {
    Runner runner = new Runner();
    runner.addPlayers();
    runner.play();
  }
}
