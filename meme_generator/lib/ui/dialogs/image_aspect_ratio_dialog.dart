import 'package:flutter/material.dart';
import 'package:meme_generator/core/strings.dart';

Future<double?> showImageAspectRatioModal({
  required BuildContext context,
}) async {
  final result = await showDialog<double>(
    context: context,
    builder: (BuildContext context) => AlertDialog(
      contentPadding: const EdgeInsets.all(20),
      title: const Text(
        Strings.aspectRatio,
        textAlign: TextAlign.center,
      ),
      content: SizedBox(
        width: double.maxFinite,
        child: Wrap(
          alignment: WrapAlignment.center,
          spacing: 10,
          children: [
            FilterChip(
              label: const Text('1:2'),
              onSelected: (value) {
                return Navigator.pop(context, 1 / 2);
              },
            ),
            FilterChip(
              label: const Text('2:1'),
              onSelected: (value) {
                return Navigator.pop(context, 2 / 1);
              },
            ),
            FilterChip(
              label: const Text('1:1'),
              onSelected: (value) {
                return Navigator.pop(context, 1 / 1);
              },
            ),
            FilterChip(
              label: const Text('3:4'),
              onSelected: (value) {
                return Navigator.pop(context, 3 / 4);
              },
            ),
            FilterChip(
              label: const Text('2:3'),
              onSelected: (value) {
                return Navigator.pop(context, 2 / 3);
              },
            ),
            FilterChip(
              label: const Text('3:2'),
              onSelected: (value) {
                return Navigator.pop(context, 3 / 2);
              },
            ),
            FilterChip(
              label: const Text('4:3'),
              onSelected: (value) {
                return Navigator.pop(context, 4 / 3);
              },
            ),
            FilterChip(
              label: const Text('16:9'),
              onSelected: (value) {
                return Navigator.pop(context, 16 / 9);
              },
            ),
          ],
        ),
      ),
      actionsAlignment: MainAxisAlignment.center,
      actions: [
        OutlinedButton(
          onPressed: () {
            return Navigator.pop(context, null);
          },
          child: const Text(Strings.cancelButton),
        ),
      ],
    ),
  );
  if (result != null) {
    return result;
  }
  return null;
}
