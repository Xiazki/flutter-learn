class ClassifyValue {
  ClassifyValue(String this.title, String this.imageUrl, String this.des,
      String this.startTime, String this.endTime);

  String? title;
  String? imageUrl;
  String? des;
  String? startTime;
  String? endTime;

  getTitle() => this.title;
  getImageUrls() => this.imageUrl;
}
