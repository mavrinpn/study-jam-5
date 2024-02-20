import 'package:flutter/material.dart';
import 'package:meme_generator/core/strings.dart';
import 'package:meme_generator/ui/dialogs/image_selecting_dialog.dart';
import 'package:meme_generator/ui/dialogs/text_editing_dialog.dart';

class DemotivatorCreateWidget extends StatefulWidget {
  const DemotivatorCreateWidget({
    Key? key,
    required this.repaintBoundaryGlobalKey,
  }) : super(key: key);

  final GlobalKey<State<StatefulWidget>> repaintBoundaryGlobalKey;

  @override
  State<DemotivatorCreateWidget> createState() =>
      _DemotivatorCreateWidgetState();
}

class _DemotivatorCreateWidgetState extends State<DemotivatorCreateWidget> {
  String title = Strings.title;
  String caption = Strings.caption;
  Image? image;

  final decoration = BoxDecoration(
    color: Colors.black,
    border: Border.all(
      color: Colors.white,
      width: 2,
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: RepaintBoundary(
        key: widget.repaintBoundaryGlobalKey,
        child: DecoratedBox(
          decoration: decoration,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 20,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                GestureDetector(
                  onTap: _onImageTap,
                  child: AspectRatio(
                    aspectRatio: 1,
                    child: DecoratedBox(
                      decoration: decoration,
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: image,
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: _onTitleTap,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Text(
                      title != '' ? title : Strings.title,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontFamily: 'Impact',
                        fontSize: 40,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: _onCaptionTap,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Text(
                      caption != '' ? caption : Strings.caption,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontFamily: 'Times',
                        fontSize: 20,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _onTitleTap() {
    showTextEditingModal(
      context: context,
      title: Strings.title,
      text: title,
    ).then((value) {
      if (value != null) {
        setState(() {
          title = value;
        });
      }
    });
  }

  void _onCaptionTap() {
    showTextEditingModal(
      context: context,
      title: Strings.caption,
      text: caption,
    ).then((value) {
      if (value != null) {
        setState(() {
          caption = value;
        });
      }
    });
  }

  void _onImageTap() {
    showImageSelectingModal(context: context).then((value) {
      if (value != null) {
        setState(() {
          image = value;
        });
      }
    });
  }
}
