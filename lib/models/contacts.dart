class ContactsModel {
  String? name;
  String? email;
  String? lastMessage;

  ContactsModel({this.name, this.email, this.lastMessage});

  factory ContactsModel.fromJson(Map<String, dynamic> json) =>
      ContactsModel(name: json["Name"], email: json["Email"]);
}
