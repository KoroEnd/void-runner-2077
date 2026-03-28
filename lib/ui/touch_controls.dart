import 'package:flutter/material.dart';
import '../game/game_engine.dart';

class TouchControls extends StatelessWidget {
  final GameEngine engine;
  const TouchControls({super.key, required this.engine});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      child: Stack(
        children: [
          
          Positioned(
            bottom: 40,
            left: 40,
            child: GestureDetector(
              onPanUpdate: (details) {
                final delta = details.localPosition - const Offset(60, 60);
                if (delta.distance > 5) {
                  engine.player.isMoving = true;
                  engine.player.angle = delta.direction;
                }
              },
              onPanEnd: (_) => engine.player.isMoving = false,
              child: _buildControlBtn(120, Colors.white10,
                  icon: Icons.control_camera),
            ),
          ),
          Positioned(
            bottom: 40,
            right: 40,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                GestureDetector(
                  onTap: () => engine.weaponIndex = (engine.weaponIndex + 1) % 3,
                  child: _buildControlBtn(65, Colors.orange.withValues(alpha: 0.4),
                      icon: Icons.sync),
                ),
                const SizedBox(height: 25),
                GestureDetector(
                  onTapDown: (_) => engine.shoot(),
                  child: _buildControlBtn(100, Colors.red.withValues(alpha: 0.5),
                      icon: Icons.gps_fixed),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildControlBtn(double size, Color color, {IconData? icon}) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: color,
          border: Border.all(color: Colors.white24, width: 2),
          boxShadow: [
            if (color != Colors.white10)
              BoxShadow(
                  color: color.withValues(alpha: 0.2),
                  blurRadius: 10,
                  spreadRadius: 2)
          ]),
      child: icon != null
          ? Icon(icon, color: Colors.white, size: size * 0.4)
          : null,
    );
  }
}
