import 'package:cloud_firestore/cloud_firestore.dart';

class ShopList {
  final double? needs;
  final String? title;
    String? id;
  ShopList({
    this.id,
    this.needs,
    this.title,
  });

  factory ShopList.fromFirestore(
      DocumentSnapshot<Map<String, dynamic>> snapshot,
      SnapshotOptions? options) {
    final data = snapshot.data();
    return ShopList(
      needs: data?['needs'],
      id: data?['id'],
      title: data?['title'],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      if (title != null) "title": title,
      if (id != null) "id": id,
      if (needs != null) "needs": needs,
    };
  }
}
