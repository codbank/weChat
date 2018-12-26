import 'dart:convert';

class AuthModel {
  int id;
  String uuid;
  AuthModel({this.id, this.uuid});

  factory AuthModel.formMap(Map<String, dynamic> json) =>
      new AuthModel(id: json['id'], uuid: json['uuid']);

  Map<String, dynamic> toMap() => {'id': id, 'uuid': uuid};
}

AuthModel authModelFromJson(String str) {
  final jsonData = json.decode(str);
  return jsonData;
}

String authModelToJson(AuthModel data) {
  final authModelData = data.toMap();
  return json.encode(authModelData);
}
