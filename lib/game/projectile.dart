import 'package:flutter/material.dart';
import '../utils/constants.dart';

class Projectile {
  Offset position;
  double angle;
  bool active = true;

  Projectile({required this.position, required this.angle});

  void update(double dt) {
    position += Offset.fromDirection(angle) * GameConstants.bulletSpeed * dt;
  }
}
