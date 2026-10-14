import 'package:flutter/material.dart';
import '../../../../core/constants/app_constants.dart';
import '../../domain/entities/body_measurement.dart';

class BodySilhouetteGuide extends StatefulWidget {
  final BodyMeasurement measurement;
  final bool isScanning;

  const BodySilhouetteGuide({
    super.key,
    required this.measurement,
    this.isScanning = false,
  });

  @override
  State<BodySilhouetteGuide> createState() => _BodySilhouetteGuideState();
}

class _BodySilhouetteGuideState extends State<BodySilhouetteGuide>
    with SingleTickerProviderStateMixin {
  late AnimationController _scanController;

  @override
  void initState() {
    super.initState();
    _scanController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );
    if (widget.isScanning) {
      _scanController.repeat(reverse: true);
    }
  }

  @override
  void didUpdateWidget(covariant BodySilhouetteGuide oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isScanning != oldWidget.isScanning) {
      if (widget.isScanning) {
        _scanController.repeat(reverse: true);
      } else {
        _scanController.stop();
      }
    }
  }

  @override
  void dispose() {
    _scanController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 320,
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: widget.isScanning
              ? AppColors.primaryBlue
              : AppColors.cardBorder,
          width: widget.isScanning ? 1.5 : 1.0,
        ),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Background grid lines for tech look
          CustomPaint(
            size: Size.infinite,
            painter: _GridBackgroundPainter(),
          ),

          // Central Silhouette Body Icon / Art
          Opacity(
            opacity: 0.85,
            child: Icon(
              Icons.accessibility_new_rounded,
              size: 210,
              color: AppColors.accentBlue.withValues(alpha: 0.4),
            ),
          ),

          // Scanning Laser Line
          if (widget.isScanning)
            AnimatedBuilder(
              animation: _scanController,
              builder: (context, child) {
                return Positioned(
                  top: 20 + (_scanController.value * 270),
                  left: 20,
                  right: 20,
                  child: Container(
                    height: 2,
                    decoration: BoxDecoration(
                      color: AppColors.primaryBlue,
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.primaryBlue.withValues(alpha: 0.8),
                          blurRadius: 10,
                          spreadRadius: 2,
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),

          // Overlay Tag: Shoulders
          _buildMarker(
            label: 'SHOULDERS',
            value: '${widget.measurement.shouldersCm.toStringAsFixed(1)} cm',
            top: 48,
            left: 24,
          ),

          // Overlay Tag: Chest
          _buildMarker(
            label: 'CHEST',
            value: '${widget.measurement.chestCm.toStringAsFixed(1)} cm',
            top: 96,
            right: 24,
          ),

          // Overlay Tag: Arms
          _buildMarker(
            label: 'ARMS',
            value: '${widget.measurement.bicepsCm.toStringAsFixed(1)} cm',
            top: 130,
            left: 18,
          ),

          // Overlay Tag: Waist
          _buildMarker(
            label: 'WAIST',
            value: '${widget.measurement.waistCm.toStringAsFixed(1)} cm',
            top: 156,
            right: 24,
          ),

          // Overlay Tag: Thighs
          _buildMarker(
            label: 'THIGHS',
            value: '${widget.measurement.thighsCm.toStringAsFixed(1)} cm',
            top: 220,
            left: 24,
          ),

          // Overlay Tag: Calves
          _buildMarker(
            label: 'CALVES',
            value: '${widget.measurement.calvesCm.toStringAsFixed(1)} cm',
            bottom: 24,
            right: 24,
          ),
        ],
      ),
    );
  }

  Widget _buildMarker({
    required String label,
    required String value,
    double? top,
    double? bottom,
    double? left,
    double? right,
  }) {
    return Positioned(
      top: top,
      bottom: bottom,
      left: left,
      right: right,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        decoration: BoxDecoration(
          color: AppColors.card.withValues(alpha: 0.9),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: AppColors.primaryBlue.withValues(alpha: 0.5)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              label,
              style: const TextStyle(
                color: AppColors.accentBlue,
                fontSize: 9,
                fontWeight: FontWeight.w800,
                letterSpacing: 0.8,
              ),
            ),
            Text(
              value,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _GridBackgroundPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppColors.cardBorder.withValues(alpha: 0.35)
      ..strokeWidth = 0.8;

    const step = 32.0;
    for (double x = 0; x < size.width; x += step) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
    }
    for (double y = 0; y < size.height; y += step) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
