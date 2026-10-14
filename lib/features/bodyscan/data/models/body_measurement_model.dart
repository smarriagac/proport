import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/body_measurement.dart';

part 'body_measurement_model.freezed.dart';
part 'body_measurement_model.g.dart';

@freezed
abstract class BodyMeasurementModel with _$BodyMeasurementModel {
  const BodyMeasurementModel._();

  const factory BodyMeasurementModel({
    required String id,
    required DateTime scanDate,
    required double bodyFatPercentage,
    required double muscleMassKg,
    required double symmetryIndex,
    required double chestCm,
    required double waistCm,
    required double bicepsCm,
    required double thighsCm,
    required double calvesCm,
    required double shouldersCm,
    String? frontPhotoUrl,
    String? sidePhotoUrl,
    @Default([]) List<String> aiAnalysisNotes,
  }) = _BodyMeasurementModel;

  factory BodyMeasurementModel.fromJson(Map<String, dynamic> json) =>
      _$BodyMeasurementModelFromJson(json);

  BodyMeasurement toDomain() {
    return BodyMeasurement(
      id: id,
      scanDate: scanDate,
      bodyFatPercentage: bodyFatPercentage,
      muscleMassKg: muscleMassKg,
      symmetryIndex: symmetryIndex,
      chestCm: chestCm,
      waistCm: waistCm,
      bicepsCm: bicepsCm,
      thighsCm: thighsCm,
      calvesCm: calvesCm,
      shouldersCm: shouldersCm,
      frontPhotoUrl: frontPhotoUrl,
      sidePhotoUrl: sidePhotoUrl,
      aiAnalysisNotes: aiAnalysisNotes,
    );
  }

  factory BodyMeasurementModel.fromDomain(BodyMeasurement domain) {
    return BodyMeasurementModel(
      id: domain.id,
      scanDate: domain.scanDate,
      bodyFatPercentage: domain.bodyFatPercentage,
      muscleMassKg: domain.muscleMassKg,
      symmetryIndex: domain.symmetryIndex,
      chestCm: domain.chestCm,
      waistCm: domain.waistCm,
      bicepsCm: domain.bicepsCm,
      thighsCm: domain.thighsCm,
      calvesCm: domain.calvesCm,
      shouldersCm: domain.shouldersCm,
      frontPhotoUrl: domain.frontPhotoUrl,
      sidePhotoUrl: domain.sidePhotoUrl,
      aiAnalysisNotes: domain.aiAnalysisNotes,
    );
  }
}
