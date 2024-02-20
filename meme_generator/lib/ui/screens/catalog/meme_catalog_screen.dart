import 'package:flutter/material.dart';
import 'package:meme_generator/core/strings.dart';
import 'package:meme_generator/data/data_service.dart';
import 'package:meme_generator/models/template.dart';
import 'package:meme_generator/ui/widgets/meme_template_card.dart';

class MemeCatalogScreen extends StatefulWidget {
  const MemeCatalogScreen({Key? key}) : super(key: key);

  @override
  State<MemeCatalogScreen> createState() => _MemeCatalogScreenState();
}

class _MemeCatalogScreenState extends State<MemeCatalogScreen> {
  List<Template> templates = [];

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  void _loadData() {
    MockDataService.loadTemplates().then((value) {
      setState(() {
        templates = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(Strings.catalogScreenTitle),
        actions: [
          IconButton(
            onPressed: _addButtonAction,
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: SafeArea(
        child: ListView.builder(
          clipBehavior: Clip.none,
          padding: const EdgeInsets.all(8),
          itemCount: templates.length,
          itemBuilder: (context, index) {
            return MemeTemplateCard(template: templates[index]);
          },
        ),
      ),
    );
  }

  void _addButtonAction() {
    Navigator.of(context).pushNamed('/creator').then((value) {
      _loadData();
    });
  }
}
