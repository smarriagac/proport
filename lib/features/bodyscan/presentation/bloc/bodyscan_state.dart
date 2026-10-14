import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/body_measurement.dart';

part 'bodyscan_state.freezed.dart';

@freezed
class BodyscanState with _$BodyscanState {
  const factory BodyscanState.initial() = _Initial;
  const factory BodyscanState.loading() = _Loading;
  const factory BodyscanState.loaded({
    required BodyMeasurement latestMeasurement,
    required List<BodyMeasurement> history,
    @Default(false) bool isScanning,
  }) = _Loaded;
  const factory BodyscanState.error(String message) = _Error;
}
