import 'package:flutter/material.dart';

enum PickupType { health, ammo }

class Pickup {
  Offset position;
  PickupType type;
  bool collected = false;

  Pickup({required this.position, required this.type});
}
