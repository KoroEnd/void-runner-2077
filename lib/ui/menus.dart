import 'package:flutter/material.dart';

class MainMenu extends StatelessWidget {
  final VoidCallback onStart;
  const MainMenu({super.key, required this.onStart});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black87,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("VOID RUNNER 2D",
                style: TextStyle(
                    fontSize: 50,
                    color: Colors.red,
                    fontWeight: FontWeight.bold)),
            const SizedBox(height: 30),
            ElevatedButton(
                onPressed: onStart, child: const Text("INICIAR MISIÓN")),
          ],
        ),
      ),
    );
  }
}

class GameOverScreen extends StatelessWidget {
  final int kills;
  final bool isVictory;
  final VoidCallback onRestart;

  const GameOverScreen(
      {super.key,
      required this.kills,
      required this.isVictory,
      required this.onRestart});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black87,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(isVictory ? "¡VICTORIA!" : "HAS MUERTO",
                style: TextStyle(
                    fontSize: 40,
                    color: isVictory ? Colors.green : Colors.red)),
            const SizedBox(height: 10),
            Text("PUNTUACIÓN: $kills BAJAS",
                style: const TextStyle(fontSize: 24, color: Colors.white)),
            const SizedBox(height: 30),
            ElevatedButton(
                onPressed: onRestart, child: const Text("VOLVER A INTENTAR")),
          ],
        ),
      ),
    );
  }
}
