import 'dart:math' as math;
import 'dart:ui' as ui;
import 'package:flutter/material.dart';

/// Data model representing an isometric facet of the Proport "P" monogram.
class _FacetConfig {
  final List<Offset> points;
  final Color fillColor;
  final double strokeStart;
  final double strokeEnd;
  final double fillStart;
  final double fillEnd;

  const _FacetConfig({
    required this.points,
    required this.fillColor,
    required this.strokeStart,
    required this.strokeEnd,
    required this.fillStart,
    required this.fillEnd,
  });

  Path buildPath() {
    final path = Path();
    if (points.isEmpty) return path;
    path.moveTo(points.first.dx, points.first.dy);
    for (int i = 1; i < points.length; i++) {
      path.lineTo(points[i].dx, points[i].dy);
    }
    path.close();
    return path;
  }
}

/// Custom animated Proport logo that first traces the geometric blueprint lines
/// with glowing electric strokes and laser sparks, followed by an organic
/// facet-by-facet fill transition and ambient shimmer bloom.
class ProportAnimatedLogo extends StatelessWidget {
  final double progress; // 0.0 to 1.0
  final double size;
  final Color glowColor;

  const ProportAnimatedLogo({
    super.key,
    required this.progress,
    this.size = 120.0,
    this.glowColor = const Color(0xFF3875FF),
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: CustomPaint(
        painter: _ProportLogoPainter(
          progress: progress.clamp(0.0, 1.0),
          glowColor: glowColor,
        ),
      ),
    );
  }
}

class _ProportLogoPainter extends CustomPainter {
  final double progress;
  final Color glowColor;

  _ProportLogoPainter({
    required this.progress,
    required this.glowColor,
  });

  // Authentic 6 isometric facets of the Proport "P" monogram
  static const List<_FacetConfig> _facets = [
    // 0: Left Pillar - Main Front Facet (Pure White)
    _FacetConfig(
      points: [
        Offset(106, 195),
        Offset(200, 141),
        Offset(200, 407),
        Offset(106, 353),
      ],
      fillColor: Color(0xFFFFFFFF),
      strokeStart: 0.00,
      strokeEnd: 0.32,
      fillStart: 0.40,
      fillEnd: 0.65,
    ),
    // 1: Left Pillar - Side Shadow Facet (Cool Grey)
    _FacetConfig(
      points: [
        Offset(210, 135),
        Offset(254, 110),
        Offset(254, 376),
        Offset(210, 401),
      ],
      fillColor: Color(0xFFB0B0B0),
      strokeStart: 0.06,
      strokeEnd: 0.38,
      fillStart: 0.44,
      fillEnd: 0.69,
    ),
    // 2: Upper Loop - Top Angled Facet (Pure White)
    _FacetConfig(
      points: [
        Offset(264, 105),
        Offset(358, 159),
        Offset(358, 205),
        Offset(264, 151),
      ],
      fillColor: Color(0xFFFFFFFF),
      strokeStart: 0.14,
      strokeEnd: 0.44,
      fillStart: 0.48,
      fillEnd: 0.73,
    ),
    // 3: Upper Loop - Inner Shadow Facet (Muted Grey)
    _FacetConfig(
      points: [
        Offset(264, 225),
        Offset(350, 275),
        Offset(306, 300),
        Offset(264, 276),
      ],
      fillColor: Color(0xFF7E7E86),
      strokeStart: 0.18,
      strokeEnd: 0.47,
      fillStart: 0.52,
      fillEnd: 0.76,
    ),
    // 4: Upper Loop - Dynamic Outer Face (Proport Electric Blue)
    _FacetConfig(
      points: [
        Offset(368, 165),
        Offset(406, 187),
        Offset(406, 293),
        Offset(368, 271),
      ],
      fillColor: Color(0xFF3875FF),
      strokeStart: 0.22,
      strokeEnd: 0.50,
      fillStart: 0.56,
      fillEnd: 0.80,
    ),
    // 5: Upper Loop - Return Bottom Facet (Deep Royal Blue)
    _FacetConfig(
      points: [
        Offset(358, 277),
        Offset(396, 299),
        Offset(310, 348),
        Offset(272, 326),
      ],
      fillColor: Color(0xFF2050CC),
      strokeStart: 0.26,
      strokeEnd: 0.54,
      fillStart: 0.60,
      fillEnd: 0.84,
    ),
  ];

  @override
  void paint(Canvas canvas, Size size) {
    if (size.width <= 0 || size.height <= 0) return;

    // Background scale transform to normalize 512x512 coordinate space
    final double scale = size.width / 512.0;
    canvas.save();
    canvas.scale(scale, scale);

    // 1. Ambient Radial Glow behind the facets
    _paintAmbientGlow(canvas);

    // 2. Fills (Fade-in per facet)
    _paintFacetFills(canvas);

    // 3. Line Tracing (Strokes with neon bloom & laser head)
    _paintFacetStrokes(canvas);

    // 4. Subtle Shimmer / Light Sweep on completion
    _paintShimmerSweep(canvas);

    canvas.restore();
  }

