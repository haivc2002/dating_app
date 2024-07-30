import 'package:dating/theme/theme_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Wait extends StatefulWidget {
  final Color? color;
  final double? strokeWidth, size;
  const Wait({super.key, this.color, this.strokeWidth, this.size});

  @override
  State<Wait> createState() => _WaitState();
}

class _WaitState extends State<Wait> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Transform.rotate(
          angle: _controller.value * 2.0 * 3.141592653589793,
          child: child,
        );
      },
      child: CustomPaint(
        size: Size(widget.size ?? 25.w, widget.size ?? 25.w),
        painter: CircularSegmentPainter(
          color: widget.color ?? ThemeColor.blackColor,
          strokeWidth: widget.strokeWidth ?? 3.w
        ),
      ),
    );
  }
}

class CircularSegmentPainter extends CustomPainter {
  final double strokeWidth;
  final Color color;
  CircularSegmentPainter({ required this.strokeWidth, required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    final Rect rect = Rect.fromLTWH(0, 0, size.width, size.height);
    const double startAngle = -90 * 3.141592653589793 / 180;
    const double sweepAngle = 290 * 3.141592653589793 / 180;

    canvas.drawArc(rect, startAngle, sweepAngle, false, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}

