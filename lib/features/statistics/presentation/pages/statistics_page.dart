import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/theme/app_theme.dart';
import '../../domain/entities/user_rank.dart';
import '../bloc/statistics_bloc.dart';
import '../bloc/statistics_event.dart';
import '../bloc/statistics_state.dart';
import '../widgets/rank_progress_bar.dart';
import '../widgets/muscle_heatmap_chart.dart';
import '../widgets/rank_calculator_tab_content.dart';

class StatisticsPage extends StatefulWidget {
  const StatisticsPage({super.key});

  @override
  State<StatisticsPage> createState() => _StatisticsPageState();
}

class _StatisticsPageState extends State<StatisticsPage> {
  int _selectedSubTab = 0; // 0: Proporción, 1: Calculadora
  final Set<String> _expandedMuscles = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        titleSpacing: 16,
        scrolledUnderElevation: 0,
        title: Row(
          children: [
            SvgPicture.asset(
              AppAssets.logoSvg,
              width: 24,
              height: 24,
            ),
            const SizedBox(width: 8),
            const Text(
              'Proport',
              style: TextStyle(
                fontFamily: AppTheme.fontAlbert,
                fontWeight: FontWeight.w800,
                fontSize: 24,
                letterSpacing: -0.5,
                color: Colors.white,
              ),
            ),
          ],
        ),
        actions: [
          // PRO pill badge (sleek dark titanium with amber outline)
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: AppColors.primaryAccent.withValues(alpha: 0.5),
                width: 1,
              ),
            ),
            child: const Text(
              'PRO',
              style: TextStyle(
                fontFamily: AppTheme.fontAlbert,
                fontWeight: FontWeight.w900,
                fontSize: 11,
                color: AppColors.primaryAccent,
                letterSpacing: 0.8,
              ),
            ),
          ),
          const SizedBox(width: 10),

          // Precision streak badge
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AppColors.cardBorder, width: 1),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.bolt_rounded,
                  size: 16,
                  color: AppColors.primaryAccent,
                ),
                const SizedBox(width: 4),
                Text(
                  '50',
                  style: AppTheme.mono(
                    fontWeight: FontWeight.w700,
                    fontSize: 14,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 16),
        ],
      ),
      body: Column(
        children: [
          // Top Sub-Tabs Bar: 'Proporción' | 'Calculadora'
          _buildTopSubTabsBar(),

          // Body Content
          Expanded(
            child: _selectedSubTab == 0
                ? _buildProporcionTabContent()
                : const RankCalculatorTabContent(),
          ),
        ],
      ),
    );
  }

  Widget _buildTopSubTabsBar() {
    return Column(
      children: [
        Row(
          children: [
            // Tab 0: Proporción
            Expanded(
              child: InkWell(
                onTap: () => setState(() => _selectedSubTab = 0),
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      child: Text(
                        'Proporción',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: AppTheme.fontAlbert,
                          fontWeight: _selectedSubTab == 0
                              ? FontWeight.w800
                              : FontWeight.w500,
                          fontSize: 15,
                          color: _selectedSubTab == 0
                              ? Colors.white
                              : AppColors.textMuted,
                        ),
                      ),
                    ),
                    if (_selectedSubTab == 0)
                      Container(
                        height: 2.0,
                        color: AppColors.primaryAccent,
                      )
                    else
                      const SizedBox(height: 2.0),
                  ],
                ),
              ),
            ),

            // Tab 1: Calculadora
            Expanded(
              child: InkWell(
                onTap: () => setState(() => _selectedSubTab = 1),
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      child: Text(
                        'Calculadora',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: AppTheme.fontAlbert,
                          fontWeight: _selectedSubTab == 1
                              ? FontWeight.w800
                              : FontWeight.w500,
                          fontSize: 15,
                          color: _selectedSubTab == 1
                              ? Colors.white
                              : AppColors.textMuted,
                        ),
                      ),
                    ),
                    if (_selectedSubTab == 1)
                      Container(
                        height: 2.0,
                        color: AppColors.primaryAccent,
                      )
                    else
                      const SizedBox(height: 2.0),
                  ],
                ),
              ),
            ),
          ],
        ),
        Container(
          height: 1.0,
          color: AppColors.cardBorder,
        ),
      ],
    );
  }

  Widget _buildProporcionTabContent() {
    return BlocBuilder<StatisticsBloc, StatisticsState>(
      builder: (context, state) {
        return state.when(
          initial: () => const Center(
            child: CircularProgressIndicator(color: AppColors.primaryAccent),
          ),
          loading: () => const Center(
            child: CircularProgressIndicator(color: AppColors.primaryAccent),
          ),
          error: (msg) => Center(
            child: Text(
              msg,
              style: const TextStyle(color: AppColors.textSecondary),
            ),
          ),
          loaded: (score, ranks, volumes) {
            return RefreshIndicator(
              color: AppColors.primaryAccent,
              backgroundColor: AppColors.surface,
              onRefresh: () async {
                context.read<StatisticsBloc>().add(const LoadStatisticsEvent());
              },
              child: ListView(
                padding: const EdgeInsets.only(top: 12, bottom: 28),
                children: [
                  // 1. Hero Card: 'ÍNDICE DE PROPORCIÓN' / 'PROPORT SCORE'
                  _buildIndiceProporcionHeroCard(),

                  const SizedBox(height: 16),

                  // 2. Anatomical Body Heatmap (Front & Back Views)
                  _buildAnatomicalBodyHeatmap(),

                  const SizedBox(height: 24),

                  // 3. Section 'Balance por Grupo Muscular'
                  _buildRankingsMuscularesSection(ranks: ranks),

                  const SizedBox(height: 24),

                  // 4. Volume Heatmap & Benchmarks details
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: MuscleHeatmapChart(volumes: volumes),
                  ),

                  const SizedBox(height: 24),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'BENCHMARKS Y DETALLES DE FUERZA',
                          style: TextStyle(
                            fontFamily: AppTheme.fontAlbert,
                            fontSize: 12,
                            fontWeight: FontWeight.w800,
                            color: AppColors.textMuted,
                            letterSpacing: 1.0,
                          ),
                        ),
                        Text(
                          '${ranks.length} Ejercicios',
                          style: const TextStyle(
                            fontFamily: AppTheme.fontDM,
                            fontSize: 12,
                            color: AppColors.primaryAccent,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 12),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      children: ranks
                          .map((rank) => RankProgressBar(rank: rank))
                          .toList(),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildIndiceProporcionHeroCard() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(
          color: AppColors.primaryAccent.withValues(alpha: 0.35),
          width: 1.2,
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.primaryAccent.withValues(alpha: 0.08),
            blurRadius: 24,
            spreadRadius: 0,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          width: 8,
                          height: 8,
                          decoration: const BoxDecoration(
                            color: AppColors.biometricGreen,
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: Color(0x6600E5A3),
                                blurRadius: 6,
                                spreadRadius: 1,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 8),
                        const Text(
                          'ÍNDICE DE PROPORCIÓN · PROPORT SCORE',
                          style: TextStyle(
                            fontFamily: AppTheme.fontAlbert,
                            fontWeight: FontWeight.w800,
                            fontSize: 11,
                            letterSpacing: 0.8,
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    RichText(
                      text: TextSpan(
                        text: '94.2%',
                        style: AppTheme.mono(
                          fontWeight: FontWeight.w800,
                          fontSize: 32,
                          letterSpacing: -1.0,
                          color: Colors.white,
                        ),
                        children: const [
                          TextSpan(
                            text: ' · BALANCE ÓPTIMO',
                            style: TextStyle(
                              fontFamily: AppTheme.fontAlbert,
                              fontWeight: FontWeight.w800,
                              fontSize: 13,
                              letterSpacing: 0.5,
                              color: AppColors.biometricGreen,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 6),
                    const Text(
                      'Simetría neuromuscular y ratio áureo en rango de élite',
                      style: TextStyle(
                        fontFamily: AppTheme.fontDM,
                        fontWeight: FontWeight.w400,
                        fontSize: 13,
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              // Golden ratio / Biometric gauge icon badge
              Container(
                width: 58,
                height: 58,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0x26FF8A00), Color(0x10FF5500)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: AppColors.primaryAccent.withValues(alpha: 0.5),
                    width: 1.2,
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Φ',
                      style: TextStyle(
                        fontFamily: AppTheme.fontAlbert,
                        fontWeight: FontWeight.w800,
                        fontSize: 22,
                        color: AppColors.primaryAccent,
                        height: 1.0,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      '1.618',
                      style: AppTheme.mono(
                        fontSize: 9,
                        fontWeight: FontWeight.w700,
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          // Precision Biometric Metrics Row
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: AppColors.cardBorder, width: 1),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildBiometricMetricItem(
                  label: 'Simetría Corporal',
                  value: '96.4%',
                  isPositive: true,
                ),
                Container(
                  width: 1,
                  height: 26,
                  color: AppColors.cardBorder,
                ),
                _buildBiometricMetricItem(
                  label: 'Ratio Hombro-Cintura',
                  value: '1.61 Φ',
                  isPositive: true,
                ),
                Container(
                  width: 1,
                  height: 26,
                  color: AppColors.cardBorder,
                ),
                _buildBiometricMetricItem(
                  label: 'Balance Agonista',
                  value: '91.8%',
                  isPositive: true,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBiometricMetricItem({
    required String label,
    required String value,
    required bool isPositive,
  }) {
    return Column(
      children: [
        Text(
          value,
          style: AppTheme.mono(
            fontSize: 14,
            fontWeight: FontWeight.w700,
            color: isPositive ? AppColors.biometricGreen : Colors.white,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          label,
          style: const TextStyle(
            fontFamily: AppTheme.fontDM,
            fontSize: 10,
            fontWeight: FontWeight.w500,
            color: AppColors.textMuted,
          ),
        ),
      ],
    );
  }

  Widget _buildAnatomicalBodyHeatmap() {
    return Container(
      height: 380,
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.cardBorder),
      ),
      alignment: Alignment.center,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Image.asset(
        AppAssets.symmetryRankedBodyDiagram,
        fit: BoxFit.contain,
      ),
    );
  }

  Widget _buildRankingsMuscularesSection({required List<UserRank> ranks}) {
    final categories = [
      _MuscleAccordionData(
        key: 'brazos',
        name: 'Brazos',
        subtitle: 'SIMETRÍA 92% · 3/3 CALIBRADOS',
        exercises: ranks
            .where((r) => r.exerciseName.toLowerCase().contains('curl'))
            .toList(),
      ),
      _MuscleAccordionData(
        key: 'pecho',
        name: 'Pecho',
        subtitle: 'BALANCE ÁUREO 95% · 2/2 CALIBRADOS',
        exercises: ranks
            .where((r) => r.exerciseName.toLowerCase().contains('banca'))
            .toList(),
      ),
      _MuscleAccordionData(
        key: 'espalda',
        name: 'Espalda',
        subtitle: 'RATIO TRACCIÓN 96% · 3/3 CALIBRADOS',
        exercises: ranks
            .where((r) => r.exerciseName.toLowerCase().contains('muerto'))
            .toList(),
      ),
      _MuscleAccordionData(
        key: 'piernas',
        name: 'Piernas',
        subtitle: 'EQUILIBRIO BILATERAL 94% · 4/4 CALIBRADOS',
        exercises: ranks
            .where((r) => r.exerciseName.toLowerCase().contains('sentadilla'))
            .toList(),
      ),
      _MuscleAccordionData(
        key: 'hombros',
        name: 'Hombros',
        subtitle: 'RATIO DELTOIDES 93% · 2/2 CALIBRADOS',
        exercises: ranks
            .where((r) => r.exerciseName.toLowerCase().contains('militar'))
            .toList(),
      ),
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Balance por Grupo Muscular',
            style: TextStyle(
              fontFamily: AppTheme.fontAlbert,
              fontWeight: FontWeight.w800,
              fontSize: 20,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 12),
          ...categories.map((cat) => _buildMuscleAccordionCard(cat)),
        ],
      ),
    );
  }

  Widget _buildMuscleAccordionCard(_MuscleAccordionData cat) {
    final isExpanded = _expandedMuscles.contains(cat.key);

    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.cardBorder),
      ),
      child: Column(
        children: [
          InkWell(
            onTap: () {
              setState(() {
                if (isExpanded) {
                  _expandedMuscles.remove(cat.key);
                } else {
                  _expandedMuscles.add(cat.key);
                }
              });
            },
            borderRadius: BorderRadius.circular(16),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
              child: Row(
                children: [
                  Image.asset(
                    AppAssets.symmetryMuscleHexBadge,
                    width: 44,
                    height: 44,
                    fit: BoxFit.contain,
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          cat.name,
                          style: const TextStyle(
                            fontFamily: AppTheme.fontAlbert,
                            fontWeight: FontWeight.w700,
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          cat.subtitle,
                          style: const TextStyle(
                            fontFamily: AppTheme.fontAlbert,
                            fontSize: 11,
                            fontWeight: FontWeight.w700,
                            color: AppColors.biometricGreen,
                            letterSpacing: 0.5,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Icon(
                    isExpanded
                        ? Icons.keyboard_arrow_up_rounded
                        : Icons.keyboard_arrow_down_rounded,
                    color: AppColors.textSecondary,
                    size: 24,
                  ),
                ],
              ),
            ),
          ),
          if (isExpanded) ...[
            const Divider(height: 1, color: AppColors.cardBorder),
            Padding(
              padding: const EdgeInsets.all(14),
              child: Column(
                children: cat.exercises.isNotEmpty
                    ? cat.exercises.map((ex) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 6),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Text(
                                  ex.exerciseName,
                                  style: const TextStyle(
                                    fontFamily: AppTheme.fontDM,
                                    fontSize: 13,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              Text(
                                '${ex.currentWeight.toStringAsFixed(1)} kg (${ex.ratio.toStringAsFixed(2)}x BW)',
                                style: AppTheme.mono(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.biometricGreen,
                                ),
                              ),
                            ],
                          ),
                        );
                      }).toList()
                    : [
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 4),
                          child: Text(
                            'Completa más sesiones para calibrar tu rango específico en este grupo.',
                            style: TextStyle(
                              fontFamily: AppTheme.fontDM,
                              fontSize: 12,
                              color: AppColors.textMuted,
                            ),
                          ),
                        ),
                      ],
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _MuscleAccordionData {
  final String key;
  final String name;
  final String subtitle;
  final List<UserRank> exercises;

  const _MuscleAccordionData({
    required this.key,
    required this.name,
    required this.subtitle,
    required this.exercises,
  });
}
