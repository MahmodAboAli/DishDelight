// ignore_for_file: non_constant_identifier_names, curly_braces_in_flow_control_structures

import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:DISH_DELIGhTS/core/sherdprefs.dart';
import 'package:DISH_DELIGhTS/feachers/main/main_page/feachers/home/models/feedback_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../core/string.dart';
import '../core/userdata.dart';
import '../feachers/Auth/models/user.dart';
import '../feachers/main/main_page/feachers/home/models/needs_model.dart';
import '../feachers/main/main_page/feachers/home/models/shop_list.dart';
import '../feachers/main/meal_detial_page/models/meal_detial_model.dart';

part 'meal_state.dart';

class MealCubit extends Cubit<MealState> {
  MealCubit() : super(MealInitial());
  static MealCubit get(context) => BlocProvider.of(context);

  final db = FirebaseFirestore.instance;

  filterMeals() async {
    print("FilterMealStart");
    emit(loadingMealState());
    str = '';
    var getMainMeals = await db
        .collection("Meals")
        .withConverter(
          fromFirestore: MealDetial.fromFirestore,
          toFirestore: (MealDetial mealDetial, options) =>
              mealDetial.toFirestore(),
        )
        .where("section", isEqualTo: "Main")
        .get();
    mainMeals.clear();
    // print(MainMeal[0].title ?? "noMeal");
    for (var doc in getMainMeals.docs) {
      mainMeals.add(doc.data());
      emit(ChangeValueState());
    }
    var getSweetesMeals = await db
        .collection("Meals")
        .withConverter(
          fromFirestore: MealDetial.fromFirestore,
          toFirestore: (MealDetial mealDetial, options) =>
              mealDetial.toFirestore(),
        )
        .where("section", isEqualTo: "Sweetes")
        .get();
    sweetesMeals.clear();
    for (var doc in getSweetesMeals.docs) {
      sweetesMeals.add(doc.data());
    }
    var getAprrtieMeals = await db
        .collection("Meals")
        .withConverter(
          fromFirestore: MealDetial.fromFirestore,
          toFirestore: (MealDetial mealDetial, options) =>
              mealDetial.toFirestore(),
        )
        .where("section", isEqualTo: "Aprrtie")
        .get();
    aprrtieMeals.clear();
    for (var doc in getAprrtieMeals.docs) {
      aprrtieMeals.add(doc.data());
    }
    emit(AddFavoriteState());
    var getDrinksMeals = await db
        .collection("Meals")
        .withConverter(
          fromFirestore: MealDetial.fromFirestore,
          toFirestore: (MealDetial mealDetial, options) =>
              mealDetial.toFirestore(),
        )
        .where("section", isEqualTo: "Drinks")
        .get();
    drinksMeals.clear();
    for (var doc in getDrinksMeals.docs) {
      drinksMeals.add(doc.data());
    }
    var getCandiesMeals = await db
        .collection("Meals")
        .withConverter(
          fromFirestore: MealDetial.fromFirestore,
          toFirestore: (MealDetial mealDetial, options) =>
              mealDetial.toFirestore(),
        )
        .where("section", isEqualTo: "Candies")
        .get();
    candiesMeals.clear();
    for (var doc in getCandiesMeals.docs) {
      candiesMeals.add(doc.data());
    }
    var getVeginMeals = await db
        .collection("Meals")
        .withConverter(
          fromFirestore: MealDetial.fromFirestore,
          toFirestore: (MealDetial mealDetial, options) =>
              mealDetial.toFirestore(),
        )
        .where("section", isEqualTo: "Vegin")
        .get();
    veginMeals.clear();
    for (var doc in getVeginMeals.docs) {
      veginMeals.add(doc.data());
    }
    // changeListofMeal(indexofsection);
    emit(GetDataState());
  }

  getTrendMeal() async {
    emit(loadingState());
    var BMeal = await db
        .collection("Meals")
        .withConverter(
          fromFirestore: MealDetial.fromFirestore,
          toFirestore: (MealDetial bestmeal, options) => bestmeal.toFirestore(),
        )
        .orderBy('rate', descending: true)
        .get();
    int i = BMeal.docs.length < 3 ? BMeal.docs.length : 3;
    bestMeals.clear();
    for (int j = 0; j < i; j++) {
      bestMeals.add(BMeal.docs[j].data());
    }
    emit(getBestMealState());
  }

