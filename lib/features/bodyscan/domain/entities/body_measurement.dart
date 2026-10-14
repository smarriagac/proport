import 'package:equatable/equatable.dart';

class BodyMeasurement extends Equatable {
  final String id;
  final DateTime scanDate;
  final double bodyFatPercentage;
  final double muscleMassKg;
  final double symmetryIndex; // 0 - 100%
  final double chestCm;
  final double waistCm;
  final double bicepsCm;
  final double thighsCm;
  final double calvesCm;
  final double shouldersCm;
  final String? frontPhotoUrl;
  final String? sidePhotoUrl;
  final List<String> aiAnalysisNotes;

  const BodyMeasurement({
    required this.id,
    required this.scanDate,
    required this.bodyFatPercentage,
    required this.muscleMassKg,
    required this.symmetryIndex,
    required this.chestCm,
    required this.waistCm,
    required this.bicepsCm,
    required this.thighsCm,
    required this.calvesCm,
    required this.shouldersCm,
    this.frontPhotoUrl,
    this.sidePhotoUrl,
    this.aiAnalysisNotes = const [],
  });

  @override
  List<Object?> get props => [
        id,
        scanDate,
        bodyFatPercentage,
        muscleMassKg,
        symmetryIndex,
        chestCm,
        waistCm,
        bicepsCm,
        thighsCm,
        calvesCm,
        shouldersCm,
        frontPhotoUrl,
        sidePhotoUrl,
        aiAnalysisNotes,
      ];
}
