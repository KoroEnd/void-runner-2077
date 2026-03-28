import 'package:flutter/material.dart';
import 'enemy.dart';

enum CyberEnemyType { drone, hacker, boss }

class Drone extends Enemy {
  Drone(Offset position)
      : super(position: position, type: "drone", health: 50, speed: 100.0);
}

class Hacker extends Enemy {
  Hacker(Offset position)
      : super(position: position, type: "hacker", health: 150, speed: 50.0);
}

class MecaBoss extends Enemy {
  MecaBoss(Offset position)
      : super(position: position, type: "boss", health: 600, speed: 30.0);
}
