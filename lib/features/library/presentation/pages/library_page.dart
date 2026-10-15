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
  int _selectedChipIndex = 0; // 0: Tu plan inteligente, 1: Programas, 2: Plantillas, 3: Ejercicios

  static const List<_LibraryTemplateItem> _templates = [
    _LibraryTemplateItem(
      title: 'Domingo',
      subtitle: 'Plantilla',
      imageAsset: 'assets/images/routines/routine_domingo.png',
      exerciseAssets: [
        'assets/images/exercises/9n2149Z.gif',
        'assets/images/exercises/my33uHU.gif',
        'assets/images/exercises/fUBheHs.gif',
        'assets/images/exercises/EIeI8Vf.gif',
      ],
    ),
    _LibraryTemplateItem(
      title: 'Sábado de Tracción 🦍',
      subtitle: 'Plantilla · 8 ejercicios',
      imageAsset: 'assets/images/routines/routine_traccion.png',
      exerciseAssets: [
        'assets/images/exercises/CmEr4pM.gif',
        'assets/images/exercises/fUBheHs.gif',
        'assets/images/exercises/4dUn2iv.gif',
        'assets/images/exercises/G61cXLk.gif',
      ],
    ),
    _LibraryTemplateItem(
      title: 'Sábado de Empuje 🫣',
      subtitle: 'Plantilla · 10 ejercicios',
      imageAsset: 'assets/images/routines/routine_empuje.png',
      exerciseAssets: [
        'assets/images/exercises/5v7KYld.gif',
        'assets/images/exercises/EIeI8Vf.gif',
        'assets/images/exercises/7saC5zz.gif',
        'assets/images/exercises/2IxROQ1.gif',
      ],
    ),
    _LibraryTemplateItem(
      title: 'Pecho, Triceps',
      subtitle: 'Plantilla · 8 ejercicios',
      imageAsset: 'assets/images/routines/routine_pecho_triceps.png',
      exerciseAssets: [
        'assets/images/exercises/EIeI8Vf.gif',
        'assets/images/exercises/5v7KYld.gif',
        'assets/images/exercises/7saC5zz.gif',
        'assets/images/exercises/2IxROQ1.gif',
      ],
    ),
    _LibraryTemplateItem(
      title: 'Espalda, Biceps',
      subtitle: 'Plantilla · 7 ejercicios',
      imageAsset: 'assets/images/routines/routine_espalda_biceps.png',
      exerciseAssets: [
        'assets/images/exercises/CmEr4pM.gif',
        'assets/images/exercises/fUBheHs.gif',
        'assets/images/exercises/CmEr4pM.gif',
        'assets/images/exercises/4dUn2iv.gif',
      ],
    ),
    _LibraryTemplateItem(
      title: 'Piernas, Hombros',
      subtitle: 'Plantilla · 7 ejercicios',
      imageAsset: 'assets/images/routines/routine_piernas_hombros.png',
      exerciseAssets: [
        'assets/images/exercises/9n2149Z.gif',
        'assets/images/exercises/my33uHU.gif',
        'assets/images/exercises/znQUdHY.gif',
        'assets/images/exercises/DsgkuIt.gif',
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

          // 3. Bottom Action Card: 'Explorar programas' (authentic single card layout)
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
            // 2x2 White Card with Original Downloaded Exercise Drawings
            _buildSketchGridCard(item),
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
                      SvgPicture.asset(
                        AppAssets.iconList,
                        width: 13,
                        height: 13,
                        colorFilter: const ColorFilter.mode(
                          Color(0xFF8E8E93),
                          BlendMode.srcIn,
                        ),
                      ),
                      const SizedBox(width: 5),
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

  Widget _buildSketchGridCard(_LibraryTemplateItem item) {
    return Container(
      width: 64,
      height: 64,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      clipBehavior: Clip.antiAlias,
      child: Image.asset(
        item.imageAsset,
        fit: BoxFit.cover,
        errorBuilder: (_, __, ___) => _buildFallbackGrid(item.exerciseAssets),
      ),
    );
  }

  Widget _buildFallbackGrid(List<String> assets) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.all(4),
      child: Column(
        children: [
          Expanded(
            child: Row(
              children: [
                Expanded(child: _buildCellImage(assets[0])),
                Expanded(child: _buildCellImage(assets[1])),
              ],
            ),
          ),
          Expanded(
            child: Row(
              children: [
                Expanded(child: _buildCellImage(assets[2])),
                Expanded(child: _buildCellImage(assets[3])),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCellImage(String path) {
    return Image.asset(
      path,
      fit: BoxFit.contain,
      errorBuilder: (_, __, ___) => const SizedBox(),
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

class _LibraryTemplateItem {
  final String title;
  final String subtitle;
  final String imageAsset;
  final List<String> exerciseAssets;

  const _LibraryTemplateItem({
    required this.title,
    required this.subtitle,
    required this.imageAsset,
    required this.exerciseAssets,
  });
}
