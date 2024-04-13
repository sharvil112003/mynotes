import 'package:flutter/material.dart';
import 'package:mynotes/utilities/dialogues/generic_dialog.dart';

Future<bool> showDeleteDialog(BuildContext context) {
  return showGenericDialog(
    context: context,
    title: 'Delete',
    content: 'Are you sure you want to delete this item?',
    optionsBuilder: () => {
      'Cancel': false,
      'LogOut': true,
    },
  ).then(
    (value) => value ?? false,
  );
}