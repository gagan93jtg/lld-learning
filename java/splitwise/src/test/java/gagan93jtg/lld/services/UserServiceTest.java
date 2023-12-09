package gagan93jtg.lld.services;

import org.junit.Test;
import static org.junit.Assert.assertEquals;

public class UserServiceTest {
  @Test
  public void testUserAddition() {
    UserService service = new UserService();
    service.createUser(1, "Gagan");
    assertEquals(service.getUsers().get(0).getName(), "Gagan");
    assertEquals(service.getUsers().size(), 1);
  }
}
