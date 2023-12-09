package gagan93jtg.lld.models;

import java.math.BigDecimal;

public class UserBalance {
  String name;
  BigDecimal balance;

  public UserBalance(String name, BigDecimal balance) {
    this.name = name;
    this.balance = balance;
  }

  public String getName() {
    return name;
  }

  public BigDecimal getBalance() {
    return balance;
  }

  public double getBalanceAsDouble() {
    return balance.doubleValue();
  }
}
