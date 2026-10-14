import 'package:get_it/get_it.dart';

// Training
import '../../features/training/data/datasources/training_local_data_source.dart';
import '../../features/training/data/repositories/training_repository_impl.dart';
import '../../features/training/domain/repositories/training_repository.dart';
import '../../features/training/domain/usecases/get_workout_plans_usecase.dart';
import '../../features/training/domain/usecases/get_exercise_catalog_usecase.dart';
import '../../features/training/domain/usecases/log_workout_session_usecase.dart';
import '../../features/training/presentation/bloc/training_bloc.dart';

// Intelligence
import '../../features/intelligence/data/datasources/intelligence_local_data_source.dart';
import '../../features/intelligence/data/repositories/intelligence_repository_impl.dart';
import '../../features/intelligence/domain/repositories/intelligence_repository.dart';
import '../../features/intelligence/domain/usecases/generate_ai_workout_usecase.dart';
import '../../features/intelligence/domain/usecases/send_chat_message_usecase.dart';
import '../../features/intelligence/presentation/bloc/intelligence_bloc.dart';

// Statistics
import '../../features/statistics/data/datasources/statistics_local_data_source.dart';
import '../../features/statistics/data/repositories/statistics_repository_impl.dart';
import '../../features/statistics/domain/repositories/statistics_repository.dart';
import '../../features/statistics/domain/usecases/get_user_ranks_usecase.dart';
import '../../features/statistics/presentation/bloc/statistics_bloc.dart';

// Bodyscan
import '../../features/bodyscan/data/datasources/bodyscan_local_data_source.dart';
import '../../features/bodyscan/data/repositories/bodyscan_repository_impl.dart';
import '../../features/bodyscan/domain/repositories/bodyscan_repository.dart';
import '../../features/bodyscan/domain/usecases/get_body_measurements_usecase.dart';
import '../../features/bodyscan/presentation/bloc/bodyscan_bloc.dart';

final getIt = GetIt.instance;

Future<void> configureDependencies() async {
  // -------------------------------------------------------------
  // Data Sources
  // -------------------------------------------------------------
  getIt.registerLazySingleton<TrainingLocalDataSource>(
    () => TrainingLocalDataSourceImpl(),
  );
  getIt.registerLazySingleton<IntelligenceLocalDataSource>(
    () => IntelligenceLocalDataSourceImpl(),
  );
  getIt.registerLazySingleton<StatisticsLocalDataSource>(
    () => StatisticsLocalDataSourceImpl(),
  );
  getIt.registerLazySingleton<BodyscanLocalDataSource>(
    () => BodyscanLocalDataSourceImpl(),
  );

  // -------------------------------------------------------------
  // Repositories
  // -------------------------------------------------------------
  getIt.registerLazySingleton<TrainingRepository>(
    () => TrainingRepositoryImpl(getIt()),
  );
  getIt.registerLazySingleton<IntelligenceRepository>(
    () => IntelligenceRepositoryImpl(getIt()),
  );
  getIt.registerLazySingleton<StatisticsRepository>(
    () => StatisticsRepositoryImpl(getIt()),
  );
  getIt.registerLazySingleton<BodyscanRepository>(
    () => BodyscanRepositoryImpl(getIt()),
  );

  // -------------------------------------------------------------
  // Use Cases
  // -------------------------------------------------------------
  getIt.registerLazySingleton(() => GetWorkoutPlansUseCase(getIt()));
  getIt.registerLazySingleton(() => GetExerciseCatalogUseCase(getIt()));
  getIt.registerLazySingleton(() => LogWorkoutSessionUseCase(getIt()));

  getIt.registerLazySingleton(() => GenerateAIWorkoutUseCase(getIt()));
  getIt.registerLazySingleton(() => SendChatMessageUseCase(getIt()));

  getIt.registerLazySingleton(() => GetUserRanksUseCase(getIt()));

  getIt.registerLazySingleton(() => GetBodyMeasurementsUseCase(getIt()));

  // -------------------------------------------------------------
  // BLoCs
  // -------------------------------------------------------------
  getIt.registerFactory(
    () => TrainingBloc(
      getWorkoutPlansUseCase: getIt(),
      logWorkoutSessionUseCase: getIt(),
    ),
  );
  getIt.registerFactory(
    () => IntelligenceBloc(
      generateAIWorkoutUseCase: getIt(),
      sendChatMessageUseCase: getIt(),
    ),
  );
  getIt.registerFactory(
    () => StatisticsBloc(
      getUserRanksUseCase: getIt(),
    ),
  );
  getIt.registerFactory(
    () => BodyscanBloc(
      getBodyMeasurementsUseCase: getIt(),
    ),
  );
}
