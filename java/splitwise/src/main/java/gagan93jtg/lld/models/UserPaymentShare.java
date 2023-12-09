package gagan93jtg.lld.models;

import java.math.BigDecimal;

public class UserPaymentShare {
  BigDecimal amount;
  User user;

  public UserPaymentShare(float amount, User user) {
    this.amount = new BigDecimal(amount);
    this.user = user;
  }

  public User getUser() {
    return user;
  }

  public BigDecimal getAmount() {
    return amount;
  }
}
