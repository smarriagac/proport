import 'dart:math' as math;
import 'package:flutter/material.dart';

/// Native CustomPainter that renders the authentic Symmetry Front & Back
/// anatomical body heatmap with muscle cuts, tier colors, and white contour strokes.
class SymmetryBodyDiagram extends StatelessWidget {
  final Map<String, Color>? muscleColors;
  final double height;

  const SymmetryBodyDiagram({
    super.key,
    this.muscleColors,
    this.height = 370,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: double.infinity,
      child: CustomPaint(
        painter: SymmetryBodyPainter(muscleColors: muscleColors),
      ),
    );
  }
}

class SymmetryBodyPainter extends CustomPainter {
  final Map<String, Color>? muscleColors;

  const SymmetryBodyPainter({this.muscleColors});

  // Authentic Symmetry Muscle Colors from Screenshot
  static const Color colorAmber = Color(0xFFF5A623); // Gold / Amber
  static const Color colorRed = Color(0xFFD32F2F); // Crimson Red
  static const Color colorGreen = Color(0xFF00C853); // Emerald Green
  static const Color colorBronze = Color(0xFF9C6634); // Bronze / Tan
  static const Color colorGlutes = Color(0xFF18181B); // Dark Charcoal
  static const Color colorWhite = Color(0xFFFFFFFF); // Stroke
  static const Color colorBlack = Color(0xFF000000); // Interior fill for unranked/joints

  @override
  void paint(Canvas canvas, Size size) {
    // Reference coordinate space: 360 x 380
    const double refWidth = 360.0;
    const double refHeight = 380.0;

    final double scale = math.min(size.width / refWidth, size.height / refHeight);
    final double offsetX = (size.width - refWidth * scale) / 2.0;
    final double offsetY = (size.height - refHeight * scale) / 2.0;

    canvas.save();
    canvas.translate(offsetX, offsetY);
    canvas.scale(scale, scale);

    // Paints
    final strokePaint = Paint()
      ..color = colorWhite
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.9
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    final thinStrokePaint = Paint()
      ..color = colorWhite
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.3
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    final blackFill = Paint()
      ..color = colorBlack
      ..style = PaintingStyle.fill;

    // Muscle Fills (Overridable via muscleColors map)
    final shoulderFill = Paint()..color = muscleColors?['shoulders'] ?? colorAmber;
    final chestFill = Paint()..color = muscleColors?['chest'] ?? colorRed;
    final bicepOuterFill = Paint()..color = muscleColors?['biceps_outer'] ?? colorAmber;
    final bicepInnerFill = Paint()..color = muscleColors?['biceps_inner'] ?? colorRed;
    final forearmFill = Paint()..color = muscleColors?['forearms'] ?? colorBronze;
    final absFill = Paint()..color = muscleColors?['abs'] ?? colorGreen;
    final quadsOuterFill = Paint()..color = muscleColors?['quads_outer'] ?? colorAmber;
    final quadsInnerFill = Paint()..color = muscleColors?['quads_inner'] ?? colorRed;
    final calfFill = Paint()..color = muscleColors?['calves'] ?? colorGreen;

    final trapFill = Paint()..color = muscleColors?['traps'] ?? colorBronze;
    final rearDeltFill = Paint()..color = muscleColors?['rear_delts'] ?? colorAmber;
    final infraspinatusFill = Paint()..color = muscleColors?['infraspinatus'] ?? colorRed;
    final tricepFill = Paint()..color = muscleColors?['triceps'] ?? colorAmber;
    final latsFill = Paint()..color = muscleColors?['lats'] ?? colorGreen;
    final lumbarFill = Paint()..color = muscleColors?['lumbar'] ?? colorRed;
    final glutesFill = Paint()..color = muscleColors?['glutes'] ?? colorGlutes;
    final hamstringsFill = Paint()..color = muscleColors?['hamstrings'] ?? colorAmber;

    // -------------------------------------------------------------
    // 1. FRONT VIEW SILHOUETTE (Center x = 95, y = 10)
    // -------------------------------------------------------------
    _drawFrontFigure(
      canvas: canvas,
      cx: 95.0,
      cy: 10.0,
      stroke: strokePaint,
      thinStroke: thinStrokePaint,
      blackFill: blackFill,
      shoulderFill: shoulderFill,
      chestFill: chestFill,
      bicepOuterFill: bicepOuterFill,
      bicepInnerFill: bicepInnerFill,
      forearmFill: forearmFill,
      absFill: absFill,
      quadsOuterFill: quadsOuterFill,
      quadsInnerFill: quadsInnerFill,
      calfFill: calfFill,
    );

    // -------------------------------------------------------------
    // 2. BACK VIEW SILHOUETTE (Center x = 265, y = 10)
    // -------------------------------------------------------------
    _drawBackFigure(
      canvas: canvas,
      cx: 265.0,
      cy: 10.0,
      stroke: strokePaint,
      thinStroke: thinStrokePaint,
      blackFill: blackFill,
      trapFill: trapFill,
      rearDeltFill: rearDeltFill,
      infraspinatusFill: infraspinatusFill,
      tricepFill: tricepFill,
      forearmFill: forearmFill,
      latsFill: latsFill,
      lumbarFill: lumbarFill,
      glutesFill: glutesFill,
      hamstringsFill: hamstringsFill,
      calfFill: calfFill,
    );

    canvas.restore();
  }

