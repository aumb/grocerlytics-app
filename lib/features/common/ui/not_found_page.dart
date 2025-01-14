import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:grocerlytics/features/common/analytics/plausible_event.dart';
import 'package:grocerlytics/features/common/ui/primary_button.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

@RoutePage()
class NotFoundPage extends StatelessWidget {
  const NotFoundPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = ShadTheme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Page Not Found'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Oops! The page you are looking for could not be found.',
              textAlign: TextAlign.center,
              style: theme.textTheme.large,
            ),
            const SizedBox(height: 20),
            PrimaryButton(
              onPressed: () {
                buttonClickTracking(
                  page: '$NotFoundPage',
                  buttonInfo: 'Pushing home',
                );
                context.router.replaceNamed('/');
              },
              label: 'Go to Home',
            ),
          ],
        ),
      ),
    );
  }
}
