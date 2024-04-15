import 'package:flutter/widgets.dart';
import 'package:mynotes/utilities/dialogues/generic_dialog.dart';

Future<void> showPasswordResetSentDialog(BuildContext context) {
  return showGenericDialog(
      context: context,
      title: 'Password Reset',
      content: 'We have now sent link on your email',
      optionsBuilder: () => {'OK': null});
}