  getFeedbacks() async {
    var getFeedbacks = await db
        .collection("Feedback")
        .withConverter(
          fromFirestore: FeedbackModel.fromFirestore,
          toFirestore: (FeedbackModel feedbackModel, options) =>
              feedbackModel.toFirestore(),
        )
        .get();
    feedbacks.clear();
    for (var Feeds in getFeedbacks.docs) {
      feedbacks.add(Feeds.data());
    }
    emit(getFeedbackState());
  }

  getShopList() async {
    var MyNeeds = await db
        .collection("users")
        .doc(userdata.id)
        .collection("needs")
        .withConverter(
          fromFirestore: ShopList.fromFirestore,
          toFirestore: (ShopList shopList, options) => shopList.toFirestore(),
        )
        .get();
    myshopList.clear();
    for (var need in MyNeeds.docs) {
      myshopList.add(Needs_Meal(need.data().needs ?? 0,
          name: need.data().title ?? "Unknown"));
    }
    emit(getShoplistState());
  }

  getData() async {
    str = '';
    String? profile = await getString(STORAGE_USER_PROFILE_KEY);

    if (profile != null) {
      userdata = UserLoginResponseEntity.fromJson(jsonDecode(profile));
    }

    await getTrendMeal();
    emit(loadingMealState());
    Meals.clear();
    var getmeal = await db
        .collection("Meals")
        .withConverter(
          fromFirestore: MealDetial.fromFirestore,
          toFirestore: (MealDetial mealDetial, options) =>
              mealDetial.toFirestore(),
        )
        .get();
    for (var doc in getmeal.docs) {
      Meals.add(doc.data());
    }
    await getShopList();
    await filterMeals();
    // await getFavorite();
    await getFeedbacks();
    emit(GetDataState());
  }

  final ImagePicker picker = ImagePicker();
  File? photo;
  bool addphotoprocces = false;
  Future imgFromGallery(ImageSource imageSource) async {
    try {
      addphotoprocces = true;
      emit(loadingMealState());
      final PickedFile = await picker.pickImage(source: imageSource);
      if (PickedFile != null) {
        photo = File(PickedFile.path);
        await uploadFile();
      } else {
        print("No Image selected");
      }
      addphotoprocces = false;
      log(999999);
      emit(ChangeState());
    } catch (e) {
      print(e);
    }
  }

  bool getImage = false;
  Future getImgUrl(String name) async {
    try {
      final spaceRef =
          // FirebaseStorage.instance.ref("chat").child("path/to/image5.jpg");
          FirebaseStorage.instance.ref("chat").child(photo!.path);
      await spaceRef.getDownloadURL().then((url) => str = url);
      getImage = true;
      emit(ChangeState());
      return str;
    } catch (e) {}
  }

  Future uploadFile() async {
    try {
      final filename = photo!.path;
      final ref = FirebaseStorage.instance.ref("chat").child(filename);
      ref.putFile(photo!).snapshotEvents.listen((event) async {
        await getImgUrl('name');
      });

      emit(ChangeState());
    } catch (e) {
      print(e);
    }
  }

  bool isLogin = false;
  Future<void> saveProfile(UserLoginResponseEntity profile) async {
    isLogin = true;
    await setBool(STORAGE_USER_LOGIN_KEY, true);
    await setString(STORAGE_USER_PROFILE_KEY, jsonEncode(profile));
    // await setToken(profile.accessToken!);
    emit(ChangeState());
  }

  Future<void> onlogout() async {
    isLogin = false;
    await remove(STORAGE_USER_PROFILE_KEY);
    await remove(STORAGE_USER_TOKEN_KEY);
    await remove(STORAGE_USER_LOGIN_KEY);
    await FirebaseAuth.instance.signOut();
    emit(ChangeState());
  }

  // String doc_id = '';
  // String catigoryName = 'Main';
  // String descriptionFeedbacks = '';
  // bool isObscuredpassword = true;
  // List<String> ingredient = [''];
  // bool foundMeal = false;

