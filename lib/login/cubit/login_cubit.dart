// // ignore_for_file: body_might_complete_normally_catch_error

// import 'dart:convert';
// import 'dart:io';

// import 'package:bloc/bloc.dart';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:google_sign_in/google_sign_in.dart';
// import 'package:meta/meta.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// import '../../core/string.dart';
// import '../../model/user.dart';

// part 'login_state.dart';

// class LoginCubit extends Cubit<LoginState> {
//   LoginCubit() : super(LoginInitial());
//   static LoginCubit get(context) => BlocProvider.of(context);

// //   final db = FirebaseFirestore.instance;

// //   TextEditingController userEmail = TextEditingController();
// //   TextEditingController userPassword = TextEditingController();
// //   TextEditingController userConfirm = TextEditingController();
// //   TextEditingController userName = TextEditingController();
// //   TextEditingController lastUserName = TextEditingController();
// //   String token = '';
// //   bool oboscurypass = true;
// //   bool oboscurycon = true;

// //   GoogleSignIn googleSignIn = GoogleSignIn(
// //     scopes: [
// //       'email',
// //       'https://www.googleapis.com/auth/contacts.readonly',
// //     ],
// //   );

// //   bool login = true;
// //   obscurypassword() {
// //     oboscurypass = !oboscurypass;
// //     emit(Changeobscurypass());
// //   }

// //   obscuryconfige() {
// //     oboscurycon = !oboscurycon;
// //     emit(Changeobscurycon());
// //   }

// //   changeLogin() {
// //     login = !login;
// //     emit(ChangeState());
// //   }

// // //! this is for testing its start here
// //   String str = '';
// //   final ImagePicker picker = ImagePicker();
// //   File? photo;
// //   bool addphotoprocces = false;
  
// //   Future imgFromGallery(ImageSource imageSource) async {
// //     try {
// //       emit(loadingState());
// //       final PickedFile = await picker.pickImage(source: imageSource);
// //       if (PickedFile != null) {
// //         photo = File(PickedFile.path);
// //         await uploadFile();
// //       } else {
// //         print("No Image selected");
// //       }
// //       emit(ChangeState());
// //     } catch (e) {
// //       print(e);
// //     }
// //   }

// //   // List<String> steps = [];
// //   bool getImage = false;
// //   Future getImgUrl(String name) async {
// //     try {
// //       final spaceRef =
// //           // FirebaseStorage.instance.ref("chat").child("path/to/image5.jpg");
// //           FirebaseStorage.instance.ref("chat").child(photo!.path);
// //       await spaceRef.getDownloadURL().then((url) => str = url);
// //       getImage = true;
// //       emit(ChangeState());
// //       return str;
// //     } catch (e) {}
// //   }

// //   Future uploadFile() async {
// //     try {
// //       final filename = photo!.path;
// //       final ref = FirebaseStorage.instance.ref("chat").child(filename);
// //       ref.putFile(photo!).snapshotEvents.listen((event) async {
// //         await getImgUrl('name');
// //       });

// //       emit(ChangeState());
// //     } catch (e) {
// //       print(e);
// //     }
// //   }
// // //! and end here
// //   bool doneLogin = false;
// //   String idtoken = 'no image';
// //   bool finduser = false;
// //   fonduser({
// //     required context,
// //     required String email,
// //     required String password,
// //     required bool create,
// //   }) async {
// //     emit(loadingState());

// //     var loginUser = await db
// //         .collection("users")
// //         .withConverter(
// //           fromFirestore: UserData.fromFirestore,
// //           toFirestore: (UserData user, options) => user.toFirestore(),
// //         )
// //         .where("email", isEqualTo: email)
// //         .where("password", isEqualTo: password)
// //         .get();
// //     if (loginUser.docs.isNotEmpty) {
// //       finduser = true;
// //       showDialog(
// //         context: context,
// //         builder: (context) {
// //           return const AlertDialog(
// //             title: Text("authintication error"),
// //             icon: Icon(Icons.error),
// //             content: Text("The account is already used"),
// //           );
// //         },
// //       );
// //     } else {
// //       finduser = false;
// //     }
// //     emit(finduserstate());
// //   }

