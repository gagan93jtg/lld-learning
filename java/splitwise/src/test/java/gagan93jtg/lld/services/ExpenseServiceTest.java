package gagan93jtg.lld.services;


import gagan93jtg.lld.models.User;
import gagan93jtg.lld.models.UserPaymentShare;
import gagan93jtg.lld.models.UserSettlement;
import org.junit.Test;

import java.math.BigDecimal;
import java.util.ArrayList;

import static org.junit.Assert.assertEquals;

public class ExpenseServiceTest {
  UserService userService;
  ExpenseService expenseService;

  public ExpenseServiceTest() {
    this.userService = new UserService();
    this.expenseService = new ExpenseService();
  }

  @Test
  public void testSettlement() {
    setupData();
    ArrayList<UserSettlement> settlements = expenseService.settleExpenses();

    verify_harman_gets_from_gagan(settlements);
    verify_harman_gets_from_ishmeet(settlements);
    verify_harman_gets_from_sidak(settlements);
  }

  private void verify_harman_gets_from_gagan(ArrayList<UserSettlement> settlements) {
    UserSettlement gagan_settles = settlements.stream().filter(item -> item.getPayer() == "Gagan").findFirst().get();
    assertEquals(gagan_settles.getPayee(), "Harman");
    assertEquals(gagan_settles.getAmount(), 275, 0.1);
  }

  private void verify_harman_gets_from_ishmeet(ArrayList<UserSettlement> settlements) {
    UserSettlement gagan_settles = settlements.stream().filter(item -> item.getPayer() == "Ishmeet").findFirst().get();
    assertEquals(gagan_settles.getPayee(), "Harman");
    assertEquals(gagan_settles.getAmount(), 1675, 0.1);
  }

  private void verify_harman_gets_from_sidak(ArrayList<UserSettlement> settlements) {
UserSettlement gagan_settles = settlements.stream().filter(item -> item.getPayer() == "Sidak").findFirst().get();
    assertEquals(gagan_settles.getPayee(), "Harman");
    assertEquals(gagan_settles.getAmount(), 1575, 0.1);
  }


  private void setupData() {
    User gagan = new User(1, "Gagan");
    User harman = new User(2, "Harman");
    User ishmeet = new User(3, "Ishmeet");
    User sidak = new User(4, "Sidak");

    ArrayList<UserPaymentShare> ups = new ArrayList<>();
    ups.add(new UserPaymentShare(1500, gagan));
    ups.add(new UserPaymentShare(500, harman));
    ups.add(new UserPaymentShare(200, ishmeet));
    ups.add(new UserPaymentShare(300, sidak));
    expenseService.addExpense(new BigDecimal(2500), ups);

    ups = new ArrayList<>();
    ups.add(new UserPaymentShare(100, gagan));
    ups.add(new UserPaymentShare(4900, harman));
    ups.add(new UserPaymentShare(0, ishmeet));
    ups.add(new UserPaymentShare(0, sidak));
    expenseService.addExpense(new BigDecimal(5000), ups);
  }
}
