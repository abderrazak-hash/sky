import 'package:flutter/material.dart';
import 'package:sky/main.dart';
import 'package:sky/zeref/zeref.dart';

enum Direction {
  left,
  right,
  up,
  down,
}

class DirectionZeref extends Zeref<Direction> {
  DirectionZeref() : super(Direction.down);

  void changeDirection(Direction direction) {
    emit(direction);
  }

  void changeDirectionLeft() {
    emit(Direction.left);
  }

  void changeDirectionRight() {
    emit(Direction.right);
  }

  void changeDirectionUp() {
    emit(Direction.up);
  }

  void changeDirectionDown() {
    emit(Direction.down);
  }
}

int getDeriction(Direction direction) {
  switch (direction) {
    case Direction.left:
      return 0;
    case Direction.right:
      return 0;
    case Direction.up:
      return 0;
    case Direction.down:
      return 0;
  }
}

Offset getOffset(
    Direction direction, Animation<double> animation, double dx, double dy,
    {double scale = 2000}) {
  switch (direction) {
    case Direction.left:
      return Offset(scale * animation.value, 0);
    case Direction.right:
      return Offset(scale * animation.value, 0);
    case Direction.up:
      return Offset(0, scale * animation.value);
    case Direction.down:
      return Offset(0, scale * animation.value);
  }
}

double getDxDirection(Direction direction, double dx) {
  switch (direction) {
    case Direction.left:
      return dx;
    case Direction.right:
      return dx;
    case Direction.up:
      return dx;
    case Direction.down:
      return dx;
  }
}

double getDyDirection(Direction direction, double dy) {
  switch (direction) {
    case Direction.left:
      return dy;
    case Direction.right:
      return dy;
    case Direction.up:
      return dy;
    case Direction.down:
      return dy;
  }
}
