import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meme_generator/core/strings.dart';

Future<Image?> showImageSelectingModal({required BuildContext context}) async {
  final urlFieldController = TextEditingController(text: 'https://');

  final result = await showDialog<Image?>(
    context: context,
    builder: (BuildContext context) => AlertDialog(
      contentPadding: const EdgeInsets.all(20),
      title: const Text(
        Strings.image,
        textAlign: TextAlign.center,
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          FilledButton(
            onPressed: () {
              _showImagePicker().then((value) => Navigator.pop(context, value));
            },
            child: const Text(Strings.selectFromGallery),
          ),
          const Divider(height: 30),
          TextField(
            controller: urlFieldController,
          ),
          FilledButton(
            onPressed: () {
              final value = _imageFromURL(urlFieldController.text);
              return Navigator.pop(context, value);
            },
            child: const Text(Strings.downloadFromInternet),
          ),
        ],
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

Future<Image?> _showImagePicker() {
  ImagePicker picker = ImagePicker();
  return picker
      .pickImage(
    source: ImageSource.gallery,
    maxWidth: 1024,
    maxHeight: 1024,
  )
      .then((image) {
    if (image != null) {
      return Image.file(
        File(image.path),
        fit: BoxFit.cover,
      );
    } else {
      return null;
    }
  });
}

Image _imageFromURL(String url) {
  return Image.network(
    url,
    fit: BoxFit.cover,
    errorBuilder: (context, error, stackTrace) {
      return Center(
        child: Text(
          error.toString(),
          textAlign: TextAlign.center,
          style: const TextStyle(color: Colors.white),
        ),
      );
    },
    loadingBuilder:
        (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
      if (loadingProgress == null) return child;
      return Center(
        child: CircularProgressIndicator(
          color: Colors.white,
          value: loadingProgress.expectedTotalBytes != null
              ? loadingProgress.cumulativeBytesLoaded /
                  loadingProgress.expectedTotalBytes!
              : null,
        ),
      );
    },
  );
}
