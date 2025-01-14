import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grocerlytics/features/common/categories/categories_cubit.dart';
import 'package:grocerlytics/features/dependency_injection/injectable.dart';
import 'package:grocerlytics/features/receipt/add_receipt/ui/add_receipt_cubit.dart';
import 'package:grocerlytics/features/spending/ui/spending_cubit.dart';

@RoutePage()
class AddReceiptNavigationScreen extends StatelessWidget {
  const AddReceiptNavigationScreen({
    super.key,
    required this.spendingCubit,
  });

  final SpendingCubit spendingCubit;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AddReceiptCubit>(
          create: (_) => getIt.get<AddReceiptCubit>()
            ..init(
              context.read<CategoriesCubit>().state.categories.first,
            ),
        ),
        BlocProvider.value(
          value: spendingCubit,
        ),
      ],
      child: const AutoRouter(),
    );
  }
}
