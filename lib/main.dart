import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/scheduler.dart';
import 'game/game_engine.dart';
import 'rendering/game_renderer.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
  ]);
  runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: const CyberGame()));
}

class CyberGame extends StatefulWidget {
  const CyberGame({super.key});

  @override
  State<CyberGame> createState() => _CyberGameState();
}

class _CyberGameState extends State<CyberGame>
    with SingleTickerProviderStateMixin {
  late GameEngine engine;
  late Ticker _ticker;
  double _time = 0;

  Offset _joyStickPos = Offset.zero;

  @override
  void initState() {
    super.initState();
    engine = GameEngine();
    _ticker = createTicker((elapsed) {
      double t = elapsed.inMilliseconds / 1000.0;
      double dt = (t - _time).clamp(0, 0.033);
      _time = t;

      if (engine.state == GameState.playing) {
        setState(() => engine.update(dt));
      } else {
        setState(() {});
      }
    });
    _ticker.start();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          CustomPaint(
            size: Size.infinite,
            painter: GameRenderer(engine: engine, time: _time),
          ),
          if (engine.state == GameState.playing) ...[
            _buildCyberHUD(),
            _buildControls(),
          ],
          if (engine.state != GameState.playing) _buildInteractiveMenu(),
        ],
      ),
    );
  }

  Widget _buildCyberHUD() {
    String weaponName = engine.weaponIndex == 2
        ? "SMART PLASMA"
        : (engine.weaponIndex == 1 ? "TECH SOVEREIGN" : "POWER LEXINGTON");
    Color weaponColor = engine.weaponIndex == 2
        ? Colors.cyanAccent
        : (engine.weaponIndex == 1 ? Colors.pinkAccent : Colors.yellowAccent);

    return Positioned(
      top: 30,
      left: 30,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Text("VITAL: ",
                  style: TextStyle(
                      color: Colors.white70,
                      fontWeight: FontWeight.bold,
                      fontSize: 12)),
              Container(
                width: 200,
                height: 15,
                decoration: BoxDecoration(
                    border: Border.all(
                        color: Colors.greenAccent.withValues(alpha: 0.5))),
                child: Stack(
                  children: [
                    Container(color: Colors.greenAccent.withValues(alpha: 0.1)),
                    FractionallySizedBox(
                      widthFactor: (engine.player.health / 100).clamp(0, 1),
                      child: Container(color: Colors.greenAccent),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 10),
              Text("${engine.player.health.toInt()}%",
                  style: const TextStyle(
                      color: Colors.greenAccent, fontWeight: FontWeight.bold)),
            ],
          ),
          const SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
                color: weaponColor.withValues(alpha: 0.2),
                border: Border(left: BorderSide(color: weaponColor, width: 4))),
            child: Text(weaponName,
                style: TextStyle(
                    color: weaponColor,
                    letterSpacing: 2,
                    fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }

  Widget _buildControls() {
    return Stack(
      children: [
        Positioned(
          bottom: 30,
          left: 40,
          child: GestureDetector(
            onPanUpdate: (details) {
              setState(() {
                _joyStickPos = details.localPosition - const Offset(60, 60);
                if (_joyStickPos.distance > 10) {
                  engine.player.angle = _joyStickPos.direction;
                  engine.player.isMoving = true;
                }
              });
            },
            onPanEnd: (_) => setState(() {
              _joyStickPos = Offset.zero;
              engine.player.isMoving = false;
            }),
            child: Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                      color: Colors.cyanAccent.withValues(alpha: 0.5),
                      width: 2)),
              child: Center(
                child: Transform.translate(
                  offset: Offset.fromDirection(
                      _joyStickPos.direction, min(_joyStickPos.distance, 40)),
                  child: Container(
                      width: 45,
                      height: 45,
                      decoration: const BoxDecoration(
                          color: Colors.cyanAccent,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(color: Colors.cyanAccent, blurRadius: 10)
                          ])),
                ),
              ),
            ),
          ),
        ),
        Positioned(
          bottom: 40,
          right: 40,
          child: Row(
            children: [
              GestureDetector(
                onTap: () => setState(
                    () => engine.weaponIndex = (engine.weaponIndex + 1) % 3),
                child: const CircleAvatar(
                    backgroundColor: Colors.white10,
                    radius: 30,
                    child: Icon(Icons.sync, color: Colors.pinkAccent)),
              ),
              const SizedBox(width: 25),
              GestureDetector(
                onTap: () => engine.shoot(),
                child: Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                      color: Colors.redAccent.withValues(alpha: 0.3),
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.redAccent, width: 4)),
                  child: const Icon(Icons.gps_fixed,
                      color: Colors.white, size: 50),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildInteractiveMenu() {
    return Container(
      width: double.infinity,
      color: Colors.black.withValues(alpha: 0.9),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text("VOID RUNNER",
              style: TextStyle(
                  color: Colors.cyanAccent,
                  fontSize: 60,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 10,
                  shadows: [
                    Shadow(color: Colors.pinkAccent, offset: Offset(3, 3))
                  ])),
          const Text("NIGHT CITY CHRONICLES",
              style: TextStyle(
                  color: Colors.pinkAccent, fontSize: 14, letterSpacing: 5)),
          const SizedBox(height: 60),
          GestureDetector(
            onTap: () => setState(() => engine.startNewGame()),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.cyanAccent, width: 2),
                  color: Colors.cyanAccent.withValues(alpha: 0.1)),
              child: const Text("INICIAR ENLACE NEURAL",
                  style: TextStyle(
                      color: Colors.cyanAccent,
                      fontSize: 18,
                      fontWeight: FontWeight.bold)),
            ),
          ),
          if (engine.state == GameState.gameOver) ...[
            const SizedBox(height: 20),
            const Text("CONEXIÓN PERDIDA: CYBERPSICOSIS DETECTADA",
                style: TextStyle(color: Colors.redAccent)),
          ]
        ],
      ),
    );
  }

  @override
  void dispose() {
    _ticker.dispose();
    super.dispose();
  }
}
