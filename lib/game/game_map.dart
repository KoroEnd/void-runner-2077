import 'package:flutter/material.dart';
import 'levels.dart';

class GameMap {
  final int level;
  late List<List<int>> data;

  static const double tileSize = 40.0;

  GameMap(this.level) {
    data = GameLevels.getLevel(level);
  }

  int get rows => data.length;
  int get cols => data.isNotEmpty ? data[0].length : 0;
  List<List<int>> get grid => data;

  bool isWall(double dx, double dy) {
    int x = (dx / tileSize).floor();
    int y = (dy / tileSize).floor();

    if (y < 0 || y >= data.length || x < 0 || x >= data[y].length) {
      return true;
    }

    return data[y][x] == 1;
  }

  bool isExit(Offset pos) {
    int x = (pos.dx / tileSize).floor();
    int y = (pos.dy / tileSize).floor();

    if (y < 0 || y >= data.length || x < 0 || x >= data[y].length) {
      return false;
    }

    return data[y][x] == 4;
  }

  List<Offset> getEnemySpawns() {
    List<Offset> spawns = [];
    for (int y = 0; y < data.length; y++) {
      for (int x = 0; x < data[y].length; x++) {
        if (data[y][x] == 3) {
          spawns.add(
              Offset(x * tileSize + tileSize / 2, y * tileSize + tileSize / 2));
        }
      }
    }
    return spawns;
  }

  Offset getPlayerSpawn() {
    for (int y = 0; y < data.length; y++) {
      for (int x = 0; x < data[y].length; x++) {
        if (data[y][x] == 2) {
          return Offset(
              x * tileSize + tileSize / 2, y * tileSize + tileSize / 2);
        }
      }
    }

    return const Offset(tileSize * 1.5, tileSize * 1.5);
  }
}
