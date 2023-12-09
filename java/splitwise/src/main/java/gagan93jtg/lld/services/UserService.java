package gagan93jtg.lld.services;

import gagan93jtg.lld.models.Group;
import gagan93jtg.lld.models.User;

import java.util.ArrayList;

public class UserService {
  ArrayList<User> users;
  ArrayList<Group> groups;

  public UserService() {
    this.users = new ArrayList();
    this.groups = new ArrayList();
  }

  public void createUser(int id, String name) {
    users.add(new User(id, name));
  }

  public void createGroup(int id, String name, ArrayList<User> users) {
    groups.add(new Group(id, name, users));
  }

  public ArrayList<User> getUsers() {
    return users;
  }

  public ArrayList<Group> getGroups() {
    return groups;
  }
}
