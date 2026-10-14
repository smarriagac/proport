import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/get_body_measurements_usecase.dart';
import 'bodyscan_event.dart';
import 'bodyscan_state.dart';

class BodyscanBloc extends Bloc<BodyscanEvent, BodyscanState> {
  final GetBodyMeasurementsUseCase getBodyMeasurementsUseCase;

  BodyscanBloc({
    required this.getBodyMeasurementsUseCase,
  }) : super(const BodyscanState.initial()) {
    on<LoadBodyscanDataEvent>(_onLoadBodyscanData);
    on<TriggerNewScanEvent>(_onTriggerNewScan);
  }

  Future<void> _onLoadBodyscanData(
    LoadBodyscanDataEvent event,
    Emitter<BodyscanState> emit,
  ) async {
    emit(const BodyscanState.loading());
    try {
      final latest = await getBodyMeasurementsUseCase.getLatest();
      final history = await getBodyMeasurementsUseCase.getHistory();
      if (latest != null) {
        emit(BodyscanState.loaded(
          latestMeasurement: latest,
          history: history,
        ));
      } else {
        emit(const BodyscanState.error('No scan records found.'));
      }
    } catch (e) {
      emit(BodyscanState.error('Failed to load bodyscan data: $e'));
    }
  }

  Future<void> _onTriggerNewScan(
    TriggerNewScanEvent event,
    Emitter<BodyscanState> emit,
  ) async {
    await state.maybeWhen(
      loaded: (latest, history, _) async {
        emit(BodyscanState.loaded(
          latestMeasurement: latest,
          history: history,
          isScanning: true,
        ));

        try {
          final newScan = await getBodyMeasurementsUseCase.runScan();
          final updatedHistory = List.of(history)..add(newScan);
          emit(BodyscanState.loaded(
            latestMeasurement: newScan,
            history: updatedHistory,
            isScanning: false,
          ));
        } catch (e) {
          emit(BodyscanState.loaded(
            latestMeasurement: latest,
            history: history,
            isScanning: false,
          ));
        }
      },
      orElse: () async {},
    );
  }
}
