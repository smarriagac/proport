import '../entities/body_measurement.dart';
import '../repositories/bodyscan_repository.dart';

class GetBodyMeasurementsUseCase {
  final BodyscanRepository repository;

  GetBodyMeasurementsUseCase(this.repository);

  Future<BodyMeasurement?> getLatest() async {
    return await repository.getLatestMeasurement();
  }

  Future<List<BodyMeasurement>> getHistory() async {
    return await repository.getMeasurementHistory();
  }

  Future<BodyMeasurement> runScan() async {
    return await repository.runSimulatedScan();
  }
}