  // List<String> needs = [];

// ! Step3
  // String title = '';
  // changeRecipe(String Name) {
  //   title = Name;
  //   emit(ChangeRecipeState());
  // }

//!
  // removeFavoriteMeal(MealDetial meal) async {
  //   meal.favorite = false;
  //   await db
  //       .collection("Meals")
  //       .withConverter(
  //         fromFirestore: MealDetial.fromFirestore,
  //         toFirestore: (MealDetial mealDetial, options) =>
  //             mealDetial.toFirestore(),
  //       )
  //       .doc(meal.id)
  //       .update(meal.toFirestore());
  //   getFavorite();
  // }

// ! for remove
  // changeNeedsAmount(double Amount, int index) {
  //   if (Amount + valueOfNeeds[index].need >= 0)
  //     valueOfNeeds[index].need += Amount;
  //   emit(ChangeNeedsAmountState());
  // }
// !

// !for remove

  // addNeeds(String name, double need) async {
  //   try {
  //     ShopList tool = ShopList(title: name, needs: need);
  //     var needs = await db
  //         .collection("users")
  //         .doc(userdata.id)
  //         .collection("needs")
  //         .withConverter(
  //           fromFirestore: ShopList.fromFirestore,
  //           toFirestore: (ShopList shopList, options) => shopList.toFirestore(),
  //         )
  //         .where("title", isEqualTo: name)
  //         .get();

  //     if (needs.docs.isEmpty) {
  //       await db
  //           .collection("users")
  //           .doc(userdata.id)
  //           .collection("needs")
  //           .withConverter(
  //             fromFirestore: ShopList.fromFirestore,
  //             toFirestore: (ShopList shopList, options) =>
  //                 shopList.toFirestore(),
  //           )
  //           .add(tool)
  //           .then((value) => tool.id = value.id);
  //       await db
  //           .collection("users")
  //           .doc(userdata.id)
  //           .collection("needs")
  //           .withConverter(
  //             fromFirestore: ShopList.fromFirestore,
  //             toFirestore: (ShopList shopList, options) =>
  //                 shopList.toFirestore(),
  //           )
  //           .doc(tool.id)
  //           .update(tool.toFirestore());
  //     } else {
  //       var updatetool = await db
  //           .collection("users")
  //           .doc(userdata.id)
  //           .collection("needs")
  //           .withConverter(
  //             fromFirestore: ShopList.fromFirestore,
  //             toFirestore: (ShopList shopList, options) =>
  //                 shopList.toFirestore(),
  //           )
  //           .where("title", isEqualTo: name)
  //           .get();
  //       ShopList tooll = updatetool.docs[0].data();
  //       tool =
  //           ShopList(title: name, needs: tool.needs! + tooll.needs!.toDouble());
  //       emit(ChangeState());
  //       await db
  //           .collection("users")
  //           .doc(userdata.id)
  //           .collection("needs")
  //           .withConverter(
  //             fromFirestore: ShopList.fromFirestore,
  //             toFirestore: (ShopList shopList, options) =>
  //                 shopList.toFirestore(),
  //           )
  //           .doc(tooll.id)
  //           .update(tool.toFirestore());
  //     }
  //     getShopList();
  //     emit(ChangeState());
  //   } catch (e) {
  //     print(e);
  //   }
  // }

  // int pageIndex = 0;
  // ChangePageIndex(int index) {
  //   pageIndex = index;
  //   emit(ChangePageState());
  // }
// !
// ! for remove
//   editprofile(
//       {
//       String photo = '',
//       String FirstName = '',
//       LastName = ''}) async {
//     var x = await db
//         .collection('users')
//         .doc(userdata.id)
//         .withConverter(
//           fromFirestore: UserData.fromFirestore,
//           toFirestore: (UserData userData, options) => userData.toFirestore(),
//         )
//         .get();
//     UserData data = x.data() ?? UserData();
//     if (FirstName != '' && LastName != '') {
//       data.name = '${FirstName} $LastName';
//       userdata.displayName = FirstName + ' ' + LastName;
//     }
//     if (photo != '') {
//       userdata.photoUrl = photo;
//       data.photourl = photo;
//     }
//     await db.collection('users').doc(userdata.id).update(data.toFirestore());
//     await saveProfile(userdata);
//     await printprofile();

//     emit(EditProfileState());
//   }
// !

