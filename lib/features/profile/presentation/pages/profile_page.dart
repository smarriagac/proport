import 'package:flutter/material.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/theme/app_theme.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  int _selectedSubTab = 0; // 0: Workouts (Dumbbell), 1: Analytics (Chart)

  static const List<_WorkoutHistoryCardData> _historyCards = [
    _WorkoutHistoryCardData(
      date: 'Ayer',
      duration: '3h',
      assetImage: AppAssets.workoutBody0,
    ),
    _WorkoutHistoryCardData(
      date: '11/10',
      duration: '1h53m',
      assetImage: AppAssets.workoutBody1,
    ),
    _WorkoutHistoryCardData(
      date: '10/10',
      duration: '1h38m',
      assetImage: AppAssets.workoutBody2,
    ),
    _WorkoutHistoryCardData(
      date: '09/10',
      duration: '1h39m',
      assetImage: AppAssets.workoutBody3,
    ),
    _WorkoutHistoryCardData(
      date: '08/10',
      duration: '1h41m',
      assetImage: AppAssets.workoutBody4,
    ),
    _WorkoutHistoryCardData(
      date: '07/10',
      duration: '1h43m',
      assetImage: AppAssets.workoutBody5,
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
        title: const Text(
          '@smarriagac',
          style: TextStyle(
            fontFamily: AppTheme.fontAlbert,
            fontWeight: FontWeight.w700,
            fontSize: 18,
            color: Colors.white,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.ios_share,
              color: Colors.white,
              size: 22,
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.person_add_outlined,
              color: Colors.white,
              size: 24,
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.settings_outlined,
              color: Colors.white,
              size: 24,
            ),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: CustomScrollView(
        slivers: [
          // 1. Profile Stats Header
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: _buildProfileStatsHeader(),
            ),
          ),

          const SliverToBoxAdapter(child: SizedBox(height: 16)),

          // 2. Action Buttons: [ Escaneo ] and [ Peso ]
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: _buildActionButtons(),
            ),
          ),

          const SliverToBoxAdapter(child: SizedBox(height: 16)),

          // 3. Sub-Tabs Bar: Dumbbell & Chart
          SliverToBoxAdapter(
            child: _buildSubTabsBar(),
          ),

          // 4. Workout History Grid
          SliverPadding(
            padding: const EdgeInsets.all(12),
            sliver: SliverGrid(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
                childAspectRatio: 0.62,
              ),
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  final card = _historyCards[index % _historyCards.length];
                  return _buildWorkoutGridCard(card);
                },
                childCount: _historyCards.length,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileStatsHeader() {
    return Row(
      children: [
        // Circular Avatar
        const CircleAvatar(
          radius: 40,
          backgroundColor: Color(0xFF1E1E22),
          child: Icon(
            Icons.person,
            size: 46,
            color: Color(0xFF5A5A62),
          ),
        ),
        const SizedBox(width: 20),

        // User Handle and 3 Stats
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'smarriagac',
                style: TextStyle(
                  fontFamily: AppTheme.fontAlbert,
                  fontWeight: FontWeight.w800,
                  fontSize: 20,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildStatColumn(count: '133', label: 'Entrenos'),
                  _buildStatColumn(count: '1', label: 'Seguidores'),
                  _buildStatColumn(count: '1', label: 'Siguiendo'),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildStatColumn({required String count, required String label}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          count,
          style: const TextStyle(
            fontFamily: AppTheme.fontAlbert,
            fontWeight: FontWeight.w800,
            fontSize: 17,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          label,
          style: const TextStyle(
            fontFamily: AppTheme.fontDM,
            fontWeight: FontWeight.w500,
            fontSize: 12,
            color: Color(0xFF8E8E93),
          ),
        ),
      ],
    );
  }

  Widget _buildActionButtons() {
    return Row(
      children: [
        // Left Button: Escaneo
        Expanded(
          child: Container(
            height: 54,
            decoration: BoxDecoration(
              color: const Color(0xFF141416),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: const Color(0xFF26262B),
                width: 1.0,
              ),
            ),
            child: InkWell(
              onTap: () {},
              borderRadius: BorderRadius.circular(16),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.crop_free_rounded,
                    color: Colors.white,
                    size: 22,
                  ),
                  SizedBox(width: 10),
                  Text(
                    'Escaneo',
                    style: TextStyle(
                      fontFamily: AppTheme.fontAlbert,
                      fontWeight: FontWeight.w700,
                      fontSize: 15,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(width: 12),

        // Right Button: Peso
        Expanded(
          child: Container(
            height: 54,
            decoration: BoxDecoration(
              color: const Color(0xFF141416),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: const Color(0xFF26262B),
                width: 1.0,
              ),
            ),
            child: InkWell(
              onTap: () {},
              borderRadius: BorderRadius.circular(16),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.scale_outlined,
                    color: Colors.white,
                    size: 22,
                  ),
                  SizedBox(width: 10),
                  Text(
                    'Peso',
                    style: TextStyle(
                      fontFamily: AppTheme.fontAlbert,
                      fontWeight: FontWeight.w700,
                      fontSize: 15,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSubTabsBar() {
    return Column(
      children: [
        Row(
          children: [
            // SubTab 0: Dumbbell Icon
            Expanded(
              child: InkWell(
                onTap: () => setState(() => _selectedSubTab = 0),
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      child: Icon(
                        Icons.fitness_center_rounded,
                        color: _selectedSubTab == 0
                            ? Colors.white
                            : const Color(0xFF8E8E93),
                        size: 22,
                      ),
                    ),
                    if (_selectedSubTab == 0)
                      Container(height: 2.0, color: Colors.white)
                    else
                      const SizedBox(height: 2.0),
                  ],
                ),
              ),
            ),

            // SubTab 1: Chart Icon
            Expanded(
              child: InkWell(
                onTap: () => setState(() => _selectedSubTab = 1),
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      child: Icon(
                        Icons.show_chart_rounded,
                        color: _selectedSubTab == 1
                            ? Colors.white
                            : const Color(0xFF8E8E93),
                        size: 22,
                      ),
                    ),
                    if (_selectedSubTab == 1)
                      Container(height: 2.0, color: Colors.white)
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

  Widget _buildWorkoutGridCard(_WorkoutHistoryCardData card) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF1E1E1E),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: const Color(0xFF2C2C2E),
          width: 0.8,
        ),
      ),
      padding: const EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Top: Date label in DMMono
          Text(
            card.date,
            style: const TextStyle(
              fontFamily: AppTheme.fontMono,
              fontWeight: FontWeight.w700,
              fontSize: 12,
              color: Colors.white,
            ),
          ),

          const SizedBox(height: 4),

          // Center: Authentic Mini Anatomical Body Silhouette
          Expanded(
            child: Center(
              child: Image.asset(
                card.assetImage,
                fit: BoxFit.contain,
              ),
            ),
          ),

          const SizedBox(height: 4),

          // Bottom: Duration in DMMono
          Text(
            card.duration,
            style: const TextStyle(
              fontFamily: AppTheme.fontMono,
              fontWeight: FontWeight.w500,
              fontSize: 12,
              color: Color(0xFFD1D1D6),
            ),
          ),
        ],
      ),
    );
  }
}

class _WorkoutHistoryCardData {
  final String date;
  final String duration;
  final String assetImage;

  const _WorkoutHistoryCardData({
    required this.date,
    required this.duration,
    required this.assetImage,
  });
}
