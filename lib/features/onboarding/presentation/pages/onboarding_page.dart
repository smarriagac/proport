import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/theme/app_theme.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  int _selectedObjectiveIndex = 0;
  int _selectedExperienceIndex = 1;

  static const List<({String title, String iconAsset})> _objectives = [
    (
      title: 'Ganar masa muscular estética',
      iconAsset: 'assets/images/onboarding/main_fitness_objective/gain_muscle.png',
    ),
    (
      title: 'Definición y pérdida de grasa',
      iconAsset: 'assets/images/onboarding/main_fitness_objective/lose_weight.svg',
    ),
    (
      title: 'Fuerza máxima y potencia',
      iconAsset: 'assets/images/onboarding/main_fitness_objective/gain_strength.svg',
    ),
    (
      title: 'Rendimiento atlético funcional',
      iconAsset: 'assets/images/onboarding/main_fitness_objective/be_more_athletic.png',
    ),
  ];

  static const List<({String title, String subtitle, String iconAsset})> _experiences = [
    (
      title: 'Principiante',
      subtitle: '0 - 1 año',
      iconAsset: 'assets/images/onboarding/training_experience/beginner.svg',
    ),
    (
      title: 'Intermedio',
      subtitle: '1 - 3 años',
      iconAsset: 'assets/images/onboarding/training_experience/intermediate.svg',
    ),
    (
      title: 'Avanzado',
      subtitle: '+3 años',
      iconAsset: 'assets/images/onboarding/training_experience/advanced.svg',
    ),
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  Future<void> _completeOnboarding() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('has_completed_onboarding', true);
    if (mounted) {
      context.go('/ranks');
    }
  }

  Widget _buildIconWidget(String asset) {
    if (asset.endsWith('.svg')) {
      return SvgPicture.asset(
        asset,
        width: 24,
        height: 24,
        fit: BoxFit.contain,
      );
    }
    return Image.asset(
      asset,
      width: 24,
      height: 24,
      fit: BoxFit.contain,
      errorBuilder: (context, error, stackTrace) => const Icon(
        Icons.fitness_center_rounded,
        color: AppColors.primaryBlue,
        size: 22,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            // Top Bar: Segmented Progress Bar + Saltar Button
            _buildTopBar(),

            // PageView with 4 authentic steps
            Expanded(
              child: PageView(
                controller: _pageController,
                physics: const ClampingScrollPhysics(),
                onPageChanged: (page) {
                  setState(() {
                    _currentPage = page;
                  });
                },
                children: [
                  _buildStep0Welcome(),
                  _buildStep1Objective(),
                  _buildStep2Experience(),
                  _buildStep3Ready(),
                ],
              ),
            ),

            // Bottom CTA Button
            _buildBottomCta(),
          ],
        ),
      ),
    );
  }

  Widget _buildTopBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      child: Row(
        children: [
          // 4 Segmented Progress Bars
          Expanded(
            child: Row(
              children: List.generate(4, (index) {
                final isFilled = index <= _currentPage;
                return Expanded(
                  child: Container(
                    height: 4,
                    margin: const EdgeInsets.symmetric(horizontal: 3),
                    decoration: BoxDecoration(
                      color: isFilled
                          ? AppColors.primaryBlue
                          : const Color(0xFF26262B),
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                );
              }),
            ),
          ),
          const SizedBox(width: 14),

          // "Saltar" button
          TextButton(
            onPressed: _completeOnboarding,
            style: TextButton.styleFrom(
              padding: EdgeInsets.zero,
              minimumSize: const Size(48, 30),
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
            child: Text(
              'Saltar',
              style: TextStyle(
                fontFamily: AppTheme.fontDM,
                fontWeight: FontWeight.w600,
                fontSize: 13,
                color: _currentPage == 3
                    ? Colors.transparent
                    : const Color(0xFF8E8E93),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Step 0: Filosofía & Bienvenida
  Widget _buildStep0Welcome() {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
      child: Column(
        children: [
          // Visual: Greek statue aesthetic
          Container(
            height: 280,
            alignment: Alignment.center,
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: [
                Image.asset(
                  'assets/images/onboarding/physiques/greek_statue_aesthetic.png',
                  height: 280,
                  fit: BoxFit.contain,
                  errorBuilder: (context, error, stackTrace) => const Icon(
                    Icons.accessibility_new_rounded,
                    size: 140,
                    color: AppColors.primaryBlue,
                  ),
                ),
                Container(
                  height: 60,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.transparent,
                        AppColors.background.withValues(alpha: 0.95),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),

          // Badge: MÉTRICAS & BIOMECÁNICA
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
            decoration: BoxDecoration(
              color: const Color(0xFF1E2F52).withValues(alpha: 0.6),
              border: Border.all(color: AppColors.accentBlue, width: 1.2),
              borderRadius: BorderRadius.circular(100),
            ),
            child: const Text(
              'MÉTRICAS & BIOMECÁNICA',
              style: TextStyle(
                fontFamily: AppTheme.fontAlbert,
                fontWeight: FontWeight.w700,
                fontSize: 11,
                letterSpacing: 1.2,
                color: AppColors.accentBlue,
              ),
            ),
          ),
          const SizedBox(height: 16),

          // Title
          const Text(
            'Entrena por proporciones, no solo por volumen',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: AppTheme.fontAlbert,
              fontWeight: FontWeight.w800,
              fontSize: 24,
              color: Colors.white,
              height: 1.2,
            ),
          ),
          const SizedBox(height: 12),

          // Description
          const Text(
            'Proport analiza la simetría muscular de tu cuerpo y programa tus entrenamientos para lograr una estética equilibrada.',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: AppTheme.fontDM,
              fontWeight: FontWeight.w400,
              fontSize: 14,
              color: Color(0xFF9E9EA7),
              height: 1.45,
            ),
          ),
        ],
      ),
    );
  }

  // Step 1: Objetivo Principal
  Widget _buildStep1Objective() {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 8),
          const Text(
            '¿Cuál es tu objetivo principal?',
            style: TextStyle(
              fontFamily: AppTheme.fontAlbert,
              fontWeight: FontWeight.w800,
              fontSize: 24,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Personalizaremos tu Proport Score y el volumen de entrenamiento.',
            style: TextStyle(
              fontFamily: AppTheme.fontDM,
              fontWeight: FontWeight.w400,
              fontSize: 14,
              color: Color(0xFF9E9EA7),
            ),
          ),
          const SizedBox(height: 24),

          ...List.generate(_objectives.length, (index) {
            final item = _objectives[index];
            final isSelected = _selectedObjectiveIndex == index;

            return GestureDetector(
              onTap: () {
                setState(() {
                  _selectedObjectiveIndex = index;
                });
              },
              child: Container(
                margin: const EdgeInsets.only(bottom: 12),
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                decoration: BoxDecoration(
                  color: const Color(0xFF141416),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: isSelected
                        ? AppColors.primaryBlue
                        : const Color(0xFF26262B),
                    width: isSelected ? 1.8 : 1.0,
                  ),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 44,
                      height: 44,
                      decoration: BoxDecoration(
                        color: const Color(0xFF1E1E22),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: const EdgeInsets.all(10),
                      child: _buildIconWidget(item.iconAsset),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Text(
                        item.title,
                        style: const TextStyle(
                          fontFamily: AppTheme.fontAlbert,
                          fontWeight: FontWeight.w700,
                          fontSize: 15,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Container(
                      width: 22,
                      height: 22,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: isSelected
                              ? AppColors.primaryBlue
                              : const Color(0xFF404048),
                          width: 1.5,
                        ),
                        color: isSelected
                            ? AppColors.primaryBlue
                            : Colors.transparent,
                      ),
                      child: isSelected
                          ? const Icon(Icons.check, size: 14, color: Colors.white)
                          : null,
                    ),
                  ],
                ),
              ),
            );
          }),
        ],
      ),
    );
  }

  // Step 2: Experiencia
  Widget _buildStep2Experience() {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 8),
          const Text(
            '¿Cuánta experiencia tienes en el gimnasio?',
            style: TextStyle(
              fontFamily: AppTheme.fontAlbert,
              fontWeight: FontWeight.w800,
              fontSize: 24,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Ajustaremos la intensidad y la progresión de tus rutinas.',
            style: TextStyle(
              fontFamily: AppTheme.fontDM,
              fontWeight: FontWeight.w400,
              fontSize: 14,
              color: Color(0xFF9E9EA7),
            ),
          ),
          const SizedBox(height: 24),

          ...List.generate(_experiences.length, (index) {
            final item = _experiences[index];
            final isSelected = _selectedExperienceIndex == index;

            return GestureDetector(
              onTap: () {
                setState(() {
                  _selectedExperienceIndex = index;
                });
              },
              child: Container(
                margin: const EdgeInsets.only(bottom: 12),
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                decoration: BoxDecoration(
                  color: const Color(0xFF141416),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: isSelected
                        ? AppColors.primaryBlue
                        : const Color(0xFF26262B),
                    width: isSelected ? 1.8 : 1.0,
                  ),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 44,
                      height: 44,
                      decoration: BoxDecoration(
                        color: const Color(0xFF1E1E22),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: const EdgeInsets.all(10),
                      child: _buildIconWidget(item.iconAsset),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            item.title,
                            style: const TextStyle(
                              fontFamily: AppTheme.fontAlbert,
                              fontWeight: FontWeight.w700,
                              fontSize: 16,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            item.subtitle,
                            style: const TextStyle(
                              fontFamily: AppTheme.fontDM,
                              fontWeight: FontWeight.w400,
                              fontSize: 13,
                              color: Color(0xFF8E8E93),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: 22,
                      height: 22,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: isSelected
                              ? AppColors.primaryBlue
                              : const Color(0xFF404048),
                          width: 1.5,
                        ),
                        color: isSelected
                            ? AppColors.primaryBlue
                            : Colors.transparent,
                      ),
                      child: isSelected
                          ? const Icon(Icons.check, size: 14, color: Colors.white)
                          : null,
                    ),
                  ],
                ),
              ),
            );
          }),
        ],
      ),
    );
  }

  // Step 3: Listo para Empezar
  Widget _buildStep3Ready() {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 8),
          const Text(
            'Tu plan Proport está listo',
            style: TextStyle(
              fontFamily: AppTheme.fontAlbert,
              fontWeight: FontWeight.w800,
              fontSize: 24,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Calcularemos tu Proport Score, mapearemos tu distribución muscular y tendrás acceso a todas tus plantillas.',
            style: TextStyle(
              fontFamily: AppTheme.fontDM,
              fontWeight: FontWeight.w400,
              fontSize: 14,
              color: Color(0xFF9E9EA7),
              height: 1.45,
            ),
          ),
          const SizedBox(height: 20),

          // Proport Summary Card
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: const Color(0xFF141416),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: const Color(0xFF26262B)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: const Color(0xFF1E2F52),
                        border: Border.all(
                          color: AppColors.accentBlue,
                          width: 1.5,
                        ),
                      ),
                      child: Center(
                        child: SvgPicture.asset(
                          AppAssets.proportLogoSvg,
                          width: 28,
                          height: 28,
                        ),
                      ),
                    ),
                    const SizedBox(width: 14),
                    const Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'PROPORT SYMMETRY ENGINE',
                            style: TextStyle(
                              fontFamily: AppTheme.fontDM,
                              fontWeight: FontWeight.w700,
                              fontSize: 11,
                              color: AppColors.primaryBlue,
                              letterSpacing: 1.2,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            'Perfil Biomecánico Listo',
                            style: TextStyle(
                              fontFamily: AppTheme.fontAlbert,
                              fontWeight: FontWeight.w800,
                              fontSize: 16,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                const Divider(color: Color(0xFF26262B), height: 1),
                const SizedBox(height: 16),
                _buildSummaryFeature(
                  Icons.auto_awesome_rounded,
                  'Proport Score Personalizado',
                ),
                const SizedBox(height: 12),
                _buildSummaryFeature(
                  Icons.pie_chart_rounded,
                  'Distribución Muscular Óptima',
                ),
                const SizedBox(height: 12),
                _buildSummaryFeature(
                  Icons.fitness_center_rounded,
                  '6 Plantillas de Entrenamiento Desbloqueadas',
                ),
                const SizedBox(height: 12),
                _buildSummaryFeature(
                  Icons.trending_up_rounded,
                  'Seguimiento Inteligente de Récords',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryFeature(IconData icon, String text) {
    return Row(
      children: [
        Icon(
          icon,
          size: 18,
          color: AppColors.emeraldGreen,
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(
              fontFamily: AppTheme.fontDM,
              fontWeight: FontWeight.w500,
              fontSize: 14,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildBottomCta() {
    final isLastStep = _currentPage == 3;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: SizedBox(
        width: double.infinity,
        height: 54,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primaryBlue,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14),
            ),
            elevation: 0,
          ),
          onPressed: () {
            if (!isLastStep) {
              _pageController.nextPage(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
              );
            } else {
              _completeOnboarding();
            }
          },
          child: Text(
            !isLastStep ? 'CONTINUAR' : 'COMENZAR AHORA',
            style: const TextStyle(
              fontFamily: AppTheme.fontAlbert,
              fontWeight: FontWeight.w800,
              fontSize: 15,
              letterSpacing: 0.5,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
