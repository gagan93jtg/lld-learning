package gagan93jtg.lld.models;

import java.util.ArrayList;

public class Group {
  int id;
  String name;
  ArrayList<User> users;

  public Group(int id, String name, ArrayList<User> users) {
    this.id = id;
    this.name = name;
    this.users = users;
  }
}
