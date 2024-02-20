import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:meme_generator/core/strings.dart';
import 'package:meme_generator/models/template.dart';
import 'package:meme_generator/ui/dialogs/error_dialog.dart';
import 'package:meme_generator/ui/widgets/demotivator_generate_widget.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

class MemeGeneratorScreen extends StatelessWidget {
  MemeGeneratorScreen({
    Key? key,
    required this.template,
  }) : super(key: key);

  final Template template;
  final GlobalKey repaintBoundaryGlobalKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(Strings.generatorScreenTitle),
        actions: [
          IconButton(
            onPressed: () => _shareImage(context),
            icon: const Icon(Icons.share),
          ),
        ],
      ),
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            clipBehavior: Clip.none,
            child: DemotivatorGenerateWidget(
              template: template,
              repaintBoundaryGlobalKey: repaintBoundaryGlobalKey,
            ),
          ),
        ),
      ),
    );
  }

  void _shareImage(BuildContext context) async {
    _captureImageToFile().then((fileName) {
      Share.shareXFiles([XFile(fileName)]);
    }).catchError((error) {
      showErrorModal(context: context, message: error);
    });
  }

  Future<String> _captureImageToFile() async {
    try {
      final RenderRepaintBoundary boundary =
          repaintBoundaryGlobalKey.currentContext!.findRenderObject()!
              as RenderRepaintBoundary;
      final image = await boundary.toImage(pixelRatio: 2);
      final ByteData? byteData =
          await image.toByteData(format: ImageByteFormat.png);
      final pngBytes = byteData!.buffer.asUint8List();
      final tempDir = await getTemporaryDirectory();
      final fileName = '${tempDir.path}/${DateTime.now().toString()}.png';
      await File(fileName).writeAsBytes(pngBytes);
      return fileName;
    } catch (error) {
      throw Exception(error);
    }
  }
}
