import 'package:flutter/material.dart';
import 'package:grocerlytics/features/common/analytics/plausible_event.dart';
import 'package:grocerlytics/features/settings/ui/settings_page.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class LicenseWidget extends StatelessWidget {
  const LicenseWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(LucideIcons.scrollText),
      onTap: () {
        buttonClickTracking(
          page: '$SettingsPage',
          buttonInfo: 'Launching licenses',
        );
        showLicensePage(
          context: context,
          applicationName: 'Grocerlytics',
          applicationIcon: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: SvgPicture.asset(
              'assets/app_icon_ios.svg',
              width: 80,
              height: 80,
            ),
          ),
        );
      },
      trailing: const Icon(LucideIcons.chevronRight),
      title: const Text('Licenses'),
    );
  }
}
