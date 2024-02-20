import 'package:hive/hive.dart';
import 'package:meme_generator/models/section.dart';

class Template extends HiveObject {
  String name;

  final List<Section> sections;

  Template({
    required this.name,
    required this.sections,
  });

  Map<String, dynamic> toMap() => <String, dynamic>{
        'name': name,
        'sections': sections.map((e) => e.toMap()).toList(),
      };

  factory Template.fromMap(Map<String, dynamic> json) => Template(
        name: json['name'],
        sections: json['sections'] != null
            ? _sectionsFromList(List<dynamic>.from(json['sections']))
            : [],
      );

  static List<Section> _sectionsFromList(List<dynamic> list) {
    List<Section> result = [];
    for (var row in list) {
      final json = Map<String, dynamic>.from(row);
      final type = json['type'] ?? '';

      switch (type) {
        case 'title':
          result.add(TitleSection(
            fontFamily: json['fontFamily'] ?? '',
            fontSize: json['fontSize'] != null
                ? double.tryParse('${json['fontSize']}') ?? 40.0
                : 40.0,
          ));
          break;
        case 'caption':
          result.add(CaptionSection(
            fontFamily: json['fontFamily'] ?? '',
            fontSize: json['fontSize'] != null
                ? double.tryParse('${json['fontSize']}') ?? 40.0
                : 40.0,
          ));
          break;
        case 'image':
          result.add(ImageSection(
            aspectRatio: json['aspectRatio'] != null
                ? double.tryParse('${json['aspectRatio']}') ?? 1.0
                : 1.0,
          ));
          break;
        default:
      }
    }

    return result;
  }
}
