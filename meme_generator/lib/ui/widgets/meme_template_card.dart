import 'package:flutter/material.dart';
import 'package:meme_generator/models/template.dart';

class MemeTemplateCard extends StatelessWidget {
  final Template template;
  const MemeTemplateCard({
    Key? key,
    required this.template,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.hardEdge,
      child: InkWell(
        onTap: () => _onTap(context: context, template: template),
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: AspectRatio(
            aspectRatio: 5 / 2,
            child: Center(
                child: Text(
              template.name,
              style: const TextStyle(fontSize: 20),
            )),
          ),
        ),
      ),
    );
  }

  void _onTap({
    required BuildContext context,
    required Template template,
  }) {
    Navigator.of(context).pushNamed(
      '/generator',
      arguments: template,
    );
  }
}
