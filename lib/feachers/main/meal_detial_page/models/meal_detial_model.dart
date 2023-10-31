import 'package:cloud_firestore/cloud_firestore.dart';

class MealDetial {
  final String? src;
  String? id;
  double? rate;
  int? numOfrate;
  final String? userid;
  final String? title;
  final String? section;
  final String? time;
  final String? descreption;
  final List? steps;
  final List? ingredient;
  final List? valueOfIngredient;
  bool? favorite;
  MealDetial(
      {this.userid,
      this.valueOfIngredient,
      this.numOfrate,
      this.rate,
      this.favorite = false,
      this.ingredient,
      this.steps,
      this.descreption,
      this.id,
      this.src,
      this.title,
      this.section,
      this.time});

  factory MealDetial.fromFirestore(
      DocumentSnapshot<Map<String, dynamic>> snapshot,
      SnapshotOptions? options) {
    final data = snapshot.data();
    return MealDetial(
      id: data?['id'],
      numOfrate: data?['numOfrate'],
      rate: data?['rate'],
      userid: data?['userid'],
      favorite: data?['favorite'],
      steps: data?['steps'],
      ingredient: data?['ingredient'],
      valueOfIngredient: data?['valueOfIngredient'],
      descreption: data?['descreption'],
      src: data?['src'],
      title: data?['title'],
      section: data?['section'],
      time: data?['time'],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      if (favorite != null) "favorite": favorite,
      if (numOfrate != null) "numOfrate": numOfrate,
      if (rate != null) "rate": rate,
      if (userid != null) "userid": userid,
      if (id != null) "id": id,
      if (ingredient != null) "ingredient": ingredient,
      if (valueOfIngredient != null) "valueOfIngredient": valueOfIngredient,
      if (title != null) "title": title,
      if (src != null) "src": src,
      if (section != null) "section": section,
      if (time != null) "time": time,
      if (descreption != null) "descreption": descreption,
      if (steps != null) "steps": steps,
    };
  }
}
