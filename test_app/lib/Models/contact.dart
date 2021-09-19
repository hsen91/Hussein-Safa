class Contact{
  final String? name;
  final String? email;
  final String? phone;
  final String? message;

  Contact(this.name, this.email, this.phone, this.message);


  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data["name"] = name;
    data["email"] = email;
    data['phone'] = phone;
    data['message'] = message;
    return data;
  }
}