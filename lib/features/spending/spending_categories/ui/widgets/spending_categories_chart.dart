import 'dart:math';

import 'package:collection/collection.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:grocerlytics/features/common/currencies/models/currency_model.dart';
import 'package:grocerlytics/features/common/ui/circular_icon_widget.dart';
import 'package:grocerlytics/features/spending/spending_categories/model/spending_category_model.dart';
import 'package:grocerlytics/features/utils/intl_utils.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class SpendingCategoriesChart extends StatelessWidget {
  const SpendingCategoriesChart({
    super.key,
    required this.isLoading,
    required this.totalSpendingAmount,
    required this.spendingCategories,
    required this.selectedCategoryIndex,
    required this.changeSelectedCategory,
    required this.selectedCurrency,
  });

  final bool isLoading;
  final double totalSpendingAmount;
  final List<SpendingCategoryModel> spendingCategories;
  final int selectedCategoryIndex;
  final void Function(int) changeSelectedCategory;
  final CurrencyModel selectedCurrency;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (_, constraints) {
        final size = min(constraints.maxWidth, constraints.maxHeight) * 0.6;
        final radiusSize = size / 3 < 100 ? 100.0 : min<double>(size / 3, 130);

        return ConstrainedBox(
          constraints: const BoxConstraints(
            minHeight: 300,
            minWidth: 300,
            maxHeight: 500,
            maxWidth: 500,
          ),
          child: SizedBox(
            height: size,
            width: size,
            child: Stack(
              clipBehavior: Clip.none,
              alignment: Alignment.center,
              children: [
                FittedBox(
                  fit: BoxFit.contain,
                  child: SizedBox(
                    width: radiusSize * 2,
                    child: Text(
                      formatCurrency(
                        selectedCurrency,
                        totalSpendingAmount,
                      ),
                      textAlign: TextAlign.center,
                      style: ShadTheme.of(context).textTheme.h1,
                    ),
                  ),
                ),
                PieChart(
                  PieChartData(
                    pieTouchData: PieTouchData(
                      touchCallback: (event, pieTouchResponse) {
                        if (event is FlTapDownEvent) {
                          if (!event.isInterestedForInteractions ||
                              pieTouchResponse == null ||
                              pieTouchResponse.touchedSection == null ||
                              pieTouchResponse
                                      .touchedSection?.touchedSectionIndex ==
                                  -1 ||
                              pieTouchResponse
                                      .touchedSection?.touchedSectionIndex ==
                                  selectedCategoryIndex) {
                            return;
                          }
                          final idx = pieTouchResponse
                              .touchedSection!.touchedSectionIndex;

                          HapticFeedback.lightImpact();
                          changeSelectedCategory(idx);
                        }
                      },
                    ),
                    borderData: FlBorderData(
                      show: false,
                    ),
                    sectionsSpace: 8,
                    centerSpaceRadius: radiusSize,
                    sections: spendingCategories.mapIndexed((index, e) {
                      final isTouched = index == selectedCategoryIndex;
                      final radius = isTouched ? 70.0 : 50.0;
                      return PieChartSectionData(
                        showTitle: false,
                        badgePositionPercentageOffset: .98,
                        badgeWidget: CircularIconWidget(
                          iconSize: 12,
                          size: 20,
                          icon: e.categoryModel.iconData,
                        ),
                        color: e.categoryModel.color,
                        value: e.spendingAmount,
                        radius: radius,
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
