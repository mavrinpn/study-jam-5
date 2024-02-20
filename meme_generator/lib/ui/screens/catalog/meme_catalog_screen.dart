import 'package:flutter/material.dart';
import 'package:meme_generator/core/strings.dart';

class MemeCatalogScreen extends StatelessWidget {
  const MemeCatalogScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(Strings.catalogScreenTitle),
      ),
      body: ListView(
        children: const [
          _MemeTemplateCard(id: '1'),
          _MemeTemplateCard(id: '2'),
          _MemeTemplateCard(id: '3'),
        ],
      ),
    );
  }
}

class _MemeTemplateCard extends StatelessWidget {
  final String id;
  const _MemeTemplateCard({
    Key? key,
    required this.id,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return InkWell(
      onTap: () => _onTap(context),
      child: Card(
        clipBehavior: Clip.hardEdge,
        child: AspectRatio(
          aspectRatio: 1.0,
          child: Container(
            color: theme.primaryColor,
            child: Center(child: Text(id)),
          ),
        ),
      ),
    );
  }

  void _onTap(BuildContext context) {
    Navigator.of(context).pushNamed('/generator');
  }
}
