package gagan93jtg.lld.models;

import gagan93jtg.lld.errors.HitTrailError;
import gagan93jtg.lld.errors.InvalidDirectionError;

import java.util.ArrayList;
import java.util.EnumSet;

enum ValidDirection {LEFT, RIGHT, BOTTOM, TOP};

public class Snake {
  public static final int GROWTH_STEP = 3;

  private int currentStep, boardSize;
  private ValidDirection lastDirection;
  private ArrayList<Coordinate> coordinates;

  public Snake(int initialSize, int boardSize) {
    this.coordinates = new ArrayList<>();
    this.currentStep = 1;
    this.boardSize = boardSize;
    this.lastDirection = ValidDirection.RIGHT;
    growInitial(initialSize);
  }

  ArrayList<Coordinate> getCoordinates() {
    return coordinates;
  }

  void setCoordinates(ArrayList<Coordinate> coordinates) {
    this.coordinates = coordinates;
  }

  void setLastDirection(ValidDirection lastDirection) {
    this.lastDirection = lastDirection;
  }

  public void move(ValidDirection direction) {
    if (moveIsInvalid(direction)) {
      return;
    }

    int newX, newY, growthX, growthY;
    newX = coordinates.get(coordinates.size() - 1).getX();
    newY = coordinates.get(coordinates.size() - 1).getY();
    growthX = newX;
    growthY = newY;

    if (direction == ValidDirection.LEFT) {
      newX -= 1;
      growthX -= 2;
    } else if (direction == ValidDirection.RIGHT) {
      newX += 1;
      growthX += 2;
    } else if (direction == ValidDirection.TOP) {
      newY -= 1;
      growthY -= 2;
    } else if (direction == ValidDirection.BOTTOM) {
      newY += 1;
      growthY += 2;
    }

    Coordinate coordinate = normalize(new Coordinate(newX, newY));
    checkCollission(coordinate);
    coordinates.add(coordinate);
    growSnake(growthX, growthY);
    coordinates.remove(0);
    this.currentStep += 1;
    this.lastDirection = direction;

    System.out.println("Step: " + currentStep + ", Coordinates: " + coordinates);
  }

  private void growSnake(int x, int y) {
    if (shouldNotGrowSnake()) {
      return;
    }

    System.out.println("Growing...");
    Coordinate coordinate = normalize(new Coordinate(x, y));
    checkCollission(coordinate);
    coordinates.add(coordinate);
    this.currentStep = 0;
  }

  private boolean shouldNotGrowSnake() {
    return currentStep != GROWTH_STEP;
  }

  private Coordinate normalize(Coordinate coordinate) {
    if (coordinate.getX() > boardSize)
      coordinate.setX(coordinate.getX() % boardSize);
    else if (coordinate.getX() <= 0)
      coordinate.setX(boardSize - coordinate.getX());

    if (coordinate.getY() > boardSize)
      coordinate.setY(coordinate.getY() % boardSize);
    else if (coordinate.getY() <= 0)
      coordinate.setY(boardSize - coordinate.getY());

    return coordinate;
  }

  private void checkCollission(Coordinate coordinate) {
    if (coordinates.contains(coordinate))
      throw new HitTrailError("Game over");
  }

  private boolean moveIsInvalid(ValidDirection direction) {
    return (direction == ValidDirection.LEFT && lastDirection == ValidDirection.RIGHT) ||
            (direction == ValidDirection.RIGHT && lastDirection == ValidDirection.LEFT) ||
            (direction == ValidDirection.TOP && lastDirection == ValidDirection.BOTTOM) ||
            (direction == ValidDirection.BOTTOM && lastDirection == ValidDirection.TOP);
  }

  private void growInitial(int initialSize) {
    for (int i = 0; i < initialSize; i++) {
      this.coordinates.add(new Coordinate(i + 1, 1));
    }
  }
}
