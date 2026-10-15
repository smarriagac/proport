import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../core/di/injection.dart';
import '../core/theme/app_theme.dart';
import 'router/app_router.dart';
import '../features/training/presentation/bloc/training_bloc.dart';
import '../features/training/presentation/bloc/training_event.dart';
import '../features/intelligence/presentation/bloc/intelligence_bloc.dart';
import '../features/intelligence/presentation/bloc/intelligence_event.dart';
import '../features/statistics/presentation/bloc/statistics_bloc.dart';
import '../features/statistics/presentation/bloc/statistics_event.dart';
import '../features/bodyscan/presentation/bloc/bodyscan_bloc.dart';
import '../features/bodyscan/presentation/bloc/bodyscan_event.dart';

class SymmetryApp extends StatelessWidget {
  const SymmetryApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<TrainingBloc>(
          create: (_) => getIt<TrainingBloc>()..add(const LoadWorkoutPlansEvent()),
        ),
        BlocProvider<IntelligenceBloc>(
          create: (_) => getIt<IntelligenceBloc>()..add(const LoadChatHistoryEvent()),
        ),
        BlocProvider<StatisticsBloc>(
          create: (_) => getIt<StatisticsBloc>()..add(const LoadStatisticsEvent()),
        ),
        BlocProvider<BodyscanBloc>(
          create: (_) => getIt<BodyscanBloc>()..add(const LoadBodyscanDataEvent()),
        ),
      ],
      child: MaterialApp.router(
        title: 'Proport',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.darkTheme,
        routerConfig: appRouter,
      ),
    );
  }
}
