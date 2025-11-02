import 'package:flutter/material.dart';
import 'dart:math' as math;
import '../../utils/constants.dart';

class RouletteWheelWidget extends StatelessWidget {
  const RouletteWheelWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      height: 200,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: RadialGradient(
          colors: [
            AppColors.darkBackground,
            AppColors.cardBackground,
          ],
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.neonRed.withOpacity(0.3),
            blurRadius: 30,
            spreadRadius: 5,
          ),
        ],
      ),
      child: CustomPaint(
        painter: RouletteWheelPainter(),
      ),
    );
  }
}

class RouletteWheelPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;
    
    // Draw outer ring
    final outerPaint = Paint()
      ..color = Colors.amber
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4;
    canvas.drawCircle(center, radius - 2, outerPaint);
    
    // Draw inner circle
    final innerPaint = Paint()
      ..color = AppColors.neonGreen
      ..style = PaintingStyle.fill;
    canvas.drawCircle(center, radius * 0.3, innerPaint);
    
    // Draw segments
    const numbers = RouletteConstants.europeanWheel;
    final segmentAngle = (2 * math.pi) / numbers.length;
    
    for (int i = 0; i < numbers.length; i++) {
      final startAngle = i * segmentAngle - math.pi / 2;
      final number = numbers[i];
      
      final paint = Paint()
        ..color = AppColors.getNumberColor(number).withOpacity(0.5)
        ..style = PaintingStyle.fill;
      
      final path = Path();
      path.moveTo(center.dx, center.dy);
      path.arcTo(
        Rect.fromCircle(center: center, radius: radius * 0.9),
        startAngle,
        segmentAngle,
        false,
      );
      path.close();
      
      canvas.drawPath(path, paint);
      
      // Draw border
      final borderPaint = Paint()
        ..color = Colors.white10
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1;
      canvas.drawPath(path, borderPaint);
    }
    
    // Draw center circle
    final centerPaint = Paint()
      ..color = Colors.amber
      ..style = PaintingStyle.fill;
    canvas.drawCircle(center, radius * 0.2, centerPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
