import 'package:flutter/material.dart';
import '../../../../core/constants/app_constants.dart';
import '../../domain/entities/exercise_set.dart';

class SetInputRow extends StatefulWidget {
  final ExerciseSet exerciseSet;
  final Function(double weight, int reps) onToggleComplete;

  const SetInputRow({
    super.key,
    required this.exerciseSet,
    required this.onToggleComplete,
  });

  @override
  State<SetInputRow> createState() => _SetInputRowState();
}

class _SetInputRowState extends State<SetInputRow> {
  late TextEditingController _weightController;
  late TextEditingController _repsController;

  @override
  void initState() {
    super.initState();
    _weightController = TextEditingController(
      text: widget.exerciseSet.weightKg > 0
          ? widget.exerciseSet.weightKg.toStringAsFixed(1)
          : '0',
    );
    _repsController = TextEditingController(
      text: widget.exerciseSet.reps.toString(),
    );
  }

  @override
  void didUpdateWidget(covariant SetInputRow oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.exerciseSet.reps != widget.exerciseSet.reps) {
      _repsController.text = widget.exerciseSet.reps.toString();
    }
    if (oldWidget.exerciseSet.weightKg != widget.exerciseSet.weightKg) {
      _weightController.text = widget.exerciseSet.weightKg > 0
          ? widget.exerciseSet.weightKg.toStringAsFixed(1)
          : '0';
    }
  }

  @override
  void dispose() {
    _weightController.dispose();
    _repsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isCompleted = widget.exerciseSet.isCompleted;

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: isCompleted
            ? AppColors.success.withValues(alpha: 0.08)
            : AppColors.surface,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: isCompleted
              ? AppColors.success.withValues(alpha: 0.3)
              : AppColors.cardBorder,
        ),
      ),
      child: Row(
        children: [
          // Set Number
          Container(
            width: 32,
            height: 32,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: isCompleted
                  ? AppColors.success.withValues(alpha: 0.2)
                  : AppColors.card,
              shape: BoxShape.circle,
            ),
            child: Text(
              '${widget.exerciseSet.setNumber}',
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 13,
                color: isCompleted ? AppColors.success : AppColors.textPrimary,
              ),
            ),
          ),
          const SizedBox(width: 12),

          // Weight Field
          Expanded(
            flex: 3,
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _weightController,
                    keyboardType: const TextInputType.numberWithOptions(decimal: true),
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 14),
                    decoration: InputDecoration(
                      isDense: true,
                      contentPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
                      fillColor: AppColors.card,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 4),
                const Text(
                  'kg',
                  style: TextStyle(color: AppColors.textMuted, fontSize: 12),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),

          // Reps Field
          Expanded(
            flex: 3,
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _repsController,
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 14),
                    decoration: InputDecoration(
                      isDense: true,
                      contentPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
                      fillColor: AppColors.card,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 4),
                const Text(
                  'reps',
                  style: TextStyle(color: AppColors.textMuted, fontSize: 12),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),

          // Check Completion Button
          InkWell(
            onTap: () {
              final weight = double.tryParse(_weightController.text) ?? 0.0;
              final reps = int.tryParse(_repsController.text) ?? 10;
              widget.onToggleComplete(weight, reps);
            },
            borderRadius: BorderRadius.circular(8),
            child: Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: isCompleted ? AppColors.success : AppColors.card,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: isCompleted ? AppColors.success : AppColors.cardBorder,
                ),
              ),
              child: Icon(
                Icons.check_rounded,
                size: 20,
                color: isCompleted ? Colors.white : AppColors.textMuted,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
