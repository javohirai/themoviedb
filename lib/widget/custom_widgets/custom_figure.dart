import 'dart:math';

import 'package:flutter/material.dart';

class CustomFigureWidget extends StatelessWidget {
  const CustomFigureWidget({super.key});
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 100,
        height: 100,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.transparent),
        ),
        child: RadialPercentWidget(
          percent: 72.0,
          lineWidth: 5.0,
          fillColor: Colors.black,
          freeColor: Colors.yellow,
          lineColor: Colors.red,
        ),
      ),
    );
  }
}

class RadialPercentWidget extends StatelessWidget {
  final double percent;
  final double lineWidth;
  final Color fillColor;
  final Color freeColor;
  final Color lineColor;

  const RadialPercentWidget({
    super.key,
    required this.percent,
    required this.lineWidth,
    required this.fillColor,
    required this.freeColor,
    required this.lineColor,
  });
  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        CustomPaint(
          painter: MyPainter(
            percent: percent / 100,
            lineWidth: lineWidth,
            fillColor: fillColor,
            freeColor: freeColor,
            lineColor: lineColor,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: Text(
              '${percent.toInt().toString()} %',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
      ],
    );
  }
}

class MyPainter extends CustomPainter {
  final double percent;
  final double lineWidth;
  final Color fillColor;
  final Color freeColor;
  final Color lineColor;

  MyPainter({
    required this.percent,
    required this.lineWidth,
    required this.fillColor,
    required this.freeColor,
    required this.lineColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final arcRect = getArcRect(size);
    drawBackground(canvas, size);
    drawFreeArc(canvas, arcRect);
    drawLineArc(canvas, arcRect);
  }

  void drawLineArc(Canvas canvas, Rect arcRect) {
    var paint = Paint();
    paint.color = lineColor;
    paint.style = PaintingStyle.stroke;
    paint.strokeWidth = lineWidth;
    paint.strokeCap = StrokeCap.round;
    canvas.drawArc(arcRect, -pi / 2, 2 * pi * percent, false, paint);
  }

  void drawFreeArc(Canvas canvas, Rect arcRect) {
    var paint = Paint();
    paint.color = freeColor;
    paint.style = PaintingStyle.stroke;
    paint.strokeWidth = lineWidth;
    canvas.drawArc(arcRect, (2 * pi * percent - (pi / 2)),
        (2 * pi * (1 - percent)), false, paint);
  }

  void drawBackground(Canvas canvas, Size size) {
    var paint = Paint();
    paint.color = fillColor;
    paint.style = PaintingStyle.fill;
    canvas.drawOval(Offset.zero & size, paint);
  }

  Rect getArcRect(Size size) {
    final lineMargin = 3;
    final lineOffset = 2;
    final offset = lineWidth / lineOffset + lineMargin;
    final arcRect = Offset(offset, offset) &
        Size(size.width - offset * lineOffset, size.height - offset * lineOffset);
    return arcRect;
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
