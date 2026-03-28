import 'package:flutter/material.dart';
import 'game_map.dart';

class CollisionHandler {
  static const double playerRadius = 12.0;

  static bool checkWallCollision(Offset pos, GameMap map) {
    List<Offset> checkPoints = [
      Offset(pos.dx + playerRadius, pos.dy),
      Offset(pos.dx - playerRadius, pos.dy),
      Offset(pos.dx, pos.dy + playerRadius),
      Offset(pos.dx, pos.dy - playerRadius),
    ];

    for (var point in checkPoints) {
      if (map.isWall(point.dx, point.dy)) {
        return true;
      }
    }
    return false;
  }

  static Offset getValidMovement(
      Offset currentPos, Offset desiredNextPos, GameMap map) {
    if (!checkWallCollision(desiredNextPos, map)) {
      return desiredNextPos;
    }

    Offset onlyX = Offset(desiredNextPos.dx, currentPos.dy);
    if (!checkWallCollision(onlyX, map)) {
      return onlyX;
    }

    Offset onlyY = Offset(currentPos.dx, desiredNextPos.dy);
    if (!checkWallCollision(onlyY, map)) {
      return onlyY;
    }

    return currentPos;
  }
}
