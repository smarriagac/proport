import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/get_user_ranks_usecase.dart';
import 'statistics_event.dart';
import 'statistics_state.dart';

class StatisticsBloc extends Bloc<StatisticsEvent, StatisticsState> {
  final GetUserRanksUseCase getUserRanksUseCase;

  StatisticsBloc({
    required this.getUserRanksUseCase,
  }) : super(const StatisticsState.initial()) {
    on<LoadStatisticsEvent>(_onLoadStatistics);
  }

  Future<void> _onLoadStatistics(
    LoadStatisticsEvent event,
    Emitter<StatisticsState> emit,
  ) async {
    emit(const StatisticsState.loading());
    try {
      final summary = await getUserRanksUseCase();
      emit(StatisticsState.loaded(
        symmetryScore: summary.symmetryScore,
        ranks: summary.ranks,
        volumes: summary.volumes,
      ));
    } catch (e) {
      emit(StatisticsState.error('Failed to load statistics: $e'));
    }
  }
}
