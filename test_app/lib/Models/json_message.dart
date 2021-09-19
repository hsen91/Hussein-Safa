class JsonMessage{
  final int? id;
  final String? message;

  JsonMessage({this.id, this.message});

  factory JsonMessage.fromJson(Map<String, dynamic> json){
    return JsonMessage(
      id:json['id'],
      message:json['message'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data["id"] = id;
    data["message"] = message;
    return data;
  }
}