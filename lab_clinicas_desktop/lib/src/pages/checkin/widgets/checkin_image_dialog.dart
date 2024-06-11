import 'package:flutter/material.dart';
import 'package:lab_clinicas_desktop/src/core/env.dart';

class CheckinImageDialog extends AlertDialog {
  CheckinImageDialog(
    BuildContext context, {
    super.key,
    required this.pathImage,
  }) : super(
          content: Image.network(
            '${Env.backEndBaseURL}/$pathImage',
            fit: BoxFit.cover,
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text("Close"),
            ),
          ],
        );

  final String pathImage;
}
