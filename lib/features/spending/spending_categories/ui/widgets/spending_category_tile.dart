import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:grocerlytics/features/common/analytics/plausible_event.dart';
import 'package:grocerlytics/features/common/currencies/models/currency_model.dart';
import 'package:grocerlytics/features/common/ui/animated_container_widget.dart';
import 'package:grocerlytics/features/common/ui/circular_icon_widget.dart';
import 'package:grocerlytics/features/common/ui/placeholder_widget.dart';
import 'package:grocerlytics/features/common/ui/shimmer_widget.dart';
import 'package:grocerlytics/features/spending/spending_categories/model/spending_category_model.dart';
import 'package:grocerlytics/features/spending/ui/spending_page.dart';
import 'package:grocerlytics/features/utils/intl_utils.dart';
import 'package:grocerlytics/router/router.gr.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class SpendingCategoryTile extends StatelessWidget {
  const SpendingCategoryTile({
    super.key,
    required this.isLoading,
    required this.spendingCategoryModel,
    required this.selectedCurrency,
    required this.startDate,
    required this.endDate,
    this.backgroundColor,
  });

  final bool isLoading;
  final CurrencyModel selectedCurrency;
  final SpendingCategoryModel spendingCategoryModel;
  final String startDate;
  final String endDate;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    final theme = ShadTheme.of(context);
    return ShadGestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {
        buttonClickTracking(
          page: '$SpendingPage',
          buttonInfo:
              'Selecting spending category ${spendingCategoryModel.categoryModel.id} from list',
        );
        AutoTabsRouter.of(context).navigate(
          SpendingCategoryRoute(
            id: spendingCategoryModel.categoryModel.id,
            startDate: startDate,
            endDate: endDate,
            count: spendingCategoryModel.purchaseCount,
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
        child: Row(
          children: [
            AnimatedContainerWidget(
              firstChild: const ShimmerWidget(
                child: ShadDecorator(
                  decoration: ShadDecoration(
                    merge: false,
                    shape: BoxShape.circle,
                  ),
                  child: SizedBox(
                    width: 5,
                    height: 5,
                  ),
                ),
              ),
              secondChild: ShadDecorator(
                decoration: ShadDecoration(
                  merge: false,
                  color: backgroundColor,
                  shape: BoxShape.circle,
                ),
                child: const SizedBox(
                  width: 5,
                  height: 5,
                ),
              ),
              isLoading: isLoading,
            ),
            const SizedBox(width: 8),
            AnimatedContainerWidget(
              firstChild: ShimmerWidget(
                child: CircularIconWidget(
                  icon: spendingCategoryModel.categoryModel.iconData,
                  backgroundColor: Colors.white,
                ),
              ),
              secondChild: CircularIconWidget(
                heroTag:
                    'spending-category${spendingCategoryModel.categoryModel.id}',
                icon: spendingCategoryModel.categoryModel.iconData,
                backgroundColor: backgroundColor ?? theme.colorScheme.ring,
              ),
              isLoading: isLoading,
            ),
            const SizedBox(width: 16),
            Expanded(
              child: AnimatedContainerWidget(
                firstChild: const ShimmerWidget(
                  child: PlaceholderWidget(),
                ),
                secondChild: Text(
                  spendingCategoryModel.categoryModel.label,
                  style: theme.textTheme.small,
                ),
                isLoading: isLoading,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  AnimatedContainerWidget(
                    firstChild: const ShimmerWidget(
                      child: PlaceholderWidget(
                        width: 50,
                      ),
                    ),
                    secondChild: Text(
                      formatCurrency(
                        selectedCurrency,
                        spendingCategoryModel.spendingAmount,
                      ),
                      style: theme.textTheme.small,
                    ),
                    isLoading: isLoading,
                  ),
                  const SizedBox(height: 4),
                  AnimatedContainerWidget(
                    firstChild: const ShimmerWidget(
                      child: PlaceholderWidget(
                        width: 50,
                      ),
                    ),
                    secondChild: Text(
                      '${spendingCategoryModel.purchaseCount} purchases',
                      style: theme.textTheme.muted,
                    ),
                    isLoading: isLoading,
                  ),
                ],
              ),
            ),
            const SizedBox(width: 16),
            isLoading
                ? const SizedBox.shrink()
                : const Icon(LucideIcons.chevronRight, size: 16)
          ],
        ),
      ),
    );
  }
}
