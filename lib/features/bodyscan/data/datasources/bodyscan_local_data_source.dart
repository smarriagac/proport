import '../models/body_measurement_model.dart';

abstract class BodyscanLocalDataSource {
  Future<List<BodyMeasurementModel>> getMeasurementHistory();
  Future<BodyMeasurementModel?> getLatestMeasurement();
  Future<BodyMeasurementModel> runSimulatedScan();
}

class BodyscanLocalDataSourceImpl implements BodyscanLocalDataSource {
  final List<BodyMeasurementModel> _history = [
    BodyMeasurementModel(
      id: 'scan_001',
      scanDate: DateTime.now().subtract(const Duration(days: 7)),
      bodyFatPercentage: 14.2,
      muscleMassKg: 67.8,
      symmetryIndex: 93.8,
      chestCm: 103.5,
      waistCm: 79.5,
      bicepsCm: 38.2,
      thighsCm: 59.5,
      calvesCm: 38.0,
      shouldersCm: 121.0,
      aiAnalysisNotes: const [
        'V-Taper index: 1.52 (Golden Ratio: 1.618)',
        'Left vs Right arm symmetry within 0.3 cm margin.',
      ],
    ),
    BodyMeasurementModel(
      id: 'scan_002',
      scanDate: DateTime.now(),
      bodyFatPercentage: 13.8,
      muscleMassKg: 68.4,
      symmetryIndex: 94.6,
      chestCm: 104.2,
      waistCm: 79.0,
      bicepsCm: 38.6,
      thighsCm: 60.1,
      calvesCm: 38.2,
      shouldersCm: 122.5,
      aiAnalysisNotes: const [
        'V-Taper index: 1.55 (Approaching Golden Ratio).',
        'Upper body lateral symmetry is in the 94th percentile.',
        'Shoulder to waist ratio improved by +1.9% over past 7 days.',
      ],
    ),
  ];

  @override
  Future<List<BodyMeasurementModel>> getMeasurementHistory() async {
    return List.unmodifiable(_history);
  }

  @override
  Future<BodyMeasurementModel?> getLatestMeasurement() async {
    return _history.isNotEmpty ? _history.last : null;
  }

  @override
  Future<BodyMeasurementModel> runSimulatedScan() async {
    await Future.delayed(const Duration(seconds: 2));
    final newScan = BodyMeasurementModel(
      id: 'scan_${DateTime.now().millisecondsSinceEpoch}',
      scanDate: DateTime.now(),
      bodyFatPercentage: 13.6,
      muscleMassKg: 68.7,
      symmetryIndex: 95.1,
      chestCm: 104.8,
      waistCm: 78.8,
      bicepsCm: 38.8,
      thighsCm: 60.4,
      calvesCm: 38.3,
      shouldersCm: 123.0,
      aiAnalysisNotes: const [
        'Fresh 3D Mesh reconstructed successfully.',
        'Symmetry index elevated to 95.1%.',
        'Hypertrophy adaptation detected in clavicular pectoralis and lateral deltoids.',
      ],
    );
    _history.add(newScan);
    return newScan;
  }
}