  // findMeal({required String tit}) async {
  //   var FMeal = await db
  //       .collection("Meals")
  //       .withConverter(
  //         fromFirestore: MealDetial.fromFirestore,
  //         toFirestore: (MealDetial Mealforadd, options) =>
  //             Mealforadd.toFirestore(),
  //       )
  //       .where('title', isEqualTo: tit)
  //       .get();
  //   if (FMeal.docs.isNotEmpty) {
  //     foundMeal = true;
  //   } else {
  //     foundMeal = false;
  //   }
  //   emit(getMealForAddState());
  // }

  // Future<bool> setList(String key, List<String> value) async {
  //   final _prefs = await SharedPreferences.getInstance();

  //   return await _prefs.setStringList(key, value);
  // }

  // Future<List?> getList(String key) async {
  //   final _prefs = await SharedPreferences.getInstance();
  //   return _prefs.getStringList(key);
  // }

  // Future<void> remove(String key) async {
  //   final _prefs = await SharedPreferences.getInstance();
  //   _prefs.remove(key);
  // }

  // bool isGetStart = false;
  // Future<void> ongetStart() async {
  //   await setBool(STORAGE_USER_GETSTART_KEY, true);
  //   isGetStart = true;
  //   emit(ChangeState());
  // }

  // bool valuea = true;
  // bool valueb = false;
  // void recipecolor() {
  //   if (valuea == true) {
  //     valueb = false;
  //   } else {
  //     valuea = true;
  //     valueb = false;
  //   }
  //   emit(RecipeColorState());
  // }

  // void feedbackcolor() {
  //   if (valueb == true) {
  //     valuea = false;
  //   } else {
  //     valueb = true;
  //     valuea = false;
  //   }
  //   emit(FeedbackColorState());
  // }

//   sendMessage() async {
//     emit(loadingState());
//     String sendContent = textController.text;
//     final content = Msgcontent(
//       uid: 'token',
//       content: sendContent,
//       type: "text",
//       addtime: Timestamp.now(),
//     );
//     msgcontentList.clear();
//     await db
//         .collection("Meals")
//         .doc(doc_id)
//         .collection("msglist")
//         .withConverter(
//           fromFirestore: Msgcontent.fromFirestore,
//           toFirestore: (Msgcontent msgcontent, options) =>
//               msgcontent.toFirestore(),
//         )
//         .add(content)
//         .then((DocumentReference doc) {
//       print("Document snapshot added with id,${doc.id}");
//     });
//     textController.clear();
//     listenMessage();
//     emit(SendMessageSuccess());
//   }

  // listenMessage() {
  //   emit(loadingState());
  //   try {
  //     // var listener;
  //     var messages = db
  //         .collection("Meals")
  //         .doc(doc_id)
  //         .collection("msglist")
  //         .withConverter(
  //           fromFirestore: Msgcontent.fromFirestore,
  //           toFirestore: (Msgcontent msgcontent, options) =>
  //               msgcontent.toFirestore(),
  //         )
  //         .orderBy("addtime", descending: true);
  //     msgcontentList.clear();
  //     // listener =
  //     messages.snapshots().listen((event) {
  //       for (var change in event.docChanges) {
  //         switch (change.type) {
  //           case DocumentChangeType.added:
  //             if (change.doc.data() != null) {
  //               print("type:${change.doc.data()!.content}");
  //               msgcontentList.add(change.doc.data() ??
  //                   Msgcontent(
  //                       type: "text",
  //                       content: 'null',
  //                       addtime: Timestamp.now(),
  //                       uid: 'null'));
  //             }
  //             break;
  //           case DocumentChangeType.modified:
  //             break;
  //           case DocumentChangeType.removed:
  //             break;
  //         }
  //       }
  //       emit(SendMessageSuccess());
  //     }, onError: (error) => print("listen fialed: $error"));
  //   } catch (e) {
  //     print(e);
  //   }
  //   emit(ListenMessageSuccess());
  // }

  // GoChat(String id) async {
  //   emit(loadingState());
  //   var message = await db
  //       .collection("Meals")
  //       .withConverter(
  //         fromFirestore: MealDetial.fromFirestore,
  //         toFirestore: (MealDetial meal, options) => meal.toFirestore(),
  //       )
  //       .where("id", isEqualTo: id)
  //       .get();
  //   doc_id = message.docs.first.id;
  //   await listenMessage();
  //   emit(GetMessagesSuccess());
  // }

