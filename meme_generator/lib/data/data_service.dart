import 'package:hive/hive.dart';
import 'package:meme_generator/models/section.dart';
import 'package:meme_generator/models/template.dart';

class MockDataService {
  static const templatesBox = 'templates';

  static final List<Template> _defaultTemplates = [
    Template(
      name: 'Квадратный демотиватор',
      sections: [
        ImageSection(aspectRatio: 1.0),
        TitleSection(fontFamily: 'Impact', fontSize: 40),
      ],
    ),
    Template(
      name: 'Высокий демотиватор',
      sections: [
        ImageSection(aspectRatio: 2 / 3),
        TitleSection(fontFamily: 'Impact', fontSize: 30),
        CaptionSection(fontFamily: 'Times', fontSize: 20),
      ],
    ),
    Template(
      name: 'Плоский демотиватор',
      sections: [
        TitleSection(fontFamily: 'Impact', fontSize: 40),
        ImageSection(aspectRatio: 4 / 2),
        CaptionSection(fontFamily: 'Times', fontSize: 30),
      ],
    ),
    Template(
      name: 'Демотиватор безумия',
      sections: [
        CaptionSection(fontFamily: 'Times', fontSize: 30),
        TitleSection(fontFamily: 'Impact', fontSize: 40),
        ImageSection(aspectRatio: 1),
        TitleSection(fontFamily: 'Impact', fontSize: 40),
        CaptionSection(fontFamily: 'Times', fontSize: 30),
      ],
    ),
  ];

  static Future<List<Template>> loadTemplates() async {
    var box = await Hive.openBox(templatesBox);
    if (box.isEmpty) {
      await box.addAll(_defaultTemplates.map((e) => e.toMap()).toList());
      return _defaultTemplates;
    }

    final result = box.values
        .map((e) => Template.fromMap(Map<String, dynamic>.from(e)))
        .toList();
    return result;
  }

  static Future<void> putTemplate(Template template) async {
    var box = await Hive.openBox(templatesBox);
    await box.add(template.toMap());
    return Future.value(null);
  }
}
