package com.gagan93jtg.lld_learning.models;

import com.gagan93jtg.lld_learning.errors.PlayerInformationMissingError;

public class Player {
  String name;
  String symbol;

  public Player(String name, String symbol) throws PlayerInformationMissingError {
    if (name.isEmpty() || symbol.isEmpty()) {
      throw new PlayerInformationMissingError("Both symbol and symbol should be present");
    }

    this.name = name;
    this.symbol = symbol;
  }
}
