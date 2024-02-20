import 'package:flutter/material.dart';
import 'package:meme_generator/core/strings.dart';
import 'package:meme_generator/models/section.dart';
import 'package:meme_generator/models/template.dart';
import 'package:meme_generator/ui/dialogs/image_selecting_dialog.dart';
import 'package:meme_generator/ui/dialogs/text_editing_dialog.dart';

class DemotivatorGenerateWidget extends StatefulWidget {
  const DemotivatorGenerateWidget({
    Key? key,
    required this.template,
    required this.repaintBoundaryGlobalKey,
  }) : super(key: key);

  final Template template;
  final GlobalKey<State<StatefulWidget>> repaintBoundaryGlobalKey;

  @override
  State<DemotivatorGenerateWidget> createState() =>
      _DemotivatorGenerateWidgetState();
}

class _DemotivatorGenerateWidgetState extends State<DemotivatorGenerateWidget> {
  Map<int, String> titles = {};
  Map<int, String> captions = {};
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
              children: _buildTemplate(widget.template),
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> _buildTemplate(Template template) {
    return template.sections.map((section) {
      switch (section.runtimeType) {
        case TitleSection:
          final textSection = section as TitleSection;
          final text = titles[section.hashCode] ?? Strings.title;
          return GestureDetector(
            onTap: () => _onTitleTap(section.hashCode),
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8),
              child: Text(
                text != '' ? text : Strings.title,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: textSection.fontFamily,
                  fontSize: textSection.fontSize,
                  color: Colors.white,
                ),
              ),
            ),
          );
        case CaptionSection:
          final textSection = section as CaptionSection;
          final text = captions[section.hashCode] ?? Strings.caption;
          return GestureDetector(
            onTap: () => _onCaptionTap(section.hashCode),
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8),
              child: Text(
                text != '' ? text : Strings.caption,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: textSection.fontFamily,
                  fontSize: textSection.fontSize,
                  color: Colors.white,
                ),
              ),
            ),
          );
        case ImageSection:
          final imageSection = section as ImageSection;
          return GestureDetector(
            onTap: _onImageTap,
            child: AspectRatio(
              aspectRatio: imageSection.aspectRatio,
              child: DecoratedBox(
                decoration: decoration,
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: image,
                ),
              ),
            ),
          );

        default:
          return Container();
      }
    }).toList();
  }

  void _onTitleTap(int sectionHash) {
    showTextEditingModal(
      context: context,
      title: Strings.title,
      text: titles[sectionHash] ?? '',
    ).then((value) {
      if (value != null) {
        setState(() {
          titles[sectionHash] = value;
        });
      }
    });
  }

  void _onCaptionTap(int sectionHash) {
    showTextEditingModal(
      context: context,
      title: Strings.caption,
      text: captions[sectionHash] ?? '',
    ).then((value) {
      if (value != null) {
        setState(() {
          captions[sectionHash] = value;
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
