import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/theme/app_theme.dart';

class LibraryPage extends StatefulWidget {
  const LibraryPage({super.key});

  @override
  State<LibraryPage> createState() => _LibraryPageState();
}

class _LibraryPageState extends State<LibraryPage> {
  int _selectedChipIndex = 1; // 0: Tu plan inteligente, 1: Programas, 2: Plantillas, 3: Ejercicios

  static const List<_LibraryTemplateItem> _templates = [
    _LibraryTemplateItem(
      title: 'Domingo',
      subtitle: 'Plantilla',
      sketchTypes: [
        _SketchType.legPress,
        _SketchType.legExtension,
        _SketchType.seatedRow,
        _SketchType.chestPress,
      ],
    ),
    _LibraryTemplateItem(
      title: 'Sábado de Tracción 🦍',
      subtitle: 'Plantilla · 8 ejercicios',
      sketchTypes: [
        _SketchType.latPulldown,
        _SketchType.seatedRow,
        _SketchType.bicepCurl,
        _SketchType.shoulderPress,
      ],
    ),
    _LibraryTemplateItem(
      title: 'Sábado de Empuje 😤',
      subtitle: 'Plantilla · 10 ejercicios',
      sketchTypes: [
        _SketchType.inclineBench,
        _SketchType.flatBench,
        _SketchType.cableFly,
        _SketchType.tricepPushdown,
      ],
    ),
    _LibraryTemplateItem(
      title: 'Pecho, Triceps',
      subtitle: 'Plantilla · 8 ejercicios',
      sketchTypes: [
        _SketchType.flatBench,
        _SketchType.inclineBench,
        _SketchType.cableFly,
        _SketchType.tricepPushdown,
      ],
    ),
    _LibraryTemplateItem(
      title: 'Espalda, Biceps',
      subtitle: 'Plantilla · 7 ejercicios',
      sketchTypes: [
        _SketchType.latPulldown,
        _SketchType.seatedRow,
        _SketchType.latPulldown,
        _SketchType.bicepCurl,
      ],
    ),
    _LibraryTemplateItem(
      title: 'Piernas, Hombros',
      subtitle: 'Plantilla · 7 ejercicios',
      sketchTypes: [
        _SketchType.legPress,
        _SketchType.legExtension,
        _SketchType.shoulderPress,
        _SketchType.legPress,
      ],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        scrolledUnderElevation: 0,
        titleSpacing: 16,
        leadingWidth: 54,
        leading: const Padding(
          padding: EdgeInsets.only(left: 16),
          child: Center(
            child: CircleAvatar(
              radius: 19,
              backgroundColor: Color(0xFF222226),
              child: Icon(
                Icons.person,
                color: Colors.white,
                size: 22,
              ),
            ),
          ),
        ),
        title: const Text(
          'Mi biblioteca',
          style: TextStyle(
            fontFamily: AppTheme.fontAlbert,
            fontWeight: FontWeight.w800,
            fontSize: 24,
            letterSpacing: -0.5,
            color: Colors.white,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.search_rounded,
              color: Colors.white,
              size: 26,
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.add_rounded,
              color: Colors.white,
              size: 30,
            ),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: CustomScrollView(
        slivers: [
          // 1. Horizontal Category Chips Row
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.only(top: 8, bottom: 12),
              child: _buildCategoryChips(),
            ),
          ),

          // 2. Workout Templates List
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                final template = _templates[index];
                return _buildTemplateTile(template);
              },
              childCount: _templates.length,
            ),
          ),

          const SliverToBoxAdapter(child: SizedBox(height: 16)),