  // ===========================================================================
  // FRONT VIEW IMPLEMENTATION
  // ===========================================================================
  void _drawFrontFigure({
    required Canvas canvas,
    required double cx,
    required double cy,
    required Paint stroke,
    required Paint thinStroke,
    required Paint blackFill,
    required Paint shoulderFill,
    required Paint chestFill,
    required Paint bicepOuterFill,
    required Paint bicepInnerFill,
    required Paint forearmFill,
    required Paint absFill,
    required Paint quadsOuterFill,
    required Paint quadsInnerFill,
    required Paint calfFill,
  }) {
    canvas.save();
    canvas.translate(cx, cy);

    // 1. Draw bilateral muscle fills (Right side then Mirrored Left side)
    for (final sign in [1.0, -1.0]) {
      canvas.save();
      canvas.scale(sign, 1.0);

      // Shoulders (Deltoids)
      final shoulderPath = Path()
        ..moveTo(18, 55)
        ..cubicTo(26, 52, 37, 57, 41, 67)
        ..cubicTo(43, 73, 42, 83, 37, 92)
        ..cubicTo(34, 96, 30, 94, 28, 88)
        ..cubicTo(25, 82, 23, 71, 19, 64)
        ..close();
      canvas.drawPath(shoulderPath, shoulderFill);

      // Chest (Pectoralis)
      final chestPath = Path()
        ..moveTo(1.2, 57)
        ..lineTo(17, 56)
        ..cubicTo(20, 64, 23, 73, 26, 82)
        ..cubicTo(25, 88, 22, 93, 18, 95)
        ..cubicTo(12, 98, 6, 96, 1.2, 91)
        ..close();
      canvas.drawPath(chestPath, chestFill);

      // Outer Bicep (Long Head)
      final bicepOuterPath = Path()
        ..moveTo(34, 90)
        ..cubicTo(40, 100, 42, 114, 40, 128)
        ..lineTo(35, 129)
        ..cubicTo(34, 117, 32, 104, 30, 93)
        ..close();
      canvas.drawPath(bicepOuterPath, bicepOuterFill);

      // Inner Bicep (Short Head)
      final bicepInnerPath = Path()
        ..moveTo(22, 90)
        ..cubicTo(23, 100, 25, 114, 28, 128)
        ..lineTo(34, 129)
        ..cubicTo(32, 116, 30, 103, 28, 91)
        ..close();
      canvas.drawPath(bicepInnerPath, bicepInnerFill);

      // Forearm
      final forearmPath = Path()
        ..moveTo(31, 133)
        ..cubicTo(39, 139, 45, 154, 46, 173)
        ..cubicTo(46, 186, 43, 198, 41, 207)
        ..lineTo(35, 204)
        ..cubicTo(35, 192, 32, 175, 28, 156)
        ..cubicTo(27, 145, 28, 137, 31, 133)
        ..close();
      canvas.drawPath(forearmPath, forearmFill);

      // Abdominals (Right Half)
      // Upper Ab
      final upperAb = Path()
        ..moveTo(1.2, 93)
        ..lineTo(11, 95)
        ..cubicTo(11.5, 102, 11.5, 108, 11, 111)
        ..lineTo(1.2, 111)
        ..close();
      canvas.drawPath(upperAb, absFill);

      // Middle Ab
      final midAb = Path()
        ..moveTo(1.2, 113)
        ..lineTo(11.5, 113)
        ..cubicTo(12, 123, 12, 128, 11.5, 134)
        ..lineTo(1.2, 134)
        ..close();
      canvas.drawPath(midAb, absFill);

      // Lower Ab
      final lowerAb = Path()
        ..moveTo(1.2, 136)
        ..lineTo(11, 136)
        ..cubicTo(11, 147, 10.5, 153, 10, 158)
        ..lineTo(1.2, 158)
        ..close();
      canvas.drawPath(lowerAb, absFill);

      // Obliques / Serratus Flank
      final obliquePath = Path()
        ..moveTo(13, 97)
        ..cubicTo(19, 108, 20, 126, 18, 145)
        ..cubicTo(17, 155, 18, 162, 15, 170)
        ..cubicTo(13, 172, 10, 165, 10, 158)
        ..lineTo(11, 136)
        ..lineTo(11.5, 113)
        ..lineTo(11, 95)
        ..close();
      canvas.drawPath(obliquePath, absFill);

      // V-Cut Lower Core
      final vCutPath = Path()
        ..moveTo(1.2, 159)
        ..lineTo(9.5, 159)
        ..cubicTo(8, 168, 5, 176, 1.2, 183)
        ..close();
      canvas.drawPath(vCutPath, absFill);

      // Outer Quad (Vastus Lateralis & Rectus Femoris)
      final quadsOuterPath = Path()
        ..moveTo(19, 172)
        ..cubicTo(26, 181, 32, 200, 32, 220)
        ..cubicTo(31, 237, 27, 252, 23, 266)
        ..lineTo(18, 264)
        ..cubicTo(20, 245, 21, 216, 19, 186)
        ..close();
      canvas.drawPath(quadsOuterPath, quadsOuterFill);

      final rectusFemorisPath = Path()
        ..moveTo(16, 176)
        ..cubicTo(18, 205, 18, 234, 16, 263)
        ..lineTo(12, 263)
        ..cubicTo(14, 235, 13, 206, 11, 178)
        ..close();
      canvas.drawPath(rectusFemorisPath, quadsOuterFill);

      // Inner Quad / Teardrop (Vastus Medialis & Adductors)
      final quadsInnerPath = Path()
        ..moveTo(4.5, 196)
        ..cubicTo(4.5, 211, 6.5, 231, 9, 250)
        ..cubicTo(10, 258, 12, 263, 14, 264)
        ..cubicTo(13, 239, 11, 216, 9, 198)
        ..close();
      canvas.drawPath(quadsInnerPath, quadsInnerFill);

      // Calf (Front View)
      final calfPath = Path()
        ..moveTo(14, 279)
        ..cubicTo(22, 285, 25, 300, 24, 315)
        ..cubicTo(23, 325, 19, 335, 16, 342)
        ..lineTo(12, 342)
        ..cubicTo(11, 331, 9, 316, 9, 298)
        ..cubicTo(10, 287, 12, 281, 14, 279)
        ..close();
      canvas.drawPath(calfPath, calfFill);

      // Hands (Front View - Black Fill)
      final handPath = Path()
        ..moveTo(41, 207)
        ..cubicTo(44, 211, 48, 215, 50, 219)
        ..cubicTo(52, 222, 50, 225, 47, 224)
        ..lineTo(45, 222)
        ..cubicTo(48, 230, 48, 237, 45, 242)
        ..cubicTo(44, 246, 41, 246, 40, 242)
        ..cubicTo(40, 244, 38, 243, 37, 239)
        ..cubicTo(37, 240, 34, 238, 34, 233)
        ..cubicTo(34, 225, 34, 215, 35, 204)
        ..close();
      canvas.drawPath(handPath, blackFill);

      // Feet (Front View - Black Fill)
      final footPath = Path()
        ..moveTo(16, 342)
        ..cubicTo(18, 348, 18, 356, 16, 362)
        ..lineTo(11, 362)
        ..cubicTo(10, 355, 10, 348, 12, 342)
        ..close();
      canvas.drawPath(footPath, blackFill);

      canvas.restore();
    }

    // 2. Center Non-Mirrored Shapes / Groin / Head (Black Fill)
    final headPath = Path()
      ..moveTo(0, 8)
      ..cubicTo(7, 8, 13, 14, 13, 23)
      ..cubicTo(14.5, 25, 14.5, 30, 12.5, 32)
      ..cubicTo(11.5, 36, 5.5, 41, 3.0, 42.5)
      ..lineTo(-3.0, 42.5)
      ..cubicTo(-5.5, 41, -11.5, 36, -12.5, 32)
      ..cubicTo(-14.5, 30, -14.5, 25, -13, 23)
      ..cubicTo(-13, 14, -7, 8, 0, 8)
      ..close();
    canvas.drawPath(headPath, blackFill);

    final neckPath = Path()
      ..moveTo(-7, 42)
      ..lineTo(-10, 53)
      ..cubicTo(-5, 56, 5, 56, 10, 53)
      ..lineTo(7, 42)
      ..close();
    canvas.drawPath(neckPath, blackFill);

    final groinPath = Path()
      ..moveTo(0, 184)
      ..lineTo(4.5, 196)
      ..lineTo(-4.5, 196)
      ..close();
    canvas.drawPath(groinPath, blackFill);

    // 3. Draw crisp white contour and division strokes
    for (final sign in [1.0, -1.0]) {
      canvas.save();
      canvas.scale(sign, 1.0);

      // Clavicle & Neck
      final clavicle = Path()
        ..moveTo(0, 56)
        ..lineTo(18, 55);
      canvas.drawPath(clavicle, stroke);

      // Deltoid Outline & Division
      final shoulderOutline = Path()
        ..moveTo(18, 55)
        ..cubicTo(26, 52, 37, 57, 41, 67)
        ..cubicTo(43, 73, 42, 83, 37, 92)
        ..cubicTo(34, 96, 30, 94, 28, 88)
        ..cubicTo(25, 82, 23, 71, 19, 64)
        ..close();
      canvas.drawPath(shoulderOutline, stroke);

      final shoulderCut = Path()
        ..moveTo(27, 56)
        ..cubicTo(33, 67, 34, 78, 33, 88);
      canvas.drawPath(shoulderCut, thinStroke);

      // Chest Outline
      final chestOutline = Path()
        ..moveTo(1.2, 57)
        ..lineTo(17, 56)
        ..cubicTo(20, 64, 23, 73, 26, 82)
        ..cubicTo(25, 88, 22, 93, 18, 95)
        ..cubicTo(12, 98, 6, 96, 1.2, 91)
        ..close();
      canvas.drawPath(chestOutline, stroke);

      // Biceps & Arms Outlines
      final bicepOuterOutline = Path()
        ..moveTo(34, 90)
        ..cubicTo(40, 100, 42, 114, 40, 128)
        ..lineTo(35, 129)
        ..cubicTo(34, 117, 32, 104, 30, 93)
        ..close();
      canvas.drawPath(bicepOuterOutline, stroke);

      final bicepInnerOutline = Path()
        ..moveTo(22, 90)
        ..cubicTo(23, 100, 25, 114, 28, 128)
        ..lineTo(34, 129);
      canvas.drawPath(bicepInnerOutline, stroke);

      // Forearm Outline & Internal Division
      final forearmOutline = Path()
        ..moveTo(31, 133)
        ..cubicTo(39, 139, 45, 154, 46, 173)
        ..cubicTo(46, 186, 43, 198, 41, 207)
        ..lineTo(35, 204)
        ..cubicTo(35, 192, 32, 175, 28, 156)
        ..cubicTo(27, 145, 28, 137, 31, 133)
        ..close();
      canvas.drawPath(forearmOutline, stroke);

      final forearmCut = Path()
        ..moveTo(36, 136)
        ..cubicTo(39, 156, 40, 180, 39, 201);
      canvas.drawPath(forearmCut, thinStroke);

      // Hand Outline
      final handOutline = Path()
        ..moveTo(41, 207)
        ..cubicTo(44, 211, 48, 215, 50, 219)
        ..cubicTo(52, 222, 50, 225, 47, 224)
        ..lineTo(45, 222)
        ..cubicTo(48, 230, 48, 237, 45, 242)
        ..cubicTo(44, 246, 41, 246, 40, 242)
        ..cubicTo(40, 244, 38, 243, 37, 239)
        ..cubicTo(37, 240, 34, 238, 34, 233)
        ..cubicTo(34, 225, 34, 215, 35, 204)
        ..close();
      canvas.drawPath(handOutline, stroke);

      // 6-Pack Dividers & Obliques
      final upperAbOutline = Path()
        ..moveTo(1.2, 93)
        ..lineTo(11, 95)
        ..cubicTo(11.5, 102, 11.5, 108, 11, 111)
        ..lineTo(1.2, 111)
        ..close();
      canvas.drawPath(upperAbOutline, thinStroke);

      final midAbOutline = Path()
        ..moveTo(1.2, 113)
        ..lineTo(11.5, 113)
        ..cubicTo(12, 123, 12, 128, 11.5, 134)
        ..lineTo(1.2, 134)
        ..close();
      canvas.drawPath(midAbOutline, thinStroke);

      final lowerAbOutline = Path()
        ..moveTo(1.2, 136)
        ..lineTo(11, 136)
        ..cubicTo(11, 147, 10.5, 153, 10, 158)
        ..lineTo(1.2, 158)
        ..close();
      canvas.drawPath(lowerAbOutline, thinStroke);

      final obliqueOutline = Path()
        ..moveTo(13, 97)
        ..cubicTo(19, 108, 20, 126, 18, 145)
        ..cubicTo(17, 155, 18, 162, 15, 170)
        ..cubicTo(13, 172, 10, 165, 10, 158);
      canvas.drawPath(obliqueOutline, stroke);

      final vCutOutline = Path()
        ..moveTo(1.2, 159)
        ..lineTo(9.5, 159)
        ..cubicTo(8, 168, 5, 176, 1.2, 183);
      canvas.drawPath(vCutOutline, thinStroke);

      // Quads Outlines & Muscle Sweeps
      final quadsOuterOutline = Path()
        ..moveTo(19, 172)
        ..cubicTo(26, 181, 32, 200, 32, 220)
        ..cubicTo(31, 237, 27, 252, 23, 266)
        ..lineTo(18, 264)
        ..cubicTo(20, 245, 21, 216, 19, 186)
        ..close();
      canvas.drawPath(quadsOuterOutline, stroke);

      final rectusFemorisOutline = Path()
        ..moveTo(16, 176)
        ..cubicTo(18, 205, 18, 234, 16, 263);
      canvas.drawPath(rectusFemorisOutline, thinStroke);

      final quadsInnerOutline = Path()
        ..moveTo(4.5, 196)
        ..cubicTo(4.5, 211, 6.5, 231, 9, 250)
        ..cubicTo(10, 258, 12, 263, 14, 264)
        ..cubicTo(13, 239, 11, 216, 9, 198)
        ..close();
      canvas.drawPath(quadsInnerOutline, stroke);

      // Knee (Patella)
      final kneeOutline = Path()
        ..moveTo(12, 266)
        ..cubicTo(12, 263, 18, 263, 18, 266)
        ..cubicTo(18, 275, 12, 275, 12, 266)
        ..close();
      canvas.drawPath(kneeOutline, stroke);

      // Calf Outline & Tibial Crest
      final calfOutline = Path()
        ..moveTo(14, 279)
        ..cubicTo(22, 285, 25, 300, 24, 315)
        ..cubicTo(23, 325, 19, 335, 16, 342)
        ..lineTo(12, 342)
        ..cubicTo(11, 331, 9, 316, 9, 298)
        ..cubicTo(10, 287, 12, 281, 14, 279)
        ..close();
      canvas.drawPath(calfOutline, stroke);

      final shinCut = Path()
        ..moveTo(15, 282)
        ..cubicTo(16, 300, 16, 320, 14, 338);
      canvas.drawPath(shinCut, thinStroke);

      // Foot Outline
      final footOutline = Path()
        ..moveTo(16, 342)
        ..cubicTo(18, 348, 18, 356, 16, 362)
        ..lineTo(11, 362)
        ..cubicTo(10, 355, 10, 348, 12, 342)
        ..close();
      canvas.drawPath(footOutline, stroke);

      canvas.restore();
    }

    // Central Strokes (Head, Neck, Linea Alba)
    canvas.drawPath(headPath, stroke);

    final neckStrokes = Path()
      ..moveTo(-7, 42)
      ..lineTo(-10, 53)
      ..moveTo(7, 42)
      ..lineTo(10, 53)
      ..moveTo(-10, 53)
      ..cubicTo(-5, 56, 5, 56, 10, 53);
    canvas.drawPath(neckStrokes, stroke);

    // Linea Alba (Center Line of Abs)
    final lineaAlba = Path()
      ..moveTo(0, 57)
      ..lineTo(0, 184);
    canvas.drawPath(lineaAlba, stroke);

    canvas.restore();
  }

