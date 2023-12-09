package gagan93jtg.lld.services;

import gagan93jtg.lld.models.*;

import java.math.BigDecimal;
import java.util.*;

public class ExpenseService {
  ArrayList<Expense> expenses;

  public ExpenseService() {
    this.expenses = new ArrayList<>();
  }

  public void addExpense(BigDecimal amount, ArrayList<UserPaymentShare> shares) {
    expenses.add(new Expense(amount, shares));
  }

  public ArrayList<UserBalance> computeBalance() {
    HashMap<User, BigDecimal> userBalanceMap = new HashMap<>();
    ArrayList<UserBalance> userBalances = new ArrayList<>();

    for (Expense expense : expenses) {
      for (UserPaymentShare share : expense.getUserPaymentShares()) {
        userBalanceMap.putIfAbsent(share.getUser(), new BigDecimal(0));
        userBalanceMap.put(share.getUser(), userBalanceMap.get(share.getUser()).add(share.getAmount()));
      }
    }

    for (Map.Entry<User, BigDecimal> entry : userBalanceMap.entrySet()) {
      userBalances.add(new UserBalance(entry.getKey().getName(), entry.getValue()));
    }

    return userBalances;
  }

  public ArrayList<UserSettlement> settleExpenses() {
    ArrayList<UserBalance> userBalances = computeBalance();
    PriorityQueue<UserBalance> positivePayments = new PriorityQueue<>(Comparator.comparingDouble(UserBalance::getBalanceAsDouble));
    PriorityQueue<UserBalance> negativePayments = new PriorityQueue<>(Comparator.comparingDouble(UserBalance::getBalanceAsDouble));
    ArrayList<UserSettlement> settlements = new ArrayList<>();

    for (UserBalance userBalance : userBalances) {
      if (userBalance.getBalance().doubleValue() > 0) {
        positivePayments.add(userBalance);
      } else {
        negativePayments.add(userBalance);
      }
    }

    while (true) {
      UserBalance positivePayment = positivePayments.poll();
      UserBalance negativePayment = negativePayments.poll();

      if (positivePayment == null || negativePayment == null) {
        break;
      }

      double amountToTransfer = Math.min(positivePayment.getBalance().doubleValue(), -negativePayment.getBalance().doubleValue());
      double remainingAmount = positivePayment.getBalance().doubleValue() - Math.abs(negativePayment.getBalance().doubleValue());
      settlements.add(new UserSettlement(negativePayment.getName(), positivePayment.getName(), amountToTransfer));
      if (remainingAmount > 0) {
        positivePayments.add(new UserBalance(positivePayment.getName(), new BigDecimal(remainingAmount)));
      } else {
        negativePayments.add(new UserBalance(negativePayment.getName(), new BigDecimal(remainingAmount)));
      }
    }

    return settlements;
  }
}