  // !LogIn

  // final db = FirebaseFirestore.instance;

//   TextEditingController userEmail = TextEditingController();
//   TextEditingController userPassword = TextEditingController();
//   TextEditingController userConfirm = TextEditingController();
//   TextEditingController userName = TextEditingController();
//   TextEditingController lastUserName = TextEditingController();
//   String token = '';
//   bool oboscurypass = true;
//   bool oboscurycon = true;

//   GoogleSignIn googleSignIn = GoogleSignIn(
//     scopes: [
//       'email',
//       'https://www.googleapis.com/auth/contacts.readonly',
//     ],
//   );

//   bool login = true;
//   obscurypassword() {
//     oboscurypass = !oboscurypass;
//     emit(Changeobscurypass());
//   }

//   obscuryconfige() {
//     oboscurycon = !oboscurycon;
//     emit(Changeobscurycon());
//   }

//   changeLogin() {
//     login = !login;
//     emit(ChangeState());
//   }

//   bool doneLogin = false;
//   String idtoken = 'no image';
//   bool finduser = false;
//   fonduser({
//     required context,
//     required String email,
//     required String password,
//     required bool create,
//   }) async {
//     emit(loadingState());

//     var loginUser = await db
//         .collection("users")
//         .withConverter(
//           fromFirestore: UserData.fromFirestore,
//           toFirestore: (UserData user, options) => user.toFirestore(),
//         )
//         .where("email", isEqualTo: email)
//         .where("password", isEqualTo: password)
//         .get();
//     if (loginUser.docs.isNotEmpty) {
//       finduser = true;
//       showDialog(
//         context: context,
//         builder: (context) {
//           return const AlertDialog(
//             title: Text("authintication error"),
//             icon: Icon(Icons.error),
//             content: Text("The account is already used"),
//           );
//         },
//       );
//     } else {
//       finduser = false;
//     }
//     emit(finduserstate());
//   }

//   String id = '';
//   Future<void> authenticate(
//       {required context,
//       required String email,
//       required String password,
//       required bool create,
//       String displayName = '',
//       bool save = false}) async {
//     try {
//       emit(loadingState());
//       final prefs = await SharedPreferences.getInstance();
//       UserData? data;
//       String doc = '';
//       if (!save) {
//         if (!create) {
//           doneLogin = true;
//           var loginUser = await db
//               .collection("users")
//               .withConverter(
//                 fromFirestore: UserData.fromFirestore,
//                 toFirestore: (UserData user, options) => user.toFirestore(),
//               )
//               .where("email", isEqualTo: email)
//               .where("password", isEqualTo: password)
//               .get();
//           if (loginUser.docs.isEmpty) {
//             doneLogin = false;
//             showDialog(
//               context: context,
//               builder: (context) {
//                 return const AlertDialog(
//                   title: Text("authintication error"),
//                   icon: Icon(Icons.error),
//                   content: Text("The user isn't founded"),
//                 );
//               },
//             );
//           } else {
//             await FirebaseAuth.instance
//                 .signInWithEmailAndPassword(email: email, password: password)
//                 .then((value) => id = value.user!.uid)
//                 .catchError((e) {
//               doneLogin = false;
//               showDialog(
//                 context: context,
//                 builder: (context) {
//                   return AlertDialog(
//                     title: const Text("authintication error"),
//                     icon: const Icon(Icons.error),
//                     content: Text(e.toString()),
//                   );
//                 },
//               );
//             });
//             if (doneLogin) {
//               var userbase = await db
//                   .collection("users")
//                   .withConverter(
//                     fromFirestore: UserData.fromFirestore,
//                     toFirestore: (UserData userDaa, options) =>
//                         userDaa.toFirestore(),
//                   )
//                   .where("email", isEqualTo: email)
//                   .where("password", isEqualTo: password)
//                   .get();
//               print("userbase.lenght=${userbase.docs.length}");
//               UserLoginResponseEntity userProfile = UserLoginResponseEntity();
//               userProfile.photoUrl = '';
//               userProfile.email = userbase.docs[0].data().email;
//               userProfile.id = userbase.docs[0].data().doc_id;
//               userProfile.accessToken = userbase.docs[0].data().id;
//               userProfile.photoUrl = userbase.docs[0].data().photourl;
//               userProfile.displayName = userbase.docs[0].data().name;
//               doneLogin = true;
//               print('userProfile');
//               print(userProfile.photoUrl);
//               await saveProfile(userProfile);
//               await prefs.setBool(STORAGE_USER_LOGIN_KEY, true);
//               // await printprofile();
//               // https://firebasestorage.googleapis.com/v0/b/sanadtest-1a117.appspot.com/o/chat%2Fpath%2Fto%2Fimage5.jpg?alt=media&token=86c446ba-8a28-4d86-8edd-1266d0463b47
//               // https://firebasestorage.googleapis.com/v0/b/sanadtest-1a117.appspot.com/o/chat%2Fpath%2Fto%2Fimage5.jpg?alt=media&token=7f057366-7f72-4b8a-bb22-e18fdefc4613
//               emit(GetProfileState());
//             }
//           }
//         } else {
//           doneLogin = true;
//           await FirebaseAuth.instance
//               .createUserWithEmailAndPassword(email: email, password: password)
//               .then((value) => id = value.user!.uid)
//               .catchError((e) {
//             doneLogin = false;
//             emit(ChangeState());
//             showDialog(
//               context: context,
//               builder: (context) {
//                 return AlertDialog(
//                   title: const Text("authintication error"),
//                   icon: const Icon(Icons.error),
//                   content: Text(e.toString()),
//                 );
//               },
//             );
//           });
//         }
//       } else {
//         data = UserData(
//             password: password,
//             id: id,
//             doc_id: doc,
//             name: displayName,
//             email: email,
//             photourl: str,
//             addtime: Timestamp.now());
//         await db
//             .collection("users")
//             .withConverter(
//               fromFirestore: UserData.fromFirestore,
//               toFirestore: (UserData userData, options) =>
//                   userData.toFirestore(),
//             )
//             .add(data)
//             .then((value) => doc = value.id);
//         // https://firebasestorage.googleapis.com/v0/b/sanadtest-1a117.appspot.com/o/chat%2Fpath%2Fto%2Fimage5.jpg?alt=media&token=4aa835f0-59f8-4f34-90fe-79d790d60f85
//         // https://firebasestorage.googleapis.com/v0/b/sanadtest-1a117.appspot.com/o/chat%2Fpath%2Fto%2Fimage5.jpg?alt=media&token=6eabb80d-e768-4989-aeba-7cbc52840203
//         data.doc_id = doc;
//         await db
//             .collection("users")
//             .doc(doc)
//             .withConverter(
//               fromFirestore: UserData.fromFirestore,
//               toFirestore: (UserData userData, options) =>
//                   userData.toFirestore(),
//             )
//             .update(data.toFirestore());
//         print("email:$email,password:$password,id:$id,doc:$doc,str:$str");
//         UserLoginResponseEntity userProfile = UserLoginResponseEntity();
//         userProfile.email = email;
//         userProfile.accessToken = id;
//         userProfile.id = doc;
//         userProfile.displayName = displayName;
//         userProfile.photoUrl = str;
//         emit(setDataprofileState());
//         await saveProfile(userProfile);
//         await prefs.setBool(STORAGE_USER_LOGIN_KEY, true);
//         // str = '';
//         emit(ChangeState());
//       }
//       // String userCredential = FirebaseAuth.instance.;
//       // String Email = email;
//       // print(idtoken);
//       emit(ChangeState());
//     } catch (e) {
//       print("error is $e");
//     }
//   }