  // ===========================================================================
  // BACK VIEW IMPLEMENTATION
  // ===========================================================================
  void _drawBackFigure({
    required Canvas canvas,
    required double cx,
    required double cy,
    required Paint stroke,
    required Paint thinStroke,
    required Paint blackFill,
    required Paint trapFill,
    required Paint rearDeltFill,
    required Paint infraspinatusFill,
    required Paint tricepFill,
    required Paint forearmFill,
    required Paint latsFill,
    required Paint lumbarFill,
    required Paint glutesFill,
    required Paint hamstringsFill,
    required Paint calfFill,
  }) {
    canvas.save();
    canvas.translate(cx, cy);

    // 1. Draw bilateral muscle fills
    for (final sign in [1.0, -1.0]) {
      canvas.save();
      canvas.scale(sign, 1.0);

      // Trapezius Wing (Back)
      final trapPath = Path()
        ..moveTo(0, 44)
        ..cubicTo(7, 47, 15, 54, 22, 63)
        ..cubicTo(18, 80, 13, 104, 0, 130)
        ..close();
      canvas.drawPath(trapPath, trapFill);

      // Rear Deltoid
      final rearDeltPath = Path()
        ..moveTo(22, 63)
        ..cubicTo(31, 61, 40, 68, 40, 80)
        ..cubicTo(39, 90, 35, 98, 31, 102)
        ..cubicTo(28, 94, 24, 82, 22, 73)
        ..close();
      canvas.drawPath(rearDeltPath, rearDeltFill);

      // Infraspinatus / Teres (Scapular Red)
      final infraspinatusPath = Path()
        ..moveTo(20, 71)
        ..lineTo(30, 78)
        ..cubicTo(31, 90, 29, 102, 28, 109)
        ..cubicTo(23, 106, 17, 101, 13, 93)
        ..close();
      canvas.drawPath(infraspinatusPath, infraspinatusFill);

      // Tricep (Back)
      final tricepPath = Path()
        ..moveTo(31, 102)
        ..cubicTo(38, 110, 40, 122, 38, 135)
        ..lineTo(32, 136)
        ..cubicTo(30, 124, 28, 114, 27, 109)
        ..close();
      canvas.drawPath(tricepPath, tricepFill);

      // Forearm (Back View)
      final forearmPath = Path()
        ..moveTo(31, 136)
        ..cubicTo(39, 142, 45, 157, 46, 175)
        ..cubicTo(46, 188, 43, 200, 41, 209)
        ..lineTo(35, 206)
        ..cubicTo(35, 194, 32, 177, 28, 158)
        ..cubicTo(27, 147, 28, 139, 31, 136)
        ..close();
      canvas.drawPath(forearmPath, forearmFill);

      // Latissimus Dorsi (Lats - Green V-Taper)
      final latsPath = Path()
        ..moveTo(26, 111)
        ..cubicTo(30, 120, 28, 137, 23, 154)
        ..cubicTo(20, 164, 16, 169, 11, 175)
        ..lineTo(0, 153)
        ..lineTo(0, 130)
        ..cubicTo(9, 121, 18, 116, 26, 111)
        ..close();
      canvas.drawPath(latsPath, latsFill);

      // Glutes (Gluteus Maximus - Dark Charcoal)
      final glutesPath = Path()
        ..moveTo(0, 178)
        ..cubicTo(7, 178, 16, 182, 22, 192)
        ..cubicTo(24, 200, 24, 211, 20, 222)
        ..cubicTo(16, 228, 7, 228, 0, 226)
        ..close();
      canvas.drawPath(glutesPath, glutesFill);

      // Hamstrings (Posterior Thighs)
      final hamstringsPath = Path()
        ..moveTo(20, 222)
        ..cubicTo(23, 234, 25, 249, 24, 264)
        ..lineTo(16, 268)
        ..cubicTo(11, 264, 5, 253, 3, 230)
        ..lineTo(0, 226)
        ..close();
      canvas.drawPath(hamstringsPath, hamstringsFill);

      // Calves (Back View)
      final calfPath = Path()
        ..moveTo(15, 277)
        ..cubicTo(22, 283, 25, 298, 23, 313)
        ..cubicTo(22, 325, 18, 335, 15, 342)
        ..lineTo(11, 342)
        ..cubicTo(10, 331, 8, 316, 8, 298)
        ..cubicTo(9, 287, 12, 279, 15, 277)
        ..close();
      canvas.drawPath(calfPath, calfFill);

      // Hand (Back View - Black Fill)
      final handPath = Path()
        ..moveTo(41, 209)
        ..cubicTo(44, 213, 48, 217, 50, 221)
        ..cubicTo(52, 224, 50, 227, 47, 226)
        ..lineTo(45, 224)
        ..cubicTo(48, 232, 48, 239, 45, 244)
        ..cubicTo(44, 248, 41, 248, 40, 244)
        ..cubicTo(40, 246, 38, 245, 37, 241)
        ..cubicTo(37, 242, 34, 240, 34, 235)
        ..cubicTo(34, 227, 34, 217, 35, 206)
        ..close();
      canvas.drawPath(handPath, blackFill);

      // Feet & Achilles (Back View - Black Fill)
      final footPath = Path()
        ..moveTo(15, 342)
        ..cubicTo(17, 348, 17, 356, 15, 362)
        ..lineTo(10, 362)
        ..cubicTo(9, 355, 9, 348, 11, 342)
        ..close();
      canvas.drawPath(footPath, blackFill);

      canvas.restore();
    }

    // 2. Center Lumbar Diamond (Red) & Back Head
    final lumbarPath = Path()
      ..moveTo(0, 134)
      ..lineTo(11, 155)
      ..lineTo(0, 178)
      ..lineTo(-11, 155)
      ..close();
    canvas.drawPath(lumbarPath, lumbarFill);

    final headBackPath = Path()
      ..moveTo(0, 8)
      ..cubicTo(7, 8, 13, 14, 13, 23)
      ..cubicTo(14.5, 25, 14.5, 30, 12.5, 32)
      ..cubicTo(11.5, 36, 5.5, 41, 3.0, 42.5)
      ..lineTo(-3.0, 42.5)
      ..cubicTo(-5.5, 41, -11.5, 36, -12.5, 32)
      ..cubicTo(-14.5, 30, -14.5, 25, -13, 23)
      ..cubicTo(-13, 14, -7, 8, 0, 8)
      ..close();
    canvas.drawPath(headBackPath, blackFill);

    // 3. Crisp White Outlines and Divisions
    for (final sign in [1.0, -1.0]) {
      canvas.save();
      canvas.scale(sign, 1.0);

      // Trapezius Wing Outline
      final trapOutline = Path()
        ..moveTo(0, 44)
        ..cubicTo(7, 47, 15, 54, 22, 63)
        ..cubicTo(18, 80, 13, 104, 0, 130);
      canvas.drawPath(trapOutline, stroke);

      // Rear Delt Outline
      final rearDeltOutline = Path()
        ..moveTo(22, 63)
        ..cubicTo(31, 61, 40, 68, 40, 80)
        ..cubicTo(39, 90, 35, 98, 31, 102)
        ..cubicTo(28, 94, 24, 82, 22, 73)
        ..close();
      canvas.drawPath(rearDeltOutline, stroke);

      // Infraspinatus Outline
      final infraspinatusOutline = Path()
        ..moveTo(20, 71)
        ..lineTo(30, 78)
        ..cubicTo(31, 90, 29, 102, 28, 109)
        ..cubicTo(23, 106, 17, 101, 13, 93)
        ..close();
      canvas.drawPath(infraspinatusOutline, stroke);

      // Tricep Outline & Horseshoe Cut
      final tricepOutline = Path()
        ..moveTo(31, 102)
        ..cubicTo(38, 110, 40, 122, 38, 135)
        ..lineTo(32, 136)
        ..cubicTo(30, 124, 28, 114, 27, 109)
        ..close();
      canvas.drawPath(tricepOutline, stroke);

      final tricepCut = Path()
        ..moveTo(33, 106)
        ..cubicTo(35, 116, 35, 126, 33, 134);
      canvas.drawPath(tricepCut, thinStroke);

      // Forearm Outline & Internal Division
      final forearmOutline = Path()
        ..moveTo(31, 136)
        ..cubicTo(39, 142, 45, 157, 46, 175)
        ..cubicTo(46, 188, 43, 200, 41, 209)
        ..lineTo(35, 206)
        ..cubicTo(35, 194, 32, 177, 28, 158)
        ..cubicTo(27, 147, 28, 139, 31, 136)
        ..close();
      canvas.drawPath(forearmOutline, stroke);

      final forearmCut = Path()
        ..moveTo(36, 138)
        ..cubicTo(39, 158, 40, 182, 39, 203);
      canvas.drawPath(forearmCut, thinStroke);

      // Hand Outline
      final handOutline = Path()
        ..moveTo(41, 209)
        ..cubicTo(44, 213, 48, 217, 50, 221)
        ..cubicTo(52, 224, 50, 227, 47, 226)
        ..lineTo(45, 224)
        ..cubicTo(48, 232, 48, 239, 45, 244)
        ..cubicTo(44, 248, 41, 248, 40, 244)
        ..cubicTo(40, 246, 38, 245, 37, 241)
        ..cubicTo(37, 242, 34, 240, 34, 235)
        ..cubicTo(34, 227, 34, 217, 35, 206)
        ..close();
      canvas.drawPath(handOutline, stroke);

      // Lat Outline
      final latsOutline = Path()
        ..moveTo(26, 111)
        ..cubicTo(30, 120, 28, 137, 23, 154)
        ..cubicTo(20, 164, 16, 169, 11, 175);
      canvas.drawPath(latsOutline, stroke);

      // Glutes Outline
      final glutesOutline = Path()
        ..moveTo(0, 178)
        ..cubicTo(7, 178, 16, 182, 22, 192)
        ..cubicTo(24, 200, 24, 211, 20, 222)
        ..cubicTo(16, 228, 7, 228, 0, 226);
      canvas.drawPath(glutesOutline, stroke);

      // Hamstrings Outline & Longitudinal Division
      final hamstringsOutline = Path()
        ..moveTo(20, 222)
        ..cubicTo(23, 234, 25, 249, 24, 264)
        ..lineTo(16, 268)
        ..cubicTo(11, 264, 5, 253, 3, 230)
        ..lineTo(0, 226);
      canvas.drawPath(hamstringsOutline, stroke);

      final hamstringCut = Path()
        ..moveTo(13, 227)
        ..cubicTo(15, 240, 15, 254, 14, 266);
      canvas.drawPath(hamstringCut, thinStroke);

      // Popliteal Crease (Knee Back)
      final kneeCrease = Path()
        ..moveTo(10, 270)
        ..cubicTo(14, 273, 18, 273, 20, 270);
      canvas.drawPath(kneeCrease, stroke);

      // Calf Outline & Central Gastrocnemius Division
      final calfOutline = Path()
        ..moveTo(15, 277)
        ..cubicTo(22, 283, 25, 298, 23, 313)
        ..cubicTo(22, 325, 18, 335, 15, 342)
        ..lineTo(11, 342)
        ..cubicTo(10, 331, 8, 316, 8, 298)
        ..cubicTo(9, 287, 12, 279, 15, 277)
        ..close();
      canvas.drawPath(calfOutline, stroke);

      final gastrocnemiusCut = Path()
        ..moveTo(15, 279)
        ..cubicTo(15, 295, 14, 310, 13, 326);
      canvas.drawPath(gastrocnemiusCut, thinStroke);

      // Foot Outline
      final footOutline = Path()
        ..moveTo(15, 342)
        ..cubicTo(17, 348, 17, 356, 15, 362)
        ..lineTo(10, 362)
        ..cubicTo(9, 355, 9, 348, 11, 342)
        ..close();
      canvas.drawPath(footOutline, stroke);

      canvas.restore();
    }

    // Spine & Central Outlines
    canvas.drawPath(headBackPath, stroke);

    // C7 Vertebra White Triangle
    final c7Triangle = Path()
      ..moveTo(0, 41)
      ..lineTo(3.5, 45)
      ..lineTo(-3.5, 45)
      ..close();
    canvas.drawPath(c7Triangle, stroke);

    // Central Spine Line down Trapezius
    final spineLine = Path()
      ..moveTo(0, 45)
      ..lineTo(0, 134);
    canvas.drawPath(spineLine, stroke);

    // Lumbar Diamond Outline
    canvas.drawPath(lumbarPath, stroke);

    // Gluteal Cleft Line
    final glutealCleft = Path()
      ..moveTo(0, 178)
      ..lineTo(0, 226);
    canvas.drawPath(glutealCleft, stroke);

    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant SymmetryBodyPainter oldDelegate) {
    return oldDelegate.muscleColors != muscleColors;
  }
}
