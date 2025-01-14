import 'package:flutter/material.dart';
import 'package:grocerlytics/features/common/analytics/plausible_event.dart';
import 'package:grocerlytics/features/settings/ui/settings_page.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class ContactUsWidget extends StatelessWidget {
  const ContactUsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(LucideIcons.lifeBuoy),
      onTap: () {
        buttonClickTracking(
          page: '$SettingsPage',
          buttonInfo: 'Launching contact us',
        );

        final emailLaunchUri = Uri(
          scheme: 'mailto',
          path: 'jesusos.dev@gmail.com',
        );

        launchUrl(emailLaunchUri);
      },
      trailing: const Icon(LucideIcons.chevronRight),
      title: const Text('Contact us'),
      subtitle: const Text('Use this for feature requests or bug reports!'),
    );
  }
}
