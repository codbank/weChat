import 'dart:convert';

class UserPerson {
  int id;
  String account;
  String password;
  UserPerson({this.id, this.account, this.password});

  factory UserPerson.formMap(Map<String, dynamic> json) => new UserPerson(
        id: json['id'],
        account: json['account'],
        password: json['password'],
      );

  Map<String, dynamic> toMap() =>
      {'id': id, 'account': account, 'password': password};
}


UserPerson userPersonFromJson(String str){
  final jsonData = json.decode(str);
  return jsonData;
}


String userPersonToJson(UserPerson data){
  final userPersonData = data.toMap();
  return json.encode(userPersonData);
}