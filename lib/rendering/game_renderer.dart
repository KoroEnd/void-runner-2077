import 'package:flutter/material.dart';
import '../game/game_engine.dart';
import 'sprite_painter.dart';

class GameRenderer extends CustomPainter {
  final GameEngine engine;
  final double time;

  GameRenderer({required this.engine, required this.time});

  @override
  void paint(Canvas canvas, Size size) {
    if (engine.map.grid.isEmpty) return;
    for (int y = 0; y < engine.map.rows; y++) {
      for (int x = 0; x < engine.map.cols; x++) {
        if (engine.map.grid[y][x] == 1) {
          SpritePainter.drawWall(
              canvas, Rect.fromLTWH(x * 40.0, y * 40.0, 40.0, 40.0));
        } else if (engine.map.grid[y][x] == 4) {
          SpritePainter.drawExit(
              canvas, Rect.fromLTWH(x * 40.0, y * 40.0, 40.0, 40.0), time);
        }
      }
    }


    for (var enemy in engine.enemies) {
      SpritePainter.drawEnemy(canvas, enemy.position, enemy.angle, enemy.alive);
    }

    for (var bullet in engine.bullets) {
      SpritePainter.drawBullet(
          canvas, bullet.position, bullet.velocity.direction);
    }

    SpritePainter.drawPlayer(
        canvas, engine.player.position, engine.player.angle, time);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
