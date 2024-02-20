import 'package:flutter/material.dart';
import 'package:meme_generator/core/strings.dart';
import 'package:meme_generator/data/data_service.dart';
import 'package:meme_generator/models/section.dart';
import 'package:meme_generator/models/template.dart';
import 'package:meme_generator/ui/dialogs/text_editing_dialog.dart';
import 'package:meme_generator/ui/widgets/demotivator_create_widget.dart';

class MemeTemplateCreatorScreen extends StatefulWidget {
  const MemeTemplateCreatorScreen({super.key});

  @override
  State<MemeTemplateCreatorScreen> createState() =>
      _MemeTemplateCreatorScreenState();
}

class _MemeTemplateCreatorScreenState extends State<MemeTemplateCreatorScreen> {
  Template template = Template(
      name: Strings.newTemplate, sections: [ImageSection(aspectRatio: 1.0)]);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(Strings.creatorScreenTitle),
      ),
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            clipBehavior: Clip.none,
            child: Column(
              children: [
                DemotivatorCreateWidget(
                  template: template,
                  onTemplateChanged: (template) {
                    setState(() {
                      this.template = template;
                    });
                  },
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    FilledButton(
                        onPressed: _onAddTitle,
                        child: const Text(Strings.addTitle)),
                    FilledButton(
                        onPressed: _onAddCaption,
                        child: const Text(Strings.addCaption)),
                  ],
                ),
                FilledButton(
                    onPressed: () {
                      showTextEditingModal(
                        context: context,
                        title: Strings.name,
                        text: Strings.newTemplate,
                      ).then((value) {
                        if (value != null) {
                          template.name =
                              value != '' ? value : Strings.newTemplate;
                          MockDataService.putTemplate(template).then((value) {
                            Navigator.of(context).pop();
                          });
                        }
                      });
                    },
                    child: const Text(Strings.saveTemplateButton)),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _onAddCaption() {
    template.sections.add(CaptionSection(fontFamily: 'Times', fontSize: 24));
    setState(() {});
  }

  void _onAddTitle() {
    template.sections.add(TitleSection(fontFamily: 'Impact', fontSize: 40));
    setState(() {});
  }
}
