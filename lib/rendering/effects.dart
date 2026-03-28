import 'package:flutter/material.dart';

class Particle {
  Offset position;
  Offset velocity;
  double life;

  Particle({required this.position, required this.velocity, this.life = 1.0});
}

class GameEffects {
  static List<Particle> explosion(Offset pos, Color color) {
    return List.generate(
        8,
        (i) => Particle(
              position: pos,
              velocity: Offset.fromDirection(i * 0.8, 100),
            ));
  }
}
