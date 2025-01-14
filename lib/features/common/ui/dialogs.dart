import 'package:flutter/material.dart';
import 'package:grocerlytics/features/common/analytics/plausible_event.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

ShadDialog confirmDialog({
  required BuildContext context,
  required String title,
  required String trackingPage,
  String? description,
}) =>
    ShadDialog.alert(
      title: Text(title),
      description: description != null
          ? Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Text(description),
            )
          : null,
      actions: [
        ShadButton.outline(
            child: const Text('Cancel'),
            onPressed: () {
              buttonClickTracking(
                page: trackingPage,
                buttonInfo: 'Cancel Dialog',
              );
              Navigator.of(context).pop(false);
            }),
        ShadButton.destructive(
          child: const Text('Continue'),
          onPressed: () {
            buttonClickTracking(
              page: trackingPage,
              buttonInfo: 'Continue Dialog',
            );
            Navigator.of(context).pop(true);
          },
        ),
      ],
    );