  // Future<void> signUp(String email, String password) async {
  //   return await authenticate(email, password, "signUp");
  // }

  // Future<void> login(String email, String password) async {
  //   return await authenticate(email, password, "signInWithPassword");
  // }

  // Future<void> handleSignin() async {
  //   try {
  //     final prefs = await SharedPreferences.getInstance();
  //     var user = await googleSignIn.signIn();
  //     if (user != null) {
  //       final gAuthentication = await user.authentication;
  //       final credential = GoogleAuthProvider.credential(
  //           idToken: gAuthentication.idToken,
  //           accessToken: gAuthentication.accessToken);
  //       await FirebaseAuth.instance.signInWithCredential(credential);
  //       String displayName = user.displayName ?? user.email;
  //       String email = user.email;
  //       String id = user.id;
  //       String photoUrl = user.photoUrl ?? "";
  //       // token =(await getString(STORAGE_USER_PROFILE_KEY))!;
  //       var userbase = await db
  //           .collection("users")
  //           .withConverter(
  //             fromFirestore: UserData.fromFirestore,
  //             toFirestore: (UserData userData, options) =>
  //                 userData.toFirestore(),
  //           )
  //           .where("id", isEqualTo: id)
  //           .get();
  //       if (userbase.docs.isEmpty) {
  //         var doc = '';
  //         final data = UserData(
  //             doc_id: doc,
  //             id: id,
  //             name: displayName,
  //             email: email,
  //             photourl: photoUrl,
  //             addtime: Timestamp.now());
  //         await db
  //             .collection("users")
  //             .withConverter(
  //               fromFirestore: UserData.fromFirestore,
  //               toFirestore: (UserData userData, options) =>
  //                   userData.toFirestore(),
  //             )
  //             .add(data)
  //             .then((value) => doc = value.id);
  //         await db
  //             .collection("users")
  //             .doc(doc)
  //             .withConverter(
  //               fromFirestore: UserData.fromFirestore,
  //               toFirestore: (UserData userData, options) =>
  //                   userData.toFirestore(),
  //             )
  //             .update(data.toFirestore());

