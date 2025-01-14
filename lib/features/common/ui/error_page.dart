import 'package:flutter/material.dart';
import 'package:grocerlytics/features/common/analytics/plausible_event.dart';
import 'package:grocerlytics/features/common/ui/primary_button.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class ErrorPage extends StatelessWidget {
  const ErrorPage({
    super.key,
    required this.refreshCallback,
  });

  final VoidCallback refreshCallback;

  @override
  Widget build(BuildContext context) {
    final theme = ShadTheme.of(context);

    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            spacing: 16,
            children: [
              const Icon(
                LucideIcons.satelliteDish,
                size: 80,
              ),
              Text(
                'Oops! looks like something is wrong with the application try checking back later',
                textAlign: TextAlign.center,
                style: theme.textTheme.muted,
              ),
              PrimaryButton(
                label: 'Try again',
                onPressed: () {
                  buttonClickTracking(
                    page: '$ErrorPage',
                    buttonInfo: 'Refreshing error page',
                  );
                  refreshCallback();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