// //   // printprofile() async {
// //   //   // final prefs = await SharedPreferences.getInstance();
// //   //   String? profile = await getProfile();
// //   //   userdata = UserLoginResponseEntity.fromJson(jsonDecode(profile!));
// //   //   // emit(ChangeCategoryState());
// //   // }

// //   String id = '';
// //   Future<void> authenticate(
// //       {required context,
// //       required String email,
// //       required String password,
// //       required bool create,
// //       String displayName = '',
// //       bool save = false}) async {
// //     try {
// //       emit(loadingState());
// //       final prefs = await SharedPreferences.getInstance();
// //       UserData? data;
// //       String doc = '';
// //       if (!save) {
// //         if (!create) {
// //           doneLogin = true;
// //           var loginUser = await db
// //               .collection("users")
// //               .withConverter(
// //                 fromFirestore: UserData.fromFirestore,
// //                 toFirestore: (UserData user, options) => user.toFirestore(),
// //               )
// //               .where("email", isEqualTo: email)
// //               .where("password", isEqualTo: password)
// //               .get();
// //           if (loginUser.docs.isEmpty) {
// //             doneLogin = false;
// //             showDialog(
// //               context: context,
// //               builder: (context) {
// //                 return const AlertDialog(
// //                   title: Text("authintication error"),
// //                   icon: Icon(Icons.error),
// //                   content: Text("The user isn't founded"),
// //                 );
// //               },
// //             );
// //           } else {
// //             await FirebaseAuth.instance
// //                 .signInWithEmailAndPassword(email: email, password: password)
// //                 .then((value) => id = value.user!.uid)
// //                 .catchError((e) {
// //               doneLogin = false;
// //               showDialog(
// //                 context: context,
// //                 builder: (context) {
// //                   return AlertDialog(
// //                     title: const Text("authintication error"),
// //                     icon: const Icon(Icons.error),
// //                     content: Text(e.toString()),
// //                   );
// //                 },
// //               );
// //             });
// //             if (doneLogin) {
// //               var userbase = await db
// //                   .collection("users")
// //                   .withConverter(
// //                     fromFirestore: UserData.fromFirestore,
// //                     toFirestore: (UserData userDaa, options) =>
// //                         userDaa.toFirestore(),
// //                   )
// //                   .where("email", isEqualTo: email)
// //                   .where("password", isEqualTo: password)
// //                   .get();
// //               print("userbase.lenght=${userbase.docs.length}");
// //               UserLoginResponseEntity userProfile = UserLoginResponseEntity();
// //               userProfile.photoUrl = '';
// //               userProfile.email = userbase.docs[0].data().email;
// //               userProfile.id = userbase.docs[0].data().doc_id;
// //               userProfile.accessToken = userbase.docs[0].data().id;
// //               userProfile.photoUrl = userbase.docs[0].data().photourl;
// //               userProfile.displayName = userbase.docs[0].data().name;
// //               doneLogin = true;
// //               print('userProfile');
// //               print(userProfile.photoUrl);
// //               await saveProfile(userProfile);
// //               await prefs.setBool(STORAGE_USER_LOGIN_KEY, true);
// //               // await printprofile();
// //               // https://firebasestorage.googleapis.com/v0/b/sanadtest-1a117.appspot.com/o/chat%2Fpath%2Fto%2Fimage5.jpg?alt=media&token=86c446ba-8a28-4d86-8edd-1266d0463b47
// //               // https://firebasestorage.googleapis.com/v0/b/sanadtest-1a117.appspot.com/o/chat%2Fpath%2Fto%2Fimage5.jpg?alt=media&token=7f057366-7f72-4b8a-bb22-e18fdefc4613
// //               emit(GetProfileState());
// //             }
// //           }
// //         } else {
// //           doneLogin = true;
// //           await FirebaseAuth.instance
// //               .createUserWithEmailAndPassword(email: email, password: password)
// //               .then((value) => id = value.user!.uid)
// //               .catchError((e) {
// //             doneLogin = false;
// //             emit(ChangeState());
// //             showDialog(
// //               context: context,
// //               builder: (context) {
// //                 return AlertDialog(
// //                   title: const Text("authintication error"),
// //                   icon: const Icon(Icons.error),
// //                   content: Text(e.toString()),
// //                 );
// //               },
// //             );
// //           });
// //         }
// //       } else {
// //         data = UserData(
// //             password: password,
// //             id: id,
// //             doc_id: doc,
// //             name: displayName,
// //             email: email,
// //             photourl: str,
// //             addtime: Timestamp.now());
// //         await db
// //             .collection("users")
// //             .withConverter(
// //               fromFirestore: UserData.fromFirestore,
// //               toFirestore: (UserData userData, options) =>
// //                   userData.toFirestore(),
// //             )
// //             .add(data)
// //             .then((value) => doc = value.id);
// //         // https://firebasestorage.googleapis.com/v0/b/sanadtest-1a117.appspot.com/o/chat%2Fpath%2Fto%2Fimage5.jpg?alt=media&token=4aa835f0-59f8-4f34-90fe-79d790d60f85
// //         // https://firebasestorage.googleapis.com/v0/b/sanadtest-1a117.appspot.com/o/chat%2Fpath%2Fto%2Fimage5.jpg?alt=media&token=6eabb80d-e768-4989-aeba-7cbc52840203
// //         data.doc_id = doc;
// //         await db
// //             .collection("users")
// //             .doc(doc)
// //             .withConverter(
// //               fromFirestore: UserData.fromFirestore,
// //               toFirestore: (UserData userData, options) =>
// //                   userData.toFirestore(),
// //             )
// //             .update(data.toFirestore());
// //         print("email:$email,password:$password,id:$id,doc:$doc,str:$str");
// //         UserLoginResponseEntity userProfile = UserLoginResponseEntity();
// //         userProfile.email = email;
// //         userProfile.accessToken = id;
// //         userProfile.id = doc;
// //         userProfile.displayName = displayName;
// //         userProfile.photoUrl = str;
// //         emit(setDataprofileState());
// //         await saveProfile(userProfile);
// //         await prefs.setBool(STORAGE_USER_LOGIN_KEY, true);
// //         // str = '';
// //         emit(ChangeState());
// //       }
// //       // String userCredential = FirebaseAuth.instance.;
// //       // String Email = email;
// //       // print(idtoken);

