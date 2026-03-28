import 'package:flutter/material.dart';
import '../utils/constants.dart';

class SpritePainter {
  static void drawPlayer(Canvas canvas, Offset pos, double angle, double time) {
    final bodyPaint = Paint()..color = CyberColors.highlight;
    final neonPaint = Paint()
      ..color = CyberColors.smartCyan
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 3);
    final shadowPaint = Paint()..color = Colors.black.withValues(alpha: 0.5);

    canvas.save();
    canvas.translate(pos.dx, pos.dy);
    canvas.rotate(angle);

    canvas.drawCircle(const Offset(2, 2), 14, shadowPaint);

    canvas.drawCircle(Offset.zero, 13, bodyPaint);

    canvas.drawRect(const Rect.fromLTWH(6, -4, 5, 8),
        neonPaint..color = CyberColors.smartCyan.withValues(alpha: 0.8));

    canvas.drawRect(
        const Rect.fromLTWH(8, -2, 12, 4), Paint()..color = Colors.black87);
    canvas.drawRect(const Rect.fromLTWH(12, -1, 6, 2), neonPaint);

    canvas.restore();
  }

  static void drawEnemy(Canvas canvas, Offset pos, double angle, bool alive) {
    if (!alive) return;

    final bodyPaint = Paint()..color = CyberColors.glitch;
    final eyePaint = Paint()
      ..color = Colors.redAccent
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 6);

    canvas.save();
    canvas.translate(pos.dx, pos.dy);
    canvas.rotate(angle);

    Path dronePath = Path();
    dronePath.moveTo(15, 0);
    dronePath.lineTo(0, 10);
    dronePath.lineTo(-10, 0);
    dronePath.lineTo(0, -10);
    dronePath.close();

    canvas.drawPath(dronePath, bodyPaint);

    canvas.drawCircle(const Offset(5, 0), 4, eyePaint);

    canvas.restore();
  }

  static void drawBullet(Canvas canvas, Offset pos, double angle) {
    final bulletPaint = Paint()
      ..color = CyberColors.smartCyan
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 2);

    canvas.save();
    canvas.translate(pos.dx, pos.dy);
    canvas.rotate(angle);

    canvas.drawRRect(
        RRect.fromLTRBR(0, -1, 10, 1, const Radius.circular(2)), bulletPaint);

    canvas.restore();
  }

  static void drawWall(Canvas canvas, Rect rect) {
    final wallPaint = Paint()..color = CyberColors.wallBase;
    final edgePaint = Paint()
      ..color = CyberColors.highlight.withValues(alpha: 0.3)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;

    canvas.drawRect(rect, wallPaint);

    canvas.drawRect(rect, edgePaint);
  }

  static void drawExit(Canvas canvas, Rect rect, double time) {
    final portalPaint = Paint()
      ..color = Colors.white
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 8);

    canvas.drawRect(rect, Paint()..color = Colors.black);

    double scale = 0.5 + (0.2 * (time % 1.0));
    canvas.save();
    canvas.translate(rect.center.dx, rect.center.dy);
    canvas.drawCircle(Offset.zero, rect.width * scale, portalPaint);
    canvas.restore();
  }
}
