import 'package:cloud_firestore/cloud_firestore.dart';

class FeedbackModel {
  final String? photo;
  final String? src;
  final double? rate;
  String? id;
  String? mealId;
  final String? title;
  final String? section;
  final String? name;
  final String? descreption;
  FeedbackModel(
      {this.descreption,
      this.photo,
      this.id,
      this.rate,
      this.mealId,
      this.src,
      this.title,
      this.section,
      this.name});

  factory FeedbackModel.fromFirestore(
      DocumentSnapshot<Map<String, dynamic>> snapshot,
      SnapshotOptions? options) {
    final data = snapshot.data();
    return FeedbackModel(
      id: data?['id'],
      mealId: data?['mealId'],
      photo: data?['photo'],
      rate: data?['rate'],
      descreption: data?['descreption'],
      src: data?['src'],
      title: data?['title'],
      section: data?['section'],
      name: data?['name'],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      if (id != null) "id": id,
      if (photo != null) "photo": photo,
      if (mealId != null) "mealId": mealId,
      if (rate != null) "rate": rate,
      if (title != null) "title": title,
      if (src != null) "src": src,
      if (section != null) "section": section,
      if (name != null) "name": name,
      if (descreption != null) "descreption": descreption,
    };
  }
}
