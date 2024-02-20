import 'package:flutter/material.dart';
import 'package:meme_generator/core/strings.dart';

Future<String?> showTextEditingModal({
  required BuildContext context,
  required String title,
  required String text,
}) async {
  final textFieldController = TextEditingController(text: text);

  final result = await showDialog<bool>(
    context: context,
    builder: (BuildContext context) => AlertDialog(
      contentPadding: const EdgeInsets.all(20),
      title: Text(
        title,
        textAlign: TextAlign.center,
      ),
      content: SizedBox(
        width: double.maxFinite,
        child: TextField(
          controller: textFieldController,
          autofocus: true,
          minLines: 1,
          maxLines: 5,
        ),
      ),
      actionsAlignment: MainAxisAlignment.center,
      actions: [
        FilledButton(
          onPressed: () {
            return Navigator.pop(context, true);
          },
          child: const Text(Strings.saveButton),
        ),
        OutlinedButton(
          onPressed: () {
            return Navigator.pop(context, false);
          },
          child: const Text(Strings.cancelButton),
        ),
      ],
    ),
  );
  if (result ?? false) {
    return textFieldController.text;
  }
  return null;
}
