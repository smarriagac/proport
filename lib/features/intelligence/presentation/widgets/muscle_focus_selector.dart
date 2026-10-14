import 'package:flutter/material.dart';
import '../../../../core/constants/app_constants.dart';

class MuscleFocusSelector extends StatelessWidget {
  final List<String> availableMuscles;
  final List<String> selectedMuscles;
  final Function(String muscle) onToggle;

  const MuscleFocusSelector({
    super.key,
    this.availableMuscles = const [
      'Chest',
      'Back',
      'Shoulders',
      'Arms',
      'Quads',
      'Hamstrings & Glutes',
      'Core',
    ],
    required this.selectedMuscles,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: availableMuscles.map((muscle) {
        final isSelected = selectedMuscles.contains(muscle);
        return FilterChip(
          selected: isSelected,
          showCheckmark: true,
          checkmarkColor: Colors.white,
          backgroundColor: AppColors.surface,
          selectedColor: AppColors.primaryBlue,
          labelStyle: TextStyle(
            color: isSelected ? Colors.white : AppColors.textSecondary,
            fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
            fontSize: 13,
          ),
          side: BorderSide(
            color: isSelected ? AppColors.primaryBlue : AppColors.cardBorder,
            width: isSelected ? 1.5 : 1.0,
          ),
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
          label: Text(muscle),
          onSelected: (_) => onToggle(muscle),
        );
      }).toList(),
    );
  }
}
