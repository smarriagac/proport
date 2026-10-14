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
  int _selectedSubTab = 0; // 0: Rangos, 1: Calculadora
  final Set<String> _expandedMuscles = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        titleSpacing: 16,
        scrolledUnderElevation: 0,
        title: Row(
          children: [
            SvgPicture.asset(
              AppAssets.logoSvg,
              width: 24,
              height: 24,
              colorFilter: const ColorFilter.mode(
                Colors.white,
                BlendMode.srcIn,
              ),
            ),
            const SizedBox(width: 8),
            const Text(
              'Symmetry',
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
          // PRO pill badge
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(14),
            ),
            child: const Text(
              'PRO',
              style: TextStyle(
                fontFamily: AppTheme.fontAlbert,
                fontWeight: FontWeight.w900,
                fontSize: 12,
                color: Colors.black,
                letterSpacing: 0.8,
              ),
            ),
          ),
          const SizedBox(width: 12),

          // Flame streak badge
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              SvgPicture.asset(
                AppAssets.streakFlameGrey,
                width: 18,
                height: 18,
              ),
              const SizedBox(width: 4),
              const Text(
                '50',
                style: TextStyle(
                  fontFamily: AppTheme.fontMono,
                  fontWeight: FontWeight.w700,
                  fontSize: 16,
                  color: Color(0xFFD1D1D6),
                ),
              ),
            ],
          ),
          const SizedBox(width: 16),
        ],
      ),
      body: Column(
        children: [
          // Top Sub-Tabs Bar: 'Rangos' | 'Calculadora'
          _buildTopSubTabsBar(),

          // Body Content
          Expanded(
            child: _selectedSubTab == 0
                ? _buildRangosTabContent()
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
            // Tab 0: Rangos
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
                        'Rangos',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: AppTheme.fontAlbert,
                          fontWeight: _selectedSubTab == 0
                              ? FontWeight.w700
                              : FontWeight.w500,
                          fontSize: 15,
                          color: _selectedSubTab == 0
                              ? Colors.white
                              : const Color(0xFF8E8E93),
                        ),
                      ),
                    ),
                    if (_selectedSubTab == 0)
                      Container(
                        height: 2.0,
                        color: Colors.white,
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
                              ? FontWeight.w700
                              : FontWeight.w500,
                          fontSize: 15,
                          color: _selectedSubTab == 1
                              ? Colors.white
                              : const Color(0xFF8E8E93),
                        ),
                      ),
                    ),
                    if (_selectedSubTab == 1)
                      Container(
                        height: 2.0,
                        color: Colors.white,
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
          color: const Color(0xFF1E1E22),
        ),
      ],
    );
  }

  Widget _buildRangosTabContent() {
    return BlocBuilder<StatisticsBloc, StatisticsState>(
      builder: (context, state) {
        return state.when(
          initial: () => const Center(
            child: CircularProgressIndicator(color: AppColors.primaryBlue),
          ),
          loading: () => const Center(
            child: CircularProgressIndicator(color: AppColors.primaryBlue),
          ),
          error: (msg) => Center(
            child: Text(
              msg,
              style: const TextStyle(color: AppColors.textSecondary),
            ),
          ),
          loaded: (score, ranks, volumes) {
            return RefreshIndicator(
              color: AppColors.primaryBlue,
              backgroundColor: AppColors.surface,
              onRefresh: () async {
                context.read<StatisticsBloc>().add(const LoadStatisticsEvent());
              },
              child: ListView(
                padding: const EdgeInsets.only(top: 8, bottom: 24),
                children: [
                  // 1. 'RANGO SYMMETRY' Gold Card
                  _buildRangoSymmetryGoldCard(),

                  const SizedBox(height: 16),

                  // 2. Anatomical Body Heatmap (Front & Back Views)
                  _buildAnatomicalBodyHeatmap(),

                  const SizedBox(height: 24),

                  // 3. Section 'Rankings Musculares'
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
                            color: AppColors.accentBlue,
                            fontWeight: FontWeight.w600,
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

  Widget _buildRangoSymmetryGoldCard() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
      decoration: BoxDecoration(
        color: const Color(0xFF131315),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: const Color(0xFFE5A93C),
          width: 1.2,
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'RANGO SYMMETRY',
                      style: TextStyle(
                        fontFamily: AppTheme.fontAlbert,
                        fontWeight: FontWeight.w700,
                        fontSize: 11,
                        letterSpacing: 0.8,
                        color: Color(0xFF8E8E93),
                      ),
                    ),
                    SizedBox(width: 4),
                    Icon(
                      Icons.info_outline_rounded,
                      size: 14,
                      color: Color(0xFF8E8E93),
                    ),
                  ],
                ),
                SizedBox(height: 4),
                Text(
                  'ORO III',
                  style: TextStyle(
                    fontFamily: AppTheme.fontAlbert,
                    fontWeight: FontWeight.w900,
                    fontSize: 32,
                    color: Color(0xFFF5A623),
                    letterSpacing: -0.5,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  'Eres parte del top 35% más fuerte',
                  style: TextStyle(
                    fontFamily: AppTheme.fontDM,
                    fontWeight: FontWeight.w500,
                    fontSize: 13,
                    color: Color(0xFFE5A93C),
                  ),
                ),
              ],
            ),
          ),
          Image.asset(
            AppAssets.symmetryGold3WingsBadge,
            width: 72,
            height: 72,
            fit: BoxFit.contain,
          ),
        ],
      ),
    );
  }

  Widget _buildAnatomicalBodyHeatmap() {
    return Container(
      height: 380,
      width: double.infinity,
      color: Colors.black,
      alignment: Alignment.center,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
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
        subtitle: 'PLATA III · 3/3',
        exercises: ranks
            .where((r) => r.exerciseName.toLowerCase().contains('curl'))
            .toList(),
      ),
      _MuscleAccordionData(
        key: 'pecho',
        name: 'Pecho',
        subtitle: 'ORO II · 2/2',
        exercises: ranks
            .where((r) => r.exerciseName.toLowerCase().contains('banca'))
            .toList(),
      ),
      _MuscleAccordionData(
        key: 'espalda',
        name: 'Espalda',
        subtitle: 'ORO III · 3/3',
        exercises: ranks
            .where((r) => r.exerciseName.toLowerCase().contains('muerto'))
            .toList(),
      ),
      _MuscleAccordionData(
        key: 'piernas',
        name: 'Piernas',
        subtitle: 'ORO I · 4/4',
        exercises: ranks
            .where((r) => r.exerciseName.toLowerCase().contains('sentadilla'))
            .toList(),
      ),
      _MuscleAccordionData(
        key: 'hombros',
        name: 'Hombros',
        subtitle: 'PLATA II · 2/2',
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
            'Rankings Musculares',
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
        color: const Color(0xFF141416),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFF26262B)),
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
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF8E8E93),
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
                    color: const Color(0xFF8E8E93),
                    size: 24,
                  ),
                ],
              ),
            ),
          ),
          if (isExpanded) ...[
            const Divider(height: 1, color: Color(0xFF26262B)),
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
                                  color: AppColors.accentBlue,
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
                              color: Color(0xFF8E8E93),
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
