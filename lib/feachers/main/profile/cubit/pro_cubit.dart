import 'dart:convert';

import 'package:DISH_DELIGhTS/core/sherdprefs.dart';
import 'package:DISH_DELIGhTS/core/string.dart';
import 'package:DISH_DELIGhTS/feachers/Auth/models/user.dart';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../../../../core/userdata.dart';

part 'pro_state.dart';

class ProCubit extends Cubit<ProState> {
  ProCubit() : super(ProInitial());

  static ProCubit get(context) => BlocProvider.of(context);
  var db = FirebaseFirestore.instance;
  
  int tabIndex = 0;
  changeTabProIndex(int index) {
    tabIndex = index;
    emit(TabIndexState());
  }
  editprofile({String photo = '', String FirstName = '', LastName = ''}) async {
    var x = await db
        .collection('users')
        .doc(userdata.id)
        .withConverter(
          fromFirestore: UserData.fromFirestore,
          toFirestore: (UserData userData, options) => userData.toFirestore(),
        )
        .get();
    UserData data = x.data() ?? UserData();
    if (FirstName != '' && LastName != '') {
      data.name = '${FirstName} $LastName';
      userdata.displayName = FirstName + ' ' + LastName;
    }
    if (photo != '') {
      userdata.photoUrl = photo;
      data.photourl = photo;
    }
    await db.collection('users').doc(userdata.id).update(data.toFirestore());
    await saveProfile(userdata);
    await saveUserData();

    emit(EditProfileState());
  }

  
  saveUserData() async {
    String? profile = await getString(STORAGE_USER_PROFILE_KEY);
    if (profile != null) {
      userdata = UserLoginResponseEntity.fromJson(jsonDecode(profile));
    }
    emit(SaveUserDataState());
  }
  Future<void> saveProfile(UserLoginResponseEntity profile) async {
    await setBool(STORAGE_USER_LOGIN_KEY, true);
    await setString(STORAGE_USER_PROFILE_KEY, jsonEncode(profile));
    // await setToken(profile.accessToken!);
  }
}
