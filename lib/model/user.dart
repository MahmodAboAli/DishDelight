import 'package:cloud_firestore/cloud_firestore.dart';

class UserData {
  final String? id;
  String? doc_id;
  String? name;
  String? email;
  String? password;
  String? photourl;
  final Timestamp? addtime;

  UserData(
      {this.id,
      this.doc_id,
      this.password,
      this.name,
      this.email,
      this.photourl,
      this.addtime});
  factory UserData.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return UserData(
        id: data?['id'],
        password: data?['password'],
        doc_id: data?['doc_id'],
        name: data?['name'],
        email: data?['email'],
        photourl: data?['photourl'],
        addtime: data?['addtime']);
  }
  Map<String, dynamic> toFirestore() {
    return {
      if (id != null) "id": id,
      if (password != null) "password": password,
      if (doc_id != null) "doc_id": doc_id,
      if (name != null) "name": name,
      if (email != null) "email": email,
      if (photourl != null) "photourl": photourl,
      if (addtime != null) "addtime": addtime,
    };
  }
}

class UserLoginResponseEntity {
  String? accessToken;
  String? displayName;
  String? email;
  String? photoUrl;
  String? id;

  UserLoginResponseEntity(
      {this.accessToken, this.id, this.displayName, this.email, this.photoUrl});
  factory UserLoginResponseEntity.fromJson(Map<String, dynamic> json) =>
      UserLoginResponseEntity(
        accessToken: json["access_token"],
        displayName: json["displayName"],
        email: json["email"],
        photoUrl: json["photoUrl"],
        id: json["id"],
      );
  Map<String, dynamic> toJson() => {
        "access_token": accessToken,
        "displayName": displayName,
        "email": email,
        "photoUrl": photoUrl,
        "id": id,
      };
}

class MeListItem {
  String? name;
  String? icon;
  String? explain;
  String? route;
  MeListItem({
    this.name,
    this.icon,
    this.explain,
    this.route,
  });
  factory MeListItem.fromJson(Map<String, dynamic> json) => MeListItem(
        name: json["name"],
        icon: json["icon"],
        explain: json["explain"],
        route: json["route"],
      );
}