  //         UserLoginResponseEntity userProfile = UserLoginResponseEntity();
  //         userProfile.email = email;
  //         userProfile.accessToken = id;
  //         userProfile.displayName = displayName;
  //         userProfile.photoUrl = photoUrl;
  //         userProfile.id = doc;
  //         await saveProfile(userProfile);
  //       }
  //       googleSignIn.signOut();
  //       emit(SuccessLogInState());
  //     }
  //     await prefs.setBool(STORAGE_USER_LOGIN_KEY, true);
  //   } catch (e) {
  //     print('there are an error:');
  //     print(e);
  //   }
  // }

  // Future<bool> setString(String key, String value) async {
  //   final _prefs = await SharedPreferences.getInstance();
  //   await _prefs.remove(key);
  //   return await _prefs.setString(key, value);
  // }

  // Future<void> setBool(String key, bool value) async {
  //   final _prefs = await SharedPreferences.getInstance();
  //   await _prefs.setBool(key, value);
  //   emit(ChangeState());
  // }

  // Future<bool> setList(String key, List<String> value) async {
  //   final _prefs = await SharedPreferences.getInstance();

  //   return await _prefs.setStringList(key, value);
  // }

  // Future<String?> getString(String key) async {
  //   final _prefs = await SharedPreferences.getInstance();
  //   return _prefs.getString(key);
  // }

  // Future<List?> getList(String key) async {
  //   final _prefs = await SharedPreferences.getInstance();
  //   return _prefs.getStringList(key);
  // }

  // Future<void> remove(String key) async {
  //   final _prefs = await SharedPreferences.getInstance();
  //   _prefs.remove(key);
  // }

  // Future<void> setToken(String value) async {
  //   await setString(STORAGE_USER_TOKEN_KEY, value);
  //   token = value;
  //   emit(ChangeState());
  // }

  // bool isGetStart = false;
  // Future<void> ongetStart() async {
  //   await setBool(STORAGE_USER_GETSTART_KEY, true);
  //   isGetStart = true;
  //   emit(ChangeState());
  // }

  // Future<String?> getProfile() async {
  //   return await getString(STORAGE_USER_PROFILE_KEY);
  // }

  // bool isLogin = false;
  // Future<void> saveProfile(UserLoginResponseEntity profile) async {
  //   isLogin = true;
  //   await setBool(STORAGE_USER_LOGIN_KEY, true);
  //   await setString(STORAGE_USER_PROFILE_KEY, jsonEncode(profile));
  //   emit(GetProfileState());
  // }

  // Future<void> onlogout() async {
  //   isLogin = false;
  //   await remove(STORAGE_USER_PROFILE_KEY);
  //   await remove(STORAGE_USER_TOKEN_KEY);
  //   await remove(STORAGE_USER_LOGIN_KEY);
  //   await FirebaseAuth.instance.signOut();
  //   await googleSignIn.signOut();
  //   token = '';
  //   emit(ChangeState());
  // }
}
