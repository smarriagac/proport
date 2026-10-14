import '../../domain/entities/body_measurement.dart';
import '../../domain/repositories/bodyscan_repository.dart';
import '../datasources/bodyscan_local_data_source.dart';

class BodyscanRepositoryImpl implements BodyscanRepository {
  final BodyscanLocalDataSource localDataSource;

  BodyscanRepositoryImpl(this.localDataSource);

  @override
  Future<List<BodyMeasurement>> getMeasurementHistory() async {
    final models = await localDataSource.getMeasurementHistory();
    return models.map((m) => m.toDomain()).toList();
  }

  @override
  Future<BodyMeasurement?> getLatestMeasurement() async {
    final model = await localDataSource.getLatestMeasurement();
    return model?.toDomain();
  }

  @override
  Future<BodyMeasurement> runSimulatedScan() async {
    final model = await localDataSource.runSimulatedScan();
    return model.toDomain();
  }
}
