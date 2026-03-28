import 'dart:math';
import 'dart:ui';
import 'player.dart';
import 'enemy.dart';
import 'bullet.dart';
import 'game_map.dart';

enum GameState { menu, playing, gameOver, victory }

class GameEngine {
  late Player player;
  List<Enemy> enemies = [];
  List<Bullet> bullets = [];
  late GameMap map;
  int currentLevel = 1;
  GameState state = GameState.menu;
  int weaponIndex = 0; //
  double _shotCooldown = 0;
  double glitchTimer = 0;

  GameEngine() {
    player = Player();
    map = GameMap(currentLevel);
  }

  void startNewGame() {
    currentLevel = 1;
    weaponIndex = 0;
    state = GameState.playing;
    loadLevel(currentLevel);
  }

  void loadLevel(int level) {
    map = GameMap(level);
    player.position = map.getPlayerSpawn();
    player.health = 100;
    enemies.clear();
    bullets.clear();

    var spawns = map.getEnemySpawns();
    for (int i = 0; i < spawns.length; i++) {
      String type = (i % 3 == 0) ? "hacker" : "drone";
      if (i == spawns.length - 1 && level == 3) type = "boss";
      enemies.add(Enemy(
        position: spawns[i],
        type: type,
        health: type == "boss" ? 500 : (type == "hacker" ? 150 : 100),
        speed: type == "boss" ? 80 : (type == "hacker" ? 120 : 100),
      ));
    }
  }

  void shoot() {
    if (state != GameState.playing || _shotCooldown > 0) return;
    double speed = 400.0;
    double damage = (weaponIndex == 1) ? 50 : 20;
    Offset velocity = Offset.fromDirection(player.angle, speed);
    bullets.add(Bullet(position: player.position, velocity: velocity, damage: damage));
  }

  void update(double dt) {
    if (state != GameState.playing) return;
    if (_shotCooldown > 0) _shotCooldown -= dt;
    if (glitchTimer > 0) glitchTimer -= dt;

    player.update(dt, map);

    // Balas
    for (int i = bullets.length - 1; i >= 0; i--) {
      bullets[i].update(dt);
      if (map.isWall(bullets[i].position.dx, bullets[i].position.dy)) {
        bullets.removeAt(i);
        continue;
      }
      for (var e in enemies) {
        if ((bullets[i].position - e.position).distance < 20) {
          e.health -= (weaponIndex == 1) ? 50 : 20;
          bullets.removeAt(i);
          if (e.health <= 0) enemies.remove(e);
          break;
        }
      }
    }

    for (var e in enemies) {
      e.update(dt, player.position, map);
      if ((e.position - player.position).distance < 20) {
        player.health -= 0.5;
        if (glitchTimer <= 0) glitchTimer = 0.3;
      }
    }

    if (map.isExit(player.position)) {
      if (currentLevel < 3) {
        currentLevel++;
        loadLevel(currentLevel);
      } else {
        state = GameState.victory;
      }
    }
    if (player.health <= 0) state = GameState.gameOver;
  }
}