// //       emit(ChangeState());
// //     } catch (e) {
// //       print("error is $e");
// //     }
// //   }

// //   // Future<void> signUp(String email, String password) async {
// //   //   return await authenticate(email, password, "signUp");
// //   // }

// //   // Future<void> login(String email, String password) async {
// //   //   return await authenticate(email, password, "signInWithPassword");
// //   // }

// //   Future<void> handleSignin() async {
// //     try {
// //       final prefs = await SharedPreferences.getInstance();
// //       var user = await googleSignIn.signIn();
// //       if (user != null) {
// //         final gAuthentication = await user.authentication;
// //         final credential = GoogleAuthProvider.credential(
// //             idToken: gAuthentication.idToken,
// //             accessToken: gAuthentication.accessToken);
// //         await FirebaseAuth.instance.signInWithCredential(credential);
// //         String displayName = user.displayName ?? user.email;
// //         String email = user.email;
// //         String id = user.id;
// //         String photoUrl = user.photoUrl ?? "";
// //         // token =(await getString(STORAGE_USER_PROFILE_KEY))!;
// //         var userbase = await db
// //             .collection("users")
// //             .withConverter(
// //               fromFirestore: UserData.fromFirestore,
// //               toFirestore: (UserData userData, options) =>
// //                   userData.toFirestore(),
// //             )
// //             .where("id", isEqualTo: id)
// //             .get();
// //         if (userbase.docs.isEmpty) {
// //           var doc = '';
// //           final data = UserData(
// //               doc_id: doc,
// //               id: id,
// //               name: displayName,
// //               email: email,
// //               photourl: photoUrl,
// //               addtime: Timestamp.now());
// //           await db
// //               .collection("users")
// //               .withConverter(
// //                 fromFirestore: UserData.fromFirestore,
// //                 toFirestore: (UserData userData, options) =>
// //                     userData.toFirestore(),
// //               )
// //               .add(data)
// //               .then((value) => doc = value.id);
// //           await db
// //               .collection("users")
// //               .doc(doc)
// //               .withConverter(
// //                 fromFirestore: UserData.fromFirestore,
// //                 toFirestore: (UserData userData, options) =>
// //                     userData.toFirestore(),
// //               )
// //               .update(data.toFirestore());

