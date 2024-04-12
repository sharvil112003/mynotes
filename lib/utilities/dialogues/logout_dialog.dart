import 'package:flutter/material.dart';
import 'package:mynotes/utilities/dialogues/generic_dialog.dart';

Future<bool> showLogOutDialog(
  BuildContext context,
) {
  return showGenericDialog<bool>(
    context: context,
    title: 'Log Out',
    content: 'Are you sure you want to Log Out?',
    optionsBuilder: () => {
      'Cancel': false,
      'Log Out': true,
    },
  ).then((value) => value ?? false);
}
