import 'dart:math';
import 'package:flutter/material.dart';

class Player {
  Offset position = const Offset(100, 100);
  double angle = 0;
  double health = 100;
  bool isMoving = false;
  double speed = 150.0;

  void update(double dt, var map) {
    if (isMoving) {
      double nextX = position.dx + cos(angle) * speed * dt;
      double nextY = position.dy + sin(angle) * speed * dt;

      if (!map.isWall(nextX, nextY)) {
        position = Offset(nextX, nextY);
      }
    }
  }
}
