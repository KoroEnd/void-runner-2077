import 'package:flutter/material.dart';
import 'game_map.dart';

class Enemy {
  Offset position;
  double health;
  bool alive = true;
  double angle = 0.0;

  final String type;
  final double speed;

  Enemy({
    required this.position,
    required this.type,
    required this.health,
    required this.speed,
  });

  void update(double dt, Offset playerPos, GameMap map) {
    if (!alive) return;

    Offset direction = playerPos - position;
    double distance = direction.distance;

    if (distance < 300 && distance > 10) {
      angle = direction.direction;
      Offset velocity = Offset.fromDirection(angle) * speed * dt;
      Offset nextPos = position + velocity;

      if (!map.isWall(nextPos.dx, nextPos.dy)) {
        position = nextPos;
      }
    }
  }

  void takeDamage(double amount) {
    health -= amount;
    if (health <= 0) alive = false;
  }
}
