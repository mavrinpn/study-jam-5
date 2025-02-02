import 'package:flutter/material.dart';
import 'package:meme_generator/core/strings.dart';
import 'package:meme_generator/models/section.dart';
import 'package:meme_generator/models/template.dart';
import 'package:meme_generator/ui/dialogs/image_aspect_ratio_dialog.dart';

class DemotivatorCreateWidget extends StatefulWidget {
  const DemotivatorCreateWidget({
    Key? key,
    required this.template,
    required this.onTemplateChanged,
  }) : super(key: key);

  final Template template;
  final Function(Template template) onTemplateChanged;

  @override
  State<DemotivatorCreateWidget> createState() =>
      _DemotivatorGenerateWidgetState();
}

class _DemotivatorGenerateWidgetState extends State<DemotivatorCreateWidget> {
  late Template template;

  final decoration = BoxDecoration(
    color: Colors.black,
    border: Border.all(
      color: Colors.white,
      width: 2,
    ),
  );

  @override
  void initState() {
    template = widget.template;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: DecoratedBox(
        decoration: decoration,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 20,
          ),
          child: Theme(
            data: Theme.of(context).copyWith(
              canvasColor: Colors.transparent,
              shadowColor: Colors.transparent,
            ),
            child: ReorderableListView(
              physics: const ClampingScrollPhysics(),
              shrinkWrap: true,
              onReorder: (oldIndex, newIndex) {
                if (newIndex > oldIndex) {
                  newIndex -= 1;
                }
                final items = template.sections.removeAt(oldIndex);
                template.sections.insert(newIndex, items);
                widget.onTemplateChanged(template);
              },
              children: [
                ..._buildTemplate(widget.template),
              ],
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
          return GestureDetector(
            key: ObjectKey(section),
            onTap: () => _onTitleTap(),
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8),
              child: Text(
                Strings.title,
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
          return GestureDetector(
            key: ObjectKey(section),
            onTap: () => _onCaptionTap(),
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8),
              child: Text(
                Strings.caption,
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
            key: ObjectKey(section),
            onTap: _onImageTap,
            child: AspectRatio(
              aspectRatio: imageSection.aspectRatio,
              child: DecoratedBox(
                decoration: decoration,
                child: const Padding(
                  padding: EdgeInsets.all(4.0),
                  child: Placeholder(),
                ),
              ),
            ),
          );

        default:
          return Container();
      }
    }).toList();
  }

  void _onTitleTap() {
    //TODO set title text sty;e
  }

  void _onCaptionTap() {
    //TODO set caption text sty;e
  }

  void _onImageTap() {
    showImageAspectRatioModal(context: context).then((value) {
      if (value != null) {
        ImageSection imageSection = template.sections
            .firstWhere((element) => element is ImageSection) as ImageSection;
        imageSection.aspectRatio = value;
        widget.onTemplateChanged(template);
      }
    });
  }
}