// //           UserLoginResponseEntity userProfile = UserLoginResponseEntity();
// //           userProfile.email = email;
// //           userProfile.accessToken = id;
// //           userProfile.displayName = displayName;
// //           userProfile.photoUrl = photoUrl;
// //           userProfile.id = doc;
// //           await saveProfile(userProfile);
// //         }
// //         googleSignIn.signOut();
// //         emit(SuccessLogInState());
// //       }
// //       await prefs.setBool(STORAGE_USER_LOGIN_KEY, true);
// //     } catch (e) {
// //       print('there are an error:');
// //       print(e);
// //     }
// //   }

// //   Future<bool> setString(String key, String value) async {
// //     final _prefs = await SharedPreferences.getInstance();
// //     await _prefs.remove(key);
// //     return await _prefs.setString(key, value);
// //   }

// //   Future<void> setBool(String key, bool value) async {
// //     final _prefs = await SharedPreferences.getInstance();
// //     await _prefs.setBool(key, value);
// //     emit(ChangeState());
// //   }

// //   Future<bool> setList(String key, List<String> value) async {
// //     final _prefs = await SharedPreferences.getInstance();

// //     return await _prefs.setStringList(key, value);
// //   }

// //   Future<String?> getString(String key) async {
// //     final _prefs = await SharedPreferences.getInstance();
// //     return _prefs.getString(key);
// //   }

// //   Future<List?> getList(String key) async {
// //     final _prefs = await SharedPreferences.getInstance();
// //     return _prefs.getStringList(key);
// //   }

// //   Future<void> remove(String key) async {
// //     final _prefs = await SharedPreferences.getInstance();
// //     _prefs.remove(key);
// //   }

// //   Future<void> setToken(String value) async {
// //     await setString(STORAGE_USER_TOKEN_KEY, value);
// //     token = value;
// //     emit(ChangeState());
// //   }

// //   bool isGetStart = false;
// //   Future<void> ongetStart() async {
// //     await setBool(STORAGE_USER_GETSTART_KEY, true);
// //     isGetStart = true;
// //     emit(ChangeState());
// //   }

// //   Future<String?> getProfile() async {
// //     return await getString(STORAGE_USER_PROFILE_KEY);
// //   }

// //   bool isLogin = false;
// //   Future<void> saveProfile(UserLoginResponseEntity profile) async {
// //     isLogin = true;
// //     await setBool(STORAGE_USER_LOGIN_KEY, true);
// //     await setString(STORAGE_USER_PROFILE_KEY, jsonEncode(profile));
// //     emit(GetProfileState());
// //   }

// //   Future<void> onlogout() async {
// //     isLogin = false;
// //     await remove(STORAGE_USER_PROFILE_KEY);
// //     await remove(STORAGE_USER_TOKEN_KEY);
// //     await remove(STORAGE_USER_LOGIN_KEY);
// //     await FirebaseAuth.instance.signOut();
// //     await googleSignIn.signOut();
// //     token = '';
// //     emit(ChangeState());
// //   }
// }
