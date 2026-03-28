import 'package:flutter/material.dart';

class GameOverScreen extends StatelessWidget {
  final int kills;
  final bool isVictory;
  final VoidCallback onRestart;
  final VoidCallback onMenu;

  const GameOverScreen({
    super.key,
    required this.kills,
    required this.isVictory,
    required this.onRestart,
    required this.onMenu,
  });

  @override
  Widget build(BuildContext context) {
    final titleColor = isVictory ? Colors.greenAccent : Colors.redAccent;
    final titleText = isVictory ? "¡MISIÓN CUMPLIDA!" : "HAS CAÍDO EN COMBATE";
    final subText = isVictory
        ? "El sector ha sido purificado de la amenaza."
        : "Tu sacrificio no será olvidado,Forerunner.";

    return Container(
      color: Colors.black.withValues(alpha: 0.85),
      width: double.infinity,
      height: double.infinity,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              isVictory ? Icons.emoji_events : Icons.dangerous,
              color: titleColor,
              size: 80,
            ),
            const SizedBox(height: 20),
            Text(
              titleText,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: titleColor,
                fontSize: 40,
                fontWeight: FontWeight.w900,
                letterSpacing: 2,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              subText,
              style: const TextStyle(color: Colors.white70, fontSize: 16),
            ),
            const SizedBox(height: 40),
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                border: Border.all(color: titleColor.withValues(alpha: 0.5)),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                children: [
                  const Text("ESTADÍSTICAS DE OPERACIÓN",
                      style: TextStyle(color: Colors.white54, fontSize: 12)),
                  const SizedBox(height: 10),
                  Text("BAJAS CONFIRMADAS: $kills",
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.bold)),
                ],
              ),
            ),
            const SizedBox(height: 50),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildButton(
                    label: "REINTENTAR",
                    color: Colors.white24,
                    onTap: onRestart),
                const SizedBox(width: 20),
                _buildButton(
                    label: "MENÚ PRINCIPAL",
                    color: titleColor,
                    onTap: onMenu,
                    isPrimary: true),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildButton(
      {required String label,
      required Color color,
      required VoidCallback onTap,
      bool isPrimary = false}) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: isPrimary ? color : Colors.transparent,
        side: BorderSide(color: color),
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
      ),
      onPressed: onTap,
      child: Text(
        label,
        style: TextStyle(
          color: isPrimary ? Colors.black : Colors.white,
          fontWeight: FontWeight.bold,
          letterSpacing: 1.5,
        ),
      ),
    );
  }
}