          // 3. Bottom Action Cards: 'Explorar programas' & 'Crear programa'
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  _buildBottomActionCard(
                    title: 'Explorar programas',
                    subtitle: 'Elige de entre 80+ programas distintos',
                    svgAsset: AppAssets.libraryExplorePrograms,
                    onTap: () {},
                  ),
                  const SizedBox(height: 12),
                  _buildBottomActionCard(
                    title: 'Crear programa',
                    subtitle: 'Arma tu plan para seguir semanalmente',
                    svgAsset: AppAssets.libraryCreateProgram,
                    onTap: () {},
                  ),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryChips() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          // Chip 0: Tu plan inteligente (gradient sheen border)
          InkWell(
            onTap: () => setState(() => _selectedChipIndex = 0),
            borderRadius: BorderRadius.circular(22),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              decoration: BoxDecoration(
                color: const Color(0xFF161618),
                borderRadius: BorderRadius.circular(22),
                border: Border.all(
                  color: _selectedChipIndex == 0
                      ? const Color(0xFF8B5CF6)
                      : const Color(0x668B5CF6),
                  width: 1.2,
                ),
                boxShadow: _selectedChipIndex == 0
                    ? const [
                        BoxShadow(
                          color: Color(0x4D8B5CF6),
                          blurRadius: 10,
                          spreadRadius: 1,
                        ),
                      ]
                    : null,
              ),
              child: const Text(
                'Tu plan inteligente',
                style: TextStyle(
                  fontFamily: AppTheme.fontAlbert,
                  fontWeight: FontWeight.w700,
                  fontSize: 13,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          const SizedBox(width: 8),

          // Chip 1: Programas
          _buildPillChip(
            title: 'Programas',
            isSelected: _selectedChipIndex == 1,
            onTap: () => setState(() => _selectedChipIndex = 1),
          ),
          const SizedBox(width: 8),

          // Chip 2: Plantillas
          _buildPillChip(
            title: 'Plantillas',
            isSelected: _selectedChipIndex == 2,
            onTap: () => setState(() => _selectedChipIndex = 2),
          ),
          const SizedBox(width: 8),

          // Chip 3: Ejercicios
          _buildPillChip(
            title: 'Ejercicios',
            isSelected: _selectedChipIndex == 3,
            onTap: () => setState(() => _selectedChipIndex = 3),
          ),
        ],
      ),
    );
  }

  Widget _buildPillChip({
    required String title,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(22),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF2A2A2E) : const Color(0xFF161618),
          borderRadius: BorderRadius.circular(22),
          border: Border.all(
            color: isSelected ? const Color(0xFF38383E) : const Color(0xFF222225),
            width: 1.0,
          ),
        ),
        child: Text(
          title,
          style: TextStyle(
            fontFamily: AppTheme.fontAlbert,
            fontWeight: FontWeight.w700,
            fontSize: 13,
            color: isSelected ? Colors.white : const Color(0xFF9E9EA7),
          ),
        ),
      ),
    );
  }

  Widget _buildTemplateTile(_LibraryTemplateItem item) {
    return InkWell(
      onTap: () {},
      splashColor: Colors.transparent,
      highlightColor: const Color(0xFF1A1A1D),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        child: Row(
          children: [
            // 2x2 White Sketch Card
            _buildSketchGridCard(item.sketchTypes),
            const SizedBox(width: 16),

            // Title & Subtitle
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.title,
                    style: const TextStyle(
                      fontFamily: AppTheme.fontAlbert,
                      fontWeight: FontWeight.w800,
                      fontSize: 17,
                      color: Colors.white,
                      letterSpacing: -0.2,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      const Icon(
                        Icons.edit_note_rounded,
                        size: 16,
                        color: Color(0xFF8E8E93),
                      ),
                      const SizedBox(width: 4),
                      Text(
                        item.subtitle,
                        style: const TextStyle(
                          fontFamily: AppTheme.fontDM,
                          fontWeight: FontWeight.w500,
                          fontSize: 13,
                          color: Color(0xFF8E8E93),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSketchGridCard(List<_SketchType> types) {
    return Container(
      width: 66,
      height: 66,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: const [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      padding: const EdgeInsets.all(4),
      child: Column(
        children: [
          Expanded(
            child: Row(
              children: [
                Expanded(child: _buildMiniSketchTile(types[0])),
                Expanded(child: _buildMiniSketchTile(types[1])),
              ],
            ),
          ),
          Expanded(
            child: Row(
              children: [
                Expanded(child: _buildMiniSketchTile(types[2])),
                Expanded(child: _buildMiniSketchTile(types[3])),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMiniSketchTile(_SketchType type) {
    return CustomPaint(
      size: const Size(28, 28),
      painter: _MiniExerciseSketchPainter(type: type),
    );
  }

  Widget _buildBottomActionCard({
    required String title,
    required String subtitle,
    required String svgAsset,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        height: 74,
        padding: const EdgeInsets.symmetric(horizontal: 14),
        decoration: BoxDecoration(
          color: const Color(0xFF141416),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: const Color(0xFF222225),
            width: 1.0,
          ),
        ),
        child: Row(
          children: [
            // Dark icon container
            Container(
              width: 52,
              height: 52,
              decoration: BoxDecoration(
                color: const Color(0xFF1B1B1E),
                borderRadius: BorderRadius.circular(14),
                border: Border.all(
                  color: const Color(0xFF2A2A2E),
                  width: 0.8,
                ),
              ),
              alignment: Alignment.center,
              child: SvgPicture.asset(
                svgAsset,
                width: 26,
                height: 26,
                colorFilter: const ColorFilter.mode(
                  Colors.white,
                  BlendMode.srcIn,
                ),
              ),
            ),
            const SizedBox(width: 14),

            // Texts
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontFamily: AppTheme.fontAlbert,
                      fontWeight: FontWeight.w800,
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      fontFamily: AppTheme.fontDM,
                      fontWeight: FontWeight.w500,
                      fontSize: 13,
                      color: Color(0xFF8E8E93),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

enum _SketchType {
  chestPress,
  latPulldown,
  seatedRow,
  inclineBench,
  flatBench,
  cableFly,
  tricepPushdown,
  legPress,
  legExtension,
  shoulderPress,
  bicepCurl,
}

class _LibraryTemplateItem {
  final String title;
  final String subtitle;
  final List<_SketchType> sketchTypes;

  const _LibraryTemplateItem({
    required this.title,
    required this.subtitle,
    required this.sketchTypes,
  });
}

/// CustomPainter that draws authentic exercise sketches matching the Symmetry UI:
/// gym equipment frame (grey), seated/standing figure (charcoal), and red active muscle accent.
class _MiniExerciseSketchPainter extends CustomPainter {
  final _SketchType type;

  const _MiniExerciseSketchPainter({required this.type});

  @override
  void paint(Canvas canvas, Size size) {
    final framePaint = Paint()
      ..color = const Color(0xFF888890)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0
      ..strokeCap = StrokeCap.round;

    final bodyPaint = Paint()
      ..color = const Color(0xFF202024)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.6
      ..strokeCap = StrokeCap.round;

    final musclePaint = Paint()
      ..color = const Color(0xFFE53935)
      ..style = PaintingStyle.fill;

    final w = size.width;
    final h = size.height;

    switch (type) {
      case _SketchType.chestPress:
        // Chest press machine
        canvas.drawLine(Offset(w * 0.3, h * 0.35), Offset(w * 0.3, h * 0.75), framePaint);
        canvas.drawCircle(Offset(w * 0.45, h * 0.35), 2.2, bodyPaint);
        canvas.drawLine(Offset(w * 0.45, h * 0.42), Offset(w * 0.45, h * 0.75), bodyPaint);
        canvas.drawLine(Offset(w * 0.45, h * 0.5), Offset(w * 0.75, h * 0.5), bodyPaint);
        canvas.drawCircle(Offset(w * 0.5, h * 0.5), 2.0, musclePaint);
        break;

      case _SketchType.latPulldown:
        // Overhead tower
        canvas.drawLine(Offset(w * 0.5, 2), Offset(w * 0.5, h - 2), framePaint);
        canvas.drawLine(Offset(w * 0.2, 2), Offset(w * 0.8, 2), framePaint);
        // Seated figure
        canvas.drawCircle(Offset(w * 0.5, h * 0.35), 2.2, bodyPaint);
        canvas.drawLine(Offset(w * 0.5, h * 0.42), Offset(w * 0.5, h * 0.7), bodyPaint);
        // Arms pulling bar
        canvas.drawLine(Offset(w * 0.3, 3), Offset(w * 0.5, h * 0.5), bodyPaint);
        canvas.drawLine(Offset(w * 0.7, 3), Offset(w * 0.5, h * 0.5), bodyPaint);
        // Red Back accent
        canvas.drawCircle(Offset(w * 0.5, h * 0.52), 2.0, musclePaint);
        break;

      case _SketchType.seatedRow:
        // Seat and cable
        canvas.drawLine(Offset(w * 0.2, h * 0.7), Offset(w * 0.8, h * 0.7), framePaint);
        canvas.drawLine(Offset(w * 0.8, h * 0.3), Offset(w * 0.8, h * 0.7), framePaint);
        // Seated figure pulling
        canvas.drawCircle(Offset(w * 0.35, h * 0.4), 2.2, bodyPaint);
        canvas.drawLine(Offset(w * 0.35, h * 0.48), Offset(w * 0.35, h * 0.7), bodyPaint);
        canvas.drawLine(Offset(w * 0.35, h * 0.55), Offset(w * 0.65, h * 0.55), bodyPaint);
        // Red back
        canvas.drawCircle(Offset(w * 0.35, h * 0.55), 2.0, musclePaint);
        break;

      case _SketchType.inclineBench:
        // Incline bench
        canvas.drawLine(Offset(w * 0.2, h * 0.8), Offset(w * 0.7, h * 0.3), framePaint);
        // Figure
        canvas.drawCircle(Offset(w * 0.6, h * 0.25), 2.2, bodyPaint);
        canvas.drawLine(Offset(w * 0.55, h * 0.32), Offset(w * 0.3, h * 0.7), bodyPaint);
        // Barbell press
        canvas.drawLine(Offset(w * 0.25, h * 0.2), Offset(w * 0.65, h * 0.2), framePaint);
        canvas.drawLine(Offset(w * 0.45, h * 0.4), Offset(w * 0.45, h * 0.2), bodyPaint);
        // Red chest
        canvas.drawCircle(Offset(w * 0.48, h * 0.38), 2.0, musclePaint);
        break;

      case _SketchType.flatBench:
        // Flat bench
        canvas.drawLine(Offset(w * 0.2, h * 0.65), Offset(w * 0.8, h * 0.65), framePaint);
        // Figure lying
        canvas.drawCircle(Offset(w * 0.25, h * 0.55), 2.2, bodyPaint);
        canvas.drawLine(Offset(w * 0.32, h * 0.58), Offset(w * 0.75, h * 0.58), bodyPaint);
        // Pressing arms
        canvas.drawLine(Offset(w * 0.48, h * 0.58), Offset(w * 0.48, h * 0.3), bodyPaint);
        canvas.drawLine(Offset(w * 0.3, h * 0.3), Offset(w * 0.66, h * 0.3), framePaint);
        // Red chest
        canvas.drawCircle(Offset(w * 0.45, h * 0.55), 2.0, musclePaint);
        break;

      case _SketchType.cableFly:
        // Crossover cables
        canvas.drawLine(Offset(w * 0.1, 2), Offset(w * 0.1, h - 2), framePaint);
        canvas.drawLine(Offset(w * 0.9, 2), Offset(w * 0.9, h - 2), framePaint);
        // Standing figure
        canvas.drawCircle(Offset(w * 0.5, h * 0.3), 2.2, bodyPaint);
        canvas.drawLine(Offset(w * 0.5, h * 0.38), Offset(w * 0.5, h * 0.8), bodyPaint);
        // Hugging cables
        canvas.drawLine(Offset(w * 0.15, h * 0.35), Offset(w * 0.5, h * 0.5), bodyPaint);
        canvas.drawLine(Offset(w * 0.85, h * 0.35), Offset(w * 0.5, h * 0.5), bodyPaint);
        // Red chest
        canvas.drawCircle(Offset(w * 0.5, h * 0.45), 2.0, musclePaint);
        break;

      case _SketchType.tricepPushdown:
        // Cable machine
        canvas.drawLine(Offset(w * 0.5, 2), Offset(w * 0.5, h * 0.3), framePaint);
        // Figure
        canvas.drawCircle(Offset(w * 0.35, h * 0.3), 2.2, bodyPaint);
        canvas.drawLine(Offset(w * 0.35, h * 0.38), Offset(w * 0.35, h * 0.8), bodyPaint);
        // Arms down
        canvas.drawLine(Offset(w * 0.35, h * 0.45), Offset(w * 0.5, h * 0.6), bodyPaint);
        // Red triceps
        canvas.drawCircle(Offset(w * 0.4, h * 0.48), 1.8, musclePaint);
        break;

      case _SketchType.legPress:
        // 45° angled sled
        canvas.drawLine(Offset(w * 0.2, h * 0.8), Offset(w * 0.8, h * 0.2), framePaint);
        // Seated figure
        canvas.drawCircle(Offset(w * 0.3, h * 0.65), 2.2, bodyPaint);
        canvas.drawLine(Offset(w * 0.3, h * 0.72), Offset(w * 0.55, h * 0.45), bodyPaint);
        // Red quads
        canvas.drawCircle(Offset(w * 0.45, h * 0.55), 2.2, musclePaint);
        break;

      case _SketchType.legExtension:
        // Seated machine
        canvas.drawLine(Offset(w * 0.3, h * 0.6), Offset(w * 0.7, h * 0.6), framePaint);
        canvas.drawLine(Offset(w * 0.3, h * 0.3), Offset(w * 0.3, h * 0.6), framePaint);
        // Figure kicking out
        canvas.drawCircle(Offset(w * 0.35, h * 0.35), 2.2, bodyPaint);
        canvas.drawLine(Offset(w * 0.35, h * 0.42), Offset(w * 0.55, h * 0.6), bodyPaint);
        canvas.drawLine(Offset(w * 0.55, h * 0.6), Offset(w * 0.75, h * 0.6), bodyPaint);
        // Red quads
        canvas.drawCircle(Offset(w * 0.5, h * 0.55), 2.2, musclePaint);
        break;

      case _SketchType.shoulderPress:
        // Bench
        canvas.drawLine(Offset(w * 0.4, h * 0.4), Offset(w * 0.4, h * 0.8), framePaint);
        // Seated figure
        canvas.drawCircle(Offset(w * 0.5, h * 0.3), 2.2, bodyPaint);
        canvas.drawLine(Offset(w * 0.5, h * 0.38), Offset(w * 0.5, h * 0.75), bodyPaint);
        // Dumbbells overhead
        canvas.drawLine(Offset(w * 0.5, h * 0.45), Offset(w * 0.3, h * 0.2), bodyPaint);
        canvas.drawLine(Offset(w * 0.5, h * 0.45), Offset(w * 0.7, h * 0.2), bodyPaint);
        // Red shoulders
        canvas.drawCircle(Offset(w * 0.38, h * 0.38), 1.8, musclePaint);
        canvas.drawCircle(Offset(w * 0.62, h * 0.38), 1.8, musclePaint);
        break;

      case _SketchType.bicepCurl:
        // Standing figure
        canvas.drawCircle(Offset(w * 0.5, h * 0.25), 2.2, bodyPaint);
        canvas.drawLine(Offset(w * 0.5, h * 0.33), Offset(w * 0.5, h * 0.8), bodyPaint);
        // Curling arm
        canvas.drawLine(Offset(w * 0.5, h * 0.4), Offset(w * 0.65, h * 0.5), bodyPaint);
        canvas.drawLine(Offset(w * 0.65, h * 0.5), Offset(w * 0.55, h * 0.38), bodyPaint);
        // Red bicep
        canvas.drawCircle(Offset(w * 0.6, h * 0.45), 2.0, musclePaint);
        break;
    }
  }

  @override
  bool shouldRepaint(covariant _MiniExerciseSketchPainter oldDelegate) =>
      oldDelegate.type != type;
}
