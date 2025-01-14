import 'package:flutter/material.dart';
import 'package:grocerlytics/features/common/ui/animated_container_widget.dart';
import 'package:grocerlytics/features/common/ui/shimmer_widget.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class SpendingDateRangePicker extends StatelessWidget {
  const SpendingDateRangePicker({
    super.key,
    required this.isLoading,
    required this.onConfirmPressed,
    required this.onRangeChanged,
    required this.fromDate,
    required this.toDate,
  });

  final bool isLoading;
  final VoidCallback onConfirmPressed;
  final void Function(ShadDateTimeRange?) onRangeChanged;
  final DateTime? fromDate;
  final DateTime? toDate;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        AnimatedContainerWidget(
          firstChild: ShimmerWidget(
            child: ShadButton.outline(
              enabled: false,
              icon: const Icon(LucideIcons.search),
              onPressed: onConfirmPressed,
            ),
          ),
          secondChild: ShadButton.outline(
            icon: const Icon(LucideIcons.search),
            onPressed: onConfirmPressed,
          ),
          isLoading: isLoading,
        ),
        AnimatedContainerWidget(
          firstChild: ShimmerWidget(
            child: ShadDatePicker.range(
              enabled: false,
              selected: ShadDateTimeRange(
                start: fromDate,
                end: toDate,
              ),
            ),
          ),
          secondChild: ShadDatePicker.range(
            allowDeselection: false,
            selected: ShadDateTimeRange(
              start: fromDate,
              end: toDate,
            ),
            onRangeChanged: onRangeChanged,
            selectableDayPredicate: (day) => day.isBefore(DateTime.now()),
          ),
          isLoading: isLoading,
        ),
      ],
    );
  }
}
