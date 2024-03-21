class ContactsModel {
  String? name;
  String? email;
  String? lastMessage;
  String? contactId;

  ContactsModel({this.name, this.email, this.lastMessage, this.contactId});

  factory ContactsModel.fromJson(Map<String, dynamic> json) =>
      ContactsModel(name: json["Name"], email: json["Email"]);
}
