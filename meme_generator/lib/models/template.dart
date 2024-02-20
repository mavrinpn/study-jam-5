class Part {}

class TextCaption extends Part {
  final String fontFamily;
  final double fontSize;

  TextCaption({
    required this.fontFamily,
    required this.fontSize,
  });
}

class Image extends Part {
  final double aspectRatio;

  Image({required this.aspectRatio});
}

class Template {
  final List<Part> parts;

  Template({required this.parts});
}
