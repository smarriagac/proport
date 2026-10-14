import '../entities/body_measurement.dart';

abstract class BodyscanRepository {
  Future<List<BodyMeasurement>> getMeasurementHistory();
  Future<BodyMeasurement?> getLatestMeasurement();
  Future<BodyMeasurement> runSimulatedScan();
}
