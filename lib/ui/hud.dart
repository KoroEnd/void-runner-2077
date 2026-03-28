import 'package:flutter/material.dart';
import '../game/levels.dart';

class HUD extends StatelessWidget {
  final double health;
  final int kills;
  final int level;
  final String weaponName;

  const HUD({
    super.key,
    required this.health,
    required this.kills,
    required this.level,
    required this.weaponName,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          top: 40,
          left: 0,
          right: 0,
          child: Center(
            child: Text(
              GameLevels.getName(level),
              style: TextStyle(
                color: Colors.white.withValues(alpha: 0.6),
                fontSize: 16,
                fontWeight: FontWeight.bold,
                letterSpacing: 3,
              ),
            ),
          ),
        ),
        Positioned(
          bottom: 20,
          left: 20,
          right: 20,
          child: Container(
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: Colors.black.withValues(alpha: 0.4),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.white10),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildStat("HEALTH", "${health.toInt()}%",
                    health > 30 ? Colors.greenAccent : Colors.redAccent),
                _buildStat(
                    "WEAPON", weaponName.toUpperCase(), Colors.orangeAccent),
                Row(
                  children: [
                    _buildStat("KILLS", "$kills", Colors.redAccent),
                    const SizedBox(width: 20),
                    _buildStat("LEVEL", "$level", Colors.blueAccent),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildStat(String label, String value, Color color) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
              color: color.withValues(alpha: 0.8),
              fontSize: 10,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.5),
        ),
        Text(
          value,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 22,
            fontWeight: FontWeight.w900,
            fontFamily: 'Courier',
          ),
        ),
      ],
    );
  }
}
