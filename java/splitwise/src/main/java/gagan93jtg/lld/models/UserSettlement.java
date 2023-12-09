package gagan93jtg.lld.models;

public class UserSettlement {
  String payer; // Who pays
  String payee; // Who gets paid
  double amount;

  public UserSettlement(String payer, String payee, double amount) {
    this.payer = payer;
    this.payee = payee;
    this.amount = amount;
  }

  public String getPayer() {
    return payer;
  }

  public String getPayee() {
    return payee;
  }

  public double getAmount() {
    return amount;
  }

  @Override
  public String toString() {
    return payer + " pays " + payee + " Rs. " + amount ;
  }
}
