import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:grocerlytics/features/common/analytics/plausible_event.dart';
import 'package:grocerlytics/features/common/ui/toasts.dart';
import 'package:grocerlytics/features/receipt/add_receipt/ui/add_receipt_page.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class AddReceiptPhotoWidget extends StatefulWidget {
  const AddReceiptPhotoWidget({
    super.key,
    required this.onImageSelected,
  });

  final void Function(XFile) onImageSelected;

  @override
  State<AddReceiptPhotoWidget> createState() => _AddReceiptPhotoWidgetState();
}

class _AddReceiptPhotoWidgetState extends State<AddReceiptPhotoWidget> {
  late final ImagePicker picker;

  @override
  void initState() {
    super.initState();
    picker = ImagePicker();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: ShadButton.outline(
            icon: const Icon(
              LucideIcons.camera,
              size: 24,
            ),
            onPressed: () {
              buttonClickTracking(
                page: '$AddReceiptPage',
                buttonInfo: 'Taking a picture',
              );
              onPhotoSelected(ImageSource.camera, context);
            },
          ),
        ),
        Expanded(
          child: ShadButton.outline(
            icon: const Icon(
              LucideIcons.image,
              size: 24,
            ),
            onPressed: () {
              buttonClickTracking(
                page: '$AddReceiptPage',
                buttonInfo: 'Choosing picture from gallery',
              );
              onPhotoSelected(ImageSource.gallery, context);
            },
          ),
        ),
      ],
    );
  }

  Future<void> onPhotoSelected(ImageSource source, BuildContext context) async {
    try {
      final pickedFile = await picker.pickImage(
        source: source,
      );

      if (pickedFile != null) {
        widget.onImageSelected(pickedFile);
      }
    } catch (e) {
      log(e.toString());
      if (!context.mounted) return;

      ShadToaster.of(context).show(
        errorToast(
          body: 'There was a problem processing your image, please try again',
        ),
      );
    }
  }
}
