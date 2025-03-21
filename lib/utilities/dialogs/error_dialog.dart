import 'package:flutter/cupertino.dart';
import 'package:freecodecamp/utilities/dialogs/generic_dialog.dart';

Future<void> showErrorDialog(BuildContext context,
    String text) {

  print("showErrordialog cagirildi! icerik : $text");
  return showGenericDialog<void>(
    context: context,
    title: 'An error occured',
    content: text,
    optionsBuilder: () =>{
      'OK':null,
    },
  );
}