import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grocerlytics/features/common/categories/categories_cubit.dart';
import 'package:grocerlytics/features/common/currencies/ui/currencies_cubit.dart';
import 'package:grocerlytics/features/common/models/status.dart';
import 'package:grocerlytics/features/common/quantity_units/ui/quantity_units_cubit.dart';
import 'package:grocerlytics/features/common/ui/toasts.dart';
import 'package:grocerlytics/features/dependency_injection/injectable.dart';
import 'package:grocerlytics/features/receipt/add_receipt/ui/add_receipt_cubit.dart';
import 'package:grocerlytics/features/receipt/analyze_receipt/ui/analyze_receipt_cubit.dart';
import 'package:grocerlytics/router/router.gr.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lottie/lottie.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

@RoutePage()
class AnalyzeReceiptPage extends StatelessWidget {
  const AnalyzeReceiptPage({
    super.key,
    required this.file,
  });

  final XFile file;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AnalyzeReceiptCubit>(
      create: (_) => getIt.get<AnalyzeReceiptCubit>()
        ..init(
          file,
          context.read<CurrenciesCubit>().state.selectedCurrency,
          context.read<QuantityUnitsCubit>().state.quantities,
          context.read<CategoriesCubit>().state.categories,
        ),
      child: BlocConsumer<AnalyzeReceiptCubit, AnalyzeReceiptState>(
        listener: (context, state) {
          switch (state.status) {
            case LoadedStatus<AnalyzeReceiptState>():
              context.read<AddReceiptCubit>().bulkUpdate(
                    storeName: state.storeName,
                    items: state.items,
                  );
              context.router.replace(const ReviewReceiptRoute());
            case ErrorStatus<AnalyzeReceiptState>():
              context.maybePop();
              ShadToaster.of(context).show(
                errorToast(
                  body:
                      'There was a problem analyzing your receipt, please try again or fill in the information manually',
                ),
              );
            case InitialStatus<AnalyzeReceiptState>():
            case LoadingStatus<AnalyzeReceiptState>():
            case EmptyStatus<AnalyzeReceiptState>():
              break;
          }
        },
        builder: (context, state) {
          return const AnalyzeReceiptScreen();
        },
      ),
    );
  }
}

class AnalyzeReceiptScreen extends StatelessWidget {
  const AnalyzeReceiptScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = ShadTheme.of(context);
    context.select((AnalyzeReceiptCubit c) => c.state);

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(32.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Lottie.asset(
                  'assets/lottie/analyze_receipt.json',
                  delegates: LottieDelegates(
                    values: [
                      ValueDelegate.color(
                        <String>[
                          'trans',
                          'Rectangle Copy',
                          'Rectangle Copy',
                          'Fill 1'
                        ],
                        value: theme.colorScheme.ring,
                      ),
                      ValueDelegate.color(
                        <String>[
                          'trans',
                          'Rectangle Copy 2',
                          'Rectangle Copy 2',
                          'Fill 1'
                        ],
                        value: theme.colorScheme.ring,
                      ),
                      ValueDelegate.color(
                        <String>[
                          'trans',
                          'Rectangle Copy 3',
                          'Rectangle Copy 3',
                          'Fill 1'
                        ],
                        value: theme.colorScheme.ring,
                      ),
                      ValueDelegate.color(
                        <String>[
                          'trans',
                          'Rectangle Copy 4',
                          'Rectangle Copy 4',
                          'Fill 1'
                        ],
                        value: theme.colorScheme.ring,
                      ),
                      ValueDelegate.color(
                        <String>[
                          'trans',
                          'Rectangle Copy 5',
                          'Rectangle Copy 5',
                          'Fill 1'
                        ],
                        value: theme.colorScheme.ring,
                      ),
                      ValueDelegate.color(
                        <String>['trans', 'Rectangle', 'Rectangle', 'Fill 1'],
                        value: theme.colorScheme.ring,
                      ),
                      ValueDelegate.color(
                        const ['Rectangle', 'Rectangle', 'Fill 1'],
                        value: theme.colorScheme.ring,
                      ),
                    ],
                  ),
                ),
                Text(
                  'Analyzing Receipt...',
                  style: theme.textTheme.h2,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 4),
                const Text(
                  'We are analyzing your receipt. This may take a few seconds.',
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                Text(
                  'We might not get the data 100% correct. Make sure you double check before you submit!',
                  style: theme.textTheme.muted.copyWith(fontSize: 10),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
