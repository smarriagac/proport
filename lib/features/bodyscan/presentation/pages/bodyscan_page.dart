import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/constants/app_constants.dart';
import '../bloc/bodyscan_bloc.dart';
import '../bloc/bodyscan_event.dart';
import '../bloc/bodyscan_state.dart';
import '../widgets/body_silhouette_guide.dart';
import '../widgets/measurement_metric_chip.dart';

class BodyscanPage extends StatelessWidget {
  const BodyscanPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'AI Body Scanner',
          style: TextStyle(fontWeight: FontWeight.w800, fontSize: 18),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.history_rounded),
            onPressed: () {},
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: BlocBuilder<BodyscanBloc, BodyscanState>(
        builder: (context, state) {
          return state.when(
            initial: () => const Center(child: CircularProgressIndicator()),
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (msg) => Center(child: Text(msg)),
            loaded: (latest, history, isScanning) {
              return ListView(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                children: [
                  // 3D Silhouette Guide
                  BodySilhouetteGuide(
                    measurement: latest,
                    isScanning: isScanning,
                  ),
                  const SizedBox(height: 16),

                  // Scan action button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primaryBlue,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                      ),
                      onPressed: isScanning
                          ? null
                          : () {
                              context
                                  .read<BodyscanBloc>()
                                  .add(const TriggerNewScanEvent());
                            },
                      icon: isScanning
                          ? const SizedBox(
                              width: 18,
                              height: 18,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                color: Colors.white,
                              ),
                            )
                          : const Icon(Icons.camera_alt_rounded),
                      label: Text(
                        isScanning ? 'Reconstructing 3D Mesh...' : 'Start New AI Body Scan',
                        style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 15),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Key Metrics Grid
                  const Text(
                    'BODY COMPOSITION & SYMMETRY',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w800,
                      color: AppColors.textMuted,
                      letterSpacing: 1.0,
                    ),
                  ),
                  const SizedBox(height: 12),

                  GridView.count(
                    crossAxisCount: 2,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    mainAxisSpacing: 12,
                    crossAxisSpacing: 12,
                    childAspectRatio: 1.5,
                    children: [
                      MeasurementMetricChip(
                        title: 'Symmetry Index',
                        value: '${latest.symmetryIndex.toStringAsFixed(1)}%',
                        subtitle: '+0.8% this week',
                        icon: Icons.auto_awesome,
                        accentColor: AppColors.primaryBlue,
                      ),
                      MeasurementMetricChip(
                        title: 'Body Fat',
                        value: '${latest.bodyFatPercentage.toStringAsFixed(1)}%',
                        subtitle: '-0.4% lean change',
                        icon: Icons.pie_chart_outline_rounded,
                        accentColor: AppColors.accentBlue,
                      ),
                      MeasurementMetricChip(
                        title: 'Lean Mass',
                        value: '${latest.muscleMassKg.toStringAsFixed(1)} kg',
                        subtitle: '+0.6 kg hyper-trophy',
                        icon: Icons.fitness_center_rounded,
                        accentColor: AppColors.streakOrange,
                      ),
                      MeasurementMetricChip(
                        title: 'V-Taper Index',
                        value: (latest.shouldersCm / latest.waistCm).toStringAsFixed(2),
                        subtitle: 'Target: 1.618',
                        icon: Icons.architecture_rounded,
                        accentColor: AppColors.success,
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),

                  // AI Analysis Notes
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: AppColors.card,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: AppColors.cardBorder),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Row(
                          children: [
                            Icon(
                              Icons.psychology_alt_outlined,
                              color: AppColors.accentBlue,
                              size: 18,
                            ),
                            SizedBox(width: 8),
                            Text(
                              'AI BIOMECHANICAL REPORT',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w800,
                                color: AppColors.accentBlue,
                                letterSpacing: 0.8,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        ...latest.aiAnalysisNotes.map((note) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 4),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text('• ', style: TextStyle(color: AppColors.primaryBlue, fontSize: 16)),
                                Expanded(
                                  child: Text(
                                    note,
                                    style: const TextStyle(
                                      color: AppColors.textSecondary,
                                      fontSize: 13,
                                      height: 1.35,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        }),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              );
            },
          );
        },
      ),
    );
  }
}
