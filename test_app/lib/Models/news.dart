class News{
  final String? title;
  final String? date;
  final String? image;
  final String? text;

  News({this.title, this.date, this.image, this.text});

  factory News.fromJson(Map<String, dynamic> json){
    return News(
      title:json['title'],
      date:json['date'],
      image:json['image'],
      text:json['text']
    );
  }
}