import 'package:flutter/material.dart';

import '../../core/common.dart';

Future<void> paisaBottomSheet(
  BuildContext context,
  Widget child,
) =>
    showModalBottomSheet(
      context: context,
      builder: (_) => Padding(
        padding: MediaQuery.of(context).viewInsets,
        child: SafeArea(
          child: Material(
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              ),
            ),
            child: child,
          ),
        ),
      ),
    );

Future<void> paisaAlertDialog(
  BuildContext context, {
  required Widget child,
  required Widget title,
  required Widget confirmationButton,
}) =>
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: title,
        content: child,
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(context.loc.cancelLabel),
          ),
          confirmationButton,
        ],
      ),
    );
