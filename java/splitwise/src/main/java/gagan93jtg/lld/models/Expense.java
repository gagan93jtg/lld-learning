package gagan93jtg.lld.models;

import java.math.BigDecimal;
import java.util.ArrayList;

public class Expense {
  BigDecimal amount;
  ArrayList<UserPaymentShare> userPaymentShares;

  public Expense(BigDecimal amount, ArrayList<UserPaymentShare> userPaymentShares) {
    this.amount = amount;
    this.userPaymentShares = userPaymentShares;

    validateAmountWithShare();
    normalizeShares();
  }

  public ArrayList<UserPaymentShare> getUserPaymentShares() {
    return userPaymentShares;
  }

  private void validateAmountWithShare() {
    BigDecimal sumOfShares = new BigDecimal(userPaymentShares.stream().mapToDouble(i -> i.amount.doubleValue()).sum());

    if(sumOfShares.doubleValue() != amount.doubleValue()) {
      throw new IllegalArgumentException("Sum of shares " + sumOfShares + " doesn't sum to total amount [" + amount  + "]");
    }
  }

  private void normalizeShares() {
    BigDecimal perUserShare = amount.divide(new BigDecimal(userPaymentShares.size())).setScale(2);

    for(UserPaymentShare ups: userPaymentShares) {
      ups.amount = ups.amount.subtract(perUserShare);
    }
  }
}
