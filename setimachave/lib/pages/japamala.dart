import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:math';

class Japamala extends StatefulWidget {
  const Japamala({Key? key}) : super(key: key);

  @override
  State<Japamala> createState() => _JapamalaState();
}

class _JapamalaState extends State<Japamala> {
  int coloredCount = 0;

  void _handleTap() {
    setState(() {
      coloredCount++;
      if (coloredCount == 108) {
        _vibrateDevice();
      }
    });
  }

  Future<void> _vibrateDevice() async {
    const platform = MethodChannel('your_channel_id');
    try {
      await platform.invokeMethod('vibrate');
    } on PlatformException catch (e) {
      // Lida com erros caso ocorram
    }
  }

  @override
  Widget build(BuildContext context) {
    final double radius = MediaQuery.of(context).size.width * 0.4;
    final double angleBetweenBeads =
        2 * pi / 59; // Ângulo de espaçamento entre as bolinhas
    final double angleOffset =
        pi / 2; // Deslocamento angular para ajustar a posição inicial

    return GestureDetector(
      onTap: _handleTap,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Container(
          width: double.infinity,
          height: double.infinity,
          child: Center(
            child: CustomPaint(
              painter: CircleBeadsPainter(
                coloredCount: coloredCount,
                radius: radius,
                angleBetweenBeads: angleBetweenBeads,
                angleOffset: angleOffset,
              ),
              child: SizedBox(
                width: radius * 2,
                height: radius * 2,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class CircleBeadsPainter extends CustomPainter {
  final int coloredCount;
  final double radius;
  final double angleBetweenBeads;
  final double angleOffset;

  CircleBeadsPainter({
    required this.coloredCount,
    required this.radius,
    required this.angleBetweenBeads,
    required this.angleOffset,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final double centerX = size.width / 2;
    final double centerY = size.height / 2;

    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0; // Tamanho da borda

    for (int index = 0; index < 59; index++) {
      final double angle = angleBetweenBeads * index + angleOffset;

      final double circleX = centerX + radius * cos(angle);
      final double circleY = centerY + radius * sin(angle);

      paint.color = index < coloredCount ? Colors.purple : Colors.white;
      canvas.drawCircle(Offset(circleX, circleY), 10, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
