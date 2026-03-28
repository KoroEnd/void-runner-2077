import 'package:flutter/material.dart';

class Bullet {
  Offset position;
  final Offset velocity;
  final double damage;

  Bullet({
    required this.position,
    required this.velocity,
    required this.damage,
  });

  void update(double dt) {
    position += velocity * dt;
  }
}
