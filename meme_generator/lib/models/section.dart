abstract class Section {
  Map<String, dynamic> toMap();
}

abstract class TextSection extends Section {
  final String fontFamily;
  final double fontSize;

  TextSection({
    required this.fontFamily,
    required this.fontSize,
  });
}

class TitleSection extends TextSection {
  TitleSection({
    required super.fontFamily,
    required super.fontSize,
  });

  @override
  Map<String, dynamic> toMap() {
    return {
      'type': 'title',
      'fontFamily': fontFamily,
      'fontSize': fontSize,
    };
  }
}

class CaptionSection extends TextSection {
  CaptionSection({
    required super.fontFamily,
    required super.fontSize,
  });

  @override
  Map<String, dynamic> toMap() {
    return {
      'type': 'caption',
      'fontFamily': fontFamily,
      'fontSize': fontSize,
    };
  }
}

class ImageSection extends Section {
  double aspectRatio;

  ImageSection({required this.aspectRatio});

  @override
  Map<String, dynamic> toMap() {
    return {
      'type': 'image',
      'aspectRatio': aspectRatio,
    };
  }
}
