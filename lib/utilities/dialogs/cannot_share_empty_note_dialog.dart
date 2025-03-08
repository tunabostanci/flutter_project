import 'package:flutter/cupertino.dart';
import 'package:freecodecamp/utilities/dialogs/generic_dialog.dart';

Future<void> showCannotShareEmptyNoteDialog(BuildContext context) {
  return showGenericDialog<void>(
    context: context,
    title: 'Sharing',
    content: 'You can not share an empty note!',
    optionsBuilder: () =>{
      'OK' : null,
    },
  );
}
