import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

ShadToast errorToast({
  String title = 'Uh oh! Something went wrong',
  required String body,
}) =>
    ShadToast.destructive(
      showCloseIconOnlyWhenHovered: false,
      title: Text(title),
      description: Text(body),
    );
