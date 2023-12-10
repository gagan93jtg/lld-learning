package gagan93jtg.lld;

import gagan93jtg.lld.models.Ladder;
import gagan93jtg.lld.models.Player;
import gagan93jtg.lld.models.Snake;
import gagan93jtg.lld.services.GameService;

import java.util.ArrayList;

public class Application {
  public static void main(String... args) {
    GameService service = new GameService(getPlayers(), getSnakes(), getLadders(), 10, 6);
    service.run();
  }

  private static ArrayList<Player> getPlayers() {
    ArrayList<Player> players = new ArrayList<>();
    players.add(new Player("Gagan", Player.Colors.BLUE));
    players.add(new Player("Sonia", Player.Colors.RED));

    return players;
  }

  private static ArrayList<Snake> getSnakes() {
    ArrayList<Snake> snakes = new ArrayList<>();
    snakes.add(new Snake(36, 6));
    snakes.add(new Snake(32, 10));
    snakes.add(new Snake(37, 5));
    snakes.add(new Snake(63, 18));
    snakes.add(new Snake(88, 24));
    snakes.add(new Snake(97, 56));

    return snakes;
  }

  private static ArrayList<Ladder> getLadders() {
    ArrayList<Ladder> ladders = new ArrayList<>();
    ladders.add(new Ladder(3, 38));
    ladders.add(new Ladder(4, 14));
    ladders.add(new Ladder(28, 74));
    ladders.add(new Ladder(71, 92));

    return ladders;
  }
}
