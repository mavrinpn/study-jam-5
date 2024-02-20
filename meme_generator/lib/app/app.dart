import 'package:flutter/material.dart';
import 'package:meme_generator/models/template.dart';
import 'package:meme_generator/ui/screens/catalog/meme_catalog_screen.dart';
import 'package:meme_generator/ui/screens/creator/meme_template_creator_screen.dart';
import 'package:meme_generator/ui/screens/generator/meme_generator_screen.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: '/catalog',
      routes: {
        '/catalog': (context) => const MemeCatalogScreen(),
        '/generator': (context) {
          final args = ModalRoute.of(context)!.settings.arguments as Template;
          return MemeGeneratorScreen(template: args);
        },
        '/creator': (context) => const MemeTemplateCreatorScreen(),
      },
    );
  }
}
