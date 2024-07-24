class FAQModel {
  final String title;
  final String content;
  final String highlightText;
  final bool underline;

  FAQModel(
      {required this.title,
      required this.content,
      this.highlightText = '',
      this.underline = false});
}
