class Album{
  final String? image;

  Album({this.image});

  factory Album.fromJson(Map<String, dynamic> json){
    return Album(
      image:json['image']
    );
  }
}