  void _paintAmbientGlow(Canvas canvas) {
    if (progress < 0.25) return;

    // Glow fades in from 0.25 to 0.85 and breathes
    final double glowProgress = ((progress - 0.25) / 0.60).clamp(0.0, 1.0);
    final double alpha = 0.35 * Curves.easeOutQuad.transform(glowProgress);

    final Paint glowPaint = Paint()
      ..color = glowColor.withValues(alpha: alpha)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 56.0);

    // Center of the logo in 512 coordinate space is at (256, 256)
    canvas.drawCircle(const Offset(256, 256), 110, glowPaint);
  }

  void _paintFacetFills(Canvas canvas) {
    for (final facet in _facets) {
      if (progress < facet.fillStart) continue;

      final double rawT =
          (progress - facet.fillStart) / (facet.fillEnd - facet.fillStart);
      final double fillT = Curves.easeOutCubic.transform(rawT.clamp(0.0, 1.0));

      final path = facet.buildPath();
      final fillPaint = Paint()
        ..style = PaintingStyle.fill
        ..color = facet.fillColor.withValues(alpha: fillT);

      canvas.drawPath(path, fillPaint);
    }
  }

  void _paintFacetStrokes(Canvas canvas) {
    // Overall stroke master fade: 1.0 until 0.65, then smoothly decreases to 0.0 by 0.90
    double strokeAlpha = 1.0;
    if (progress >= 0.65) {
      strokeAlpha = 1.0 - ((progress - 0.65) / 0.25).clamp(0.0, 1.0);
    }
    if (strokeAlpha <= 0.0) return;

    for (final facet in _facets) {
      if (progress < facet.strokeStart) continue;

      final double rawT = (progress - facet.strokeStart) /
          (facet.strokeEnd - facet.strokeStart);
      final double strokeT = Curves.easeInOutCubic.transform(rawT.clamp(0.0, 1.0));

      final fullPath = facet.buildPath();
      final metrics = fullPath.computeMetrics();

      for (final metric in metrics) {
        final double currentLen = metric.length * strokeT;
        if (currentLen <= 0.0) continue;

        final strokePath = metric.extractPath(0.0, currentLen);

        // A. Neon Outer Glow Stroke
        final outerGlowPaint = Paint()
          ..style = PaintingStyle.stroke
          ..strokeWidth = 9.0
          ..strokeCap = StrokeCap.round
          ..strokeJoin = StrokeJoin.round
          ..color = glowColor.withValues(alpha: 0.35 * strokeAlpha)
          ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 6.0);
        canvas.drawPath(strokePath, outerGlowPaint);

        // B. Vibrant Electric Blue Mid Stroke
        final midStrokePaint = Paint()
          ..style = PaintingStyle.stroke
          ..strokeWidth = 4.5
          ..strokeCap = StrokeCap.round
          ..strokeJoin = StrokeJoin.round
          ..color = const Color(0xFF60A5FA).withValues(alpha: 0.85 * strokeAlpha);
        canvas.drawPath(strokePath, midStrokePaint);

        // C. Razor Crisp White/Cyan Core Stroke
        final coreStrokePaint = Paint()
          ..style = PaintingStyle.stroke
          ..strokeWidth = 2.0
          ..strokeCap = StrokeCap.round
          ..strokeJoin = StrokeJoin.round
          ..color = Colors.white.withValues(alpha: 0.95 * strokeAlpha);
        canvas.drawPath(strokePath, coreStrokePaint);

        // D. Laser Spark at the leading drawing edge
        if (strokeT > 0.01 && strokeT < 0.99) {
          final tangent = metric.getTangentForOffset(currentLen);
          if (tangent != null) {
            final sparkPaint = Paint()
              ..color = Colors.white.withValues(alpha: strokeAlpha)
              ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 2.0);
            canvas.drawCircle(tangent.position, 4.0, sparkPaint);

            final sparkGlow = Paint()
              ..color = glowColor.withValues(alpha: 0.7 * strokeAlpha)
              ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 8.0);
            canvas.drawCircle(tangent.position, 8.0, sparkGlow);
          }
        }
      }
    }
  }

  void _paintShimmerSweep(Canvas canvas) {
    if (progress < 0.80) return;

    // Linear light sheen sweeping from top-left to bottom-right
    final double sweepT = ((progress - 0.80) / 0.18).clamp(0.0, 1.0);
    final double sweepOffset = -150.0 + (sweepT * 800.0);

    final Path combinedPath = Path();
    for (final facet in _facets) {
      combinedPath.addPath(facet.buildPath(), Offset.zero);
    }

    canvas.save();
    canvas.clipPath(combinedPath);

    final shimmerPaint = Paint()
      ..shader = ui.Gradient.linear(
        Offset(sweepOffset - 80, sweepOffset - 80),
        Offset(sweepOffset + 80, sweepOffset + 80),
        [
          Colors.white.withValues(alpha: 0.0),
          Colors.white.withValues(alpha: 0.28 * math.sin(sweepT * math.pi)),
          Colors.white.withValues(alpha: 0.0),
        ],
        [0.0, 0.5, 1.0],
      );

    canvas.drawRect(const Rect.fromLTWH(0, 0, 512, 512), shimmerPaint);
    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant _ProportLogoPainter oldDelegate) {
    return oldDelegate.progress != progress || oldDelegate.glowColor != glowColor;
  }
}
