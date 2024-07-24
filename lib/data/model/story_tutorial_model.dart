class StoryTutorialModel {
  final String title;
  final String content;
  final String? subContent;
  final String image;
  final bool isNeed;

  StoryTutorialModel(
      {required this.title,
      this.subContent = '',
      required this.content,
       this.image ='',
      required this.isNeed});
}
