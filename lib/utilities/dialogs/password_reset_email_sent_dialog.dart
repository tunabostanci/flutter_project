import 'package:flutter/cupertino.dart';
import 'package:freecodecamp/utilities/dialogs/generic_dialog.dart';

Future<void> showPasswordResetSentDialog(BuildContext context) {
  return showGenericDialog<void>(
    context: context,
    title:'Password reset',
    content: 'We have now sent you a password reset link,\n Please check your email for more information',
    optionsBuilder:()=> {
      'OK' : null,
    },
  );
}