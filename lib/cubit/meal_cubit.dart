// ignore_for_file: non_constant_identifier_names, curly_braces_in_flow_control_structures

import 'dart:convert';
import 'dart:io';

import 'package:DISH_DELIGhTS/catagory_page/catagory_page.dart';
import 'package:DISH_DELIGhTS/model/feedback_model.dart';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../core/string.dart';
import '../model/meal_detial.dart';
import '../model/meels.dart';
import '../model/msg_content.dart';
import '../model/shop_list.dart';
import '../model/user.dart';

part 'meal_state.dart';

class MealCubit extends Cubit<MealState> {
  MealCubit() : super(MealInitial());
  static MealCubit get(context) => BlocProvider.of(context);

  final db = FirebaseFirestore.instance;
  final textController = TextEditingController();
  TextEditingController DescriptionController = TextEditingController();
  TextEditingController spentController = TextEditingController(text: '15');
  TextEditingController recipeController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  final TextEditingController EditFirstNameController = TextEditingController();
  final TextEditingController EditLastNameController = TextEditingController();
  final TextEditingController EditemailController = TextEditingController();
  final TextEditingController EditpasswordController = TextEditingController();

  List<MealDetial> Meals = [];
  List<MealDetial> MainMeal = [];
  List<MealDetial> currMeal = [];
  List<MealDetial> favoriteMeals = [];
  List<MealDetial> AprrtieMeal = [];
  List<MealDetial> SweetesMeal = [];
  List<MealDetial> DrinksMeal = [];
  List<MealDetial> CandiesMeal = [];
  List<MealDetial> VeginMeal = [];
  List<MealDetial> MyMeal = [];
  List<MealDetial> BestMeal = [];

  List<FeedbackModel> Feedbacks = [];
  List<FeedbackModel> MyFeedbacks = [];
  List<FeedbackModel> MealFeedbacks = [];
  List<Msgcontent> msgcontentList = [];

  List<Needs_Meal> valueOfNeeds = [];
  List<Needs_Meal> MyshopList = [];

  List<double> valuesofingredient = [1];
  List<String> prepration = [''];

  MealDetial currMealDetial = MealDetial();
  String doc_id = '';
  String catigoryName = 'Main';
  String descriptionFeedbacks = '';
  String? feedbackMealId;
  bool isObscuredpassword = true;
  double rate = 0;
  List<String> ingredient = [''];
  bool foundMeal = false;
  MealDetial MealforFeedback = MealDetial();
  bool progress = false;
  startProgress(bool progress) {
    progress = progress;
    emit(ChangeState());
  }

  changeObscuredOfPassword() {
    isObscuredpassword = !isObscuredpassword;
    emit(ChangeState());
  }

  getMealforFeedback({required String tit, required String name}) async {
    var Mff = await db
        .collection("Meals")
        .where("title", isEqualTo: name)
        .where("section", isEqualTo: tit)
        .withConverter(
          fromFirestore: MealDetial.fromFirestore,
          toFirestore: (MealDetial mealforFeedback, options) =>
              mealforFeedback.toFirestore(),
        )
        .get();
    MealforFeedback = Mff.docs[0].data();
    emit(getMealforFeedbackState());
  }

  findMeal({required String tit}) async {
    var FMeal = await db
        .collection("Meals")
        .withConverter(
          fromFirestore: MealDetial.fromFirestore,
          toFirestore: (MealDetial Mealforadd, options) =>
              Mealforadd.toFirestore(),
        )
        .where('title', isEqualTo: tit)
        .get();
    if (FMeal.docs.isNotEmpty) {
      foundMeal = true;
    } else {
      foundMeal = false;
    }
    emit(getMealForAddState());
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
    BestMeal.clear();
    for (int j = 0; j < i; j++) {
      BestMeal.add(BMeal.docs[j].data());
    }
    emit(getBestMealState());
  }

  selectRate(double value) {
    rate = value;
    emit(ChangeValueState());
  }

  addrate(double Rate, MealDetial meal) async {
    int x = meal.numOfrate ?? 0;
    double y = meal.rate ?? 2;

    meal.rate = (y * x + Rate) / (x + 1);
    meal.numOfrate = x + 1;
    emit(ChangeValueState());
    await db.collection("Meals").doc(meal.id).update(meal.toFirestore());
    await getTrendMeal();
    print(BestMeal[0].title);
    await getTrendMeal();
    emit(AddRateState());
    emit(loadingMealState());
  }

  editprofile(
      {
      // String email = '',
      String photo = '',
      // String password = '',
      String FirstName = '',
      LastName = ''}) async {
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

    // if (password != '') {
    //   data.password = password;
    // }
    // if (email != '' && email.contains("@gmail.com")) {
    //   userdata.email = email;
    //   data.email = email;
    // }
    if (photo != '') {
      userdata.photoUrl = photo;
      data.photourl = photo;
    }
    await db.collection('users').doc(userdata.id).update(data.toFirestore());
    await saveProfile(userdata);
    await printprofile();

    emit(EditProfileState());
  }

  getMyMeal() async {
    var meals = await db
        .collection("Meals")
        .where("userid", isEqualTo: userdata.accessToken)
        .withConverter(
          fromFirestore: MealDetial.fromFirestore,
          toFirestore: (MealDetial mymeal, options) => mymeal.toFirestore(),
        )
        .get();
    MyMeal.clear();
    for (var meal in meals.docs) {
      MyMeal.add(meal.data());
    }
    emit(getMyMealState());
  }

  getMeal({required String section, required String title}) async {
    var meal = await db
        .collection("Meals")
        .where('section', isEqualTo: section)
        .where('title', isEqualTo: title)
        .withConverter(
          fromFirestore: MealDetial.fromFirestore,
          toFirestore: (MealDetial mealdetial, options) =>
              mealdetial.toFirestore(),
        )
        .get();
    feedbackMealId = meal.docs[0].data().id;
    emit(getMealState());
    emit(loadingMealState());
  }

  changeDescriptionFeedbacks(String des) {
    descriptionFeedbacks = des;
    emit(ChangeCategoryState());
  }

  UserLoginResponseEntity userdata = UserLoginResponseEntity();
  getMealFeedbacks({required String id}) async {
    var getFeedbacks = await db
        .collection("Feedback")
        .where('title', isEqualTo: id)
        .withConverter(
          fromFirestore: FeedbackModel.fromFirestore,
          toFirestore: (FeedbackModel feedbackModel, options) =>
              feedbackModel.toFirestore(),
        )
        .get();
    MealFeedbacks.clear();
    for (var Feeds in getFeedbacks.docs) {
      MealFeedbacks.add(Feeds.data());
    }
    emit(getMealFeedbackState());
  }

  getMyFeedbacks({required String id}) async {
    var getFeedbacks = await db
        .collection("Feedback")
        .where('id', isEqualTo: id)
        .withConverter(
          fromFirestore: FeedbackModel.fromFirestore,
          toFirestore: (FeedbackModel feedbackModel, options) =>
              feedbackModel.toFirestore(),
        )
        .get();
    MyFeedbacks.clear();
    for (var Feeds in getFeedbacks.docs) {
      MyFeedbacks.add(Feeds.data());
    }
    emit(getMyFeedbackState());
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
    Feedbacks.clear();
    for (var Feeds in getFeedbacks.docs) {
      Feedbacks.add(Feeds.data());
    }
    emit(getFeedbackState());
  }

  bool removeneedsprocces = false;
  removeNeeds(Needs_Meal needs_meal) async {
    removeneedsprocces = true;
    emit(loadingMealState());
    var removemeal = await db
        .collection("users")
        .doc(userdata.id)
        .collection("needs")
        .where('title', isEqualTo: needs_meal.name)
        .withConverter(
          fromFirestore: ShopList.fromFirestore,
          toFirestore: (ShopList shopList, options) => shopList.toFirestore(),
        )
        .get();
    await db
        .collection("users")
        .doc(userdata.id)
        .collection("needs")
        .doc(removemeal.docs[0].data().id)
        .delete();
    // emit(ChangeState());
    // getShopList();
    removeneedsprocces = false;
    emit(removeNeedsState());
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
    MyshopList.clear();
    for (var need in MyNeeds.docs) {
      MyshopList.add(Needs_Meal(need.data().needs ?? 0,
          name: need.data().title ?? "Unknown"));
    }
    emit(getShoplistState());
  }

  changeNeedsAmount(double Amount, int index) {
    if (Amount + valueOfNeeds[index].need >= 0)
      valueOfNeeds[index].need += Amount;
    emit(ChangeNeedsAmountState());
  }

  initneeds(MealDetial meal) {
    for (var x = 0; x < meal.ingredient!.length; x++) {
      valueOfNeeds.add(
          Needs_Meal(meal.valueOfIngredient![x], name: meal.ingredient![x]));
    }
    emit(InitNeedState());
  }

  addNeeds(String name, double need) async {
    try {
      ShopList tool = ShopList(title: name, needs: need);
      var needs = await db
          .collection("users")
          .doc(userdata.id)
          .collection("needs")
          .withConverter(
            fromFirestore: ShopList.fromFirestore,
            toFirestore: (ShopList shopList, options) => shopList.toFirestore(),
          )
          .where("title", isEqualTo: name)
          .get();

      if (needs.docs.isEmpty) {
        await db
            .collection("users")
            .doc(userdata.id)
            .collection("needs")
            .withConverter(
              fromFirestore: ShopList.fromFirestore,
              toFirestore: (ShopList shopList, options) =>
                  shopList.toFirestore(),
            )
            .add(tool)
            .then((value) => tool.id = value.id);
        await db
            .collection("users")
            .doc(userdata.id)
            .collection("needs")
            .withConverter(
              fromFirestore: ShopList.fromFirestore,
              toFirestore: (ShopList shopList, options) =>
                  shopList.toFirestore(),
            )
            .doc(tool.id)
            .update(tool.toFirestore());
      } else {
        var updatetool = await db
            .collection("users")
            .doc(userdata.id)
            .collection("needs")
            .withConverter(
              fromFirestore: ShopList.fromFirestore,
              toFirestore: (ShopList shopList, options) =>
                  shopList.toFirestore(),
            )
            .where("title", isEqualTo: name)
            .get();
        ShopList tooll = updatetool.docs[0].data();
        tool =
            ShopList(title: name, needs: tool.needs! + tooll.needs!.toDouble());
        emit(ChangeState());
        await db
            .collection("users")
            .doc(userdata.id)
            .collection("needs")
            .withConverter(
              fromFirestore: ShopList.fromFirestore,
              toFirestore: (ShopList shopList, options) =>
                  shopList.toFirestore(),
            )
            .doc(tooll.id)
            .update(tool.toFirestore());
      }
      getShopList();
      emit(ChangeState());
    } catch (e) {
      print(e);
    }
  }

  int pageIndex = 0;
  ChangePageIndex(int index) {
    pageIndex = index;
    emit(ChangePageState());
  }

  getMealDetial({required String id}) async {
    var meal = await db
        .collection("Meals")
        .withConverter(
          fromFirestore: MealDetial.fromFirestore,
          toFirestore: (MealDetial mealDetial, options) =>
              mealDetial.toFirestore(),
        )
        .where("title", isEqualTo: id)
        .get();
    currMealDetial = meal.docs[0].data();
  }

  printprofile() async {
    // final prefs = await SharedPreferences.getInstance();
    // String? profile = await getProfile();
    String? profile = await getString(STORAGE_USER_PROFILE_KEY);
    print('profile');
    print(profile);
    if (profile != null) {
      userdata = UserLoginResponseEntity.fromJson(jsonDecode(profile));
      emit(ChangeState());
      await getFavorite();
      await getShopList();
    }
    emit(ChangeCategoryState());
  }

  getData() async {
    str = '';
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
    await printprofile();
    await getShopList();
    await FilterMeals();
    await getFavorite();
    await getFeedbacks();
    emit(GetDataState());
  }

  bool Publishprosses = false;
  PublishFeedback(
      {required String descreption1,
      required String id,
      required String mealId}) async {
    Publishprosses = true;
    emit(loadingMealState());
    print(1);
    await getMealforFeedback(tit: curricepFeedback, name: ricepfeedback);
    print(2);
    await addrate(rate, MealforFeedback);
    print(3);
    await getMeal(section: curricepFeedback, title: ricepfeedback);
    // final prefs = await SharedPreferences.getInstance();
    print(4);

    // String? profile =
    await getProfile();
    print("done to here");
    // userdata = UserLoginResponseEntity.fromJson(jsonDecode(profile!));
    FeedbackModel feedback = FeedbackModel(
      descreption: descreption1,
      photo: userdata.photoUrl,
      src: str,
      title: ricepfeedback,
      rate: rate,
      id: id,
      mealId: feedbackMealId,
      section: curricepFeedback,
      name: userdata.displayName,
    );
    await db
        .collection("Feedback")
        .withConverter(
          fromFirestore: FeedbackModel.fromFirestore,
          toFirestore: (FeedbackModel feedback, options) =>
              feedback.toFirestore(),
        )
        .add(feedback);
    await getData();
    await getFeedbacks();
    str = '';
    rate = 0;
    Publishprosses = false;
    emit(publishFeedbackState());
  }

  bool userMeal = false;
  getuserMeal(String title) async {
    var x = await db
        .collection("users")
        .doc(userdata.id)
        .collection("favorite")
        .withConverter(
          fromFirestore: MealDetial.fromFirestore,
          toFirestore: (MealDetial mealDetial, options) =>
              mealDetial.toFirestore(),
        )
        .where('title', isEqualTo: title)
        .get();
    x.docs.isEmpty ? userMeal = false : userMeal = true;
    emit(getFAvoriteState());
  }

  getFavorite() async {
    favoriteMeals.clear();
    var getfavo = await db
        .collection("users")
        .doc(userdata.id)
        .collection("favorite")
        .withConverter(
          fromFirestore: MealDetial.fromFirestore,
          toFirestore: (MealDetial mealDetial, options) =>
              mealDetial.toFirestore(),
        )
        .get();
    for (var doc in getfavo.docs) {
      favoriteMeals.add(doc.data());
    }
    emit(getFAvoriteState());
  }

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
  bool addfavoritemealprocces = false;
  addfavoriteMeal(MealDetial meal, {bool userMealfavorite = false}) async {
    addfavoritemealprocces = true;
    emit(loadingState());
    if (userMealfavorite == true) {
      meal.favorite = false;
      userMeal = false;
    } else {
      meal.favorite = true;
      userMeal = true;
    }
    emit(ChangeCategoryState());
    var themeal = await db
        .collection("Meals")
        .withConverter(
          fromFirestore: MealDetial.fromFirestore,
          toFirestore: (MealDetial mealDetial, options) =>
              mealDetial.toFirestore(),
        )
        .where("title", isEqualTo: meal.title)
        .get();
    MealDetial myMeal = themeal.docs[0].data();
    myMeal.favorite = meal.favorite;
    await db
        .collection("Meals")
        .withConverter(
          fromFirestore: MealDetial.fromFirestore,
          toFirestore: (MealDetial mealDetial, options) =>
              mealDetial.toFirestore(),
        )
        .doc(myMeal.id)
        .update(myMeal.toFirestore());

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
    print('done1');
    var fmeal = await db
        .collection("users")
        .doc(userdata.id)
        .collection("favorite")
        .withConverter(
          fromFirestore: MealDetial.fromFirestore,
          toFirestore: (MealDetial mealde, options) => mealde.toFirestore(),
        )
        .where('title', isEqualTo: meal.title)
        .get();
    if (fmeal.docs.isEmpty) {
      meal.favorite = true;
      await db
          .collection("users")
          .doc(userdata.id)
          .collection("favorite")
          .withConverter(
            fromFirestore: MealDetial.fromFirestore,
            toFirestore: (MealDetial meald, options) => meald.toFirestore(),
          )
          .add(meal)
          .then((value) => meal.id = value.id);
      await db
          .collection("users")
          .doc(userdata.id)
          .collection("favorite")
          .withConverter(
            fromFirestore: MealDetial.fromFirestore,
            toFirestore: (MealDetial meald, options) => meald.toFirestore(),
          )
          .doc(meal.id)
          .update(meal.toFirestore());
    } else {
      meal.favorite = false;
      await db
          .collection("users")
          .doc(userdata.id)
          .collection("favorite")
          .withConverter(
            fromFirestore: MealDetial.fromFirestore,
            toFirestore: (MealDetial meald, options) => meald.toFirestore(),
          )
          .doc(fmeal.docs[0].data().id)
          .delete();
    }
    await getFavorite();
    await FilterMeals();
    addfavoritemealprocces = false;

    emit(AddFavoriteState());
  }

  changeCatigoryName(String ctg) {
    catigoryName = ctg;
    emit(ChangesomethingState());
  }

  int indexofsection = 1;
  changeListofMeal(int x) {
    indexofsection = x;
    x == 1
        ? currMeal = MainMeal
        : x == 2
            ? currMeal = AprrtieMeal
            : x == 3
                ? currMeal = SweetesMeal
                : x == 4
                    ? currMeal = DrinksMeal
                    : x == 5
                        ? currMeal = CandiesMeal
                        : currMeal = VeginMeal;
    emit(ChangeListofMealState());
  }

  changevalue(int index, double value) {
    valuesofingredient[index] = value;
    emit(ChangeValueState());
  }

  changevalueofprapration(int index, double value) {
    valuesofingredient[index] = value;
    emit(ChangeValueState());
  }

  dicrementList() {
    if (ingredient.length > 1) {
      ingredient.removeLast();
      valuesofingredient.removeLast();
    }
    emit(removeState());
  }

  incrementList() {
    ingredient.add('');
    valuesofingredient.add(1);
    emit(incrementState());
  }

  addIngredient(int index, String value) {
    ingredient[index] = value;
    emit(AddIngredientState());
  }

  addprepration(int index, String value) {
    prepration[index] = value;
    emit(AddIngredientState());
  }

  dicrementListofprepration() {
    if (prepration.length > 1) {
      prepration.removeLast();
      // valuesofingredient.removeLast();
    }
    emit(removeState());
  }

  incrementListofprepration() {
    prepration.add('');
    // valuesofPrepration.add(1);
    emit(incrementState());
  }

  addIngredientofprepration(int index, String value) {
    ingredient[index] = value;
    emit(AddIngredientState());
  }

  Step2don({required String descrip, required String time}) {
    description = descrip;
    timeMeal = time;
    emit(Step2done());
  }

  changeCategory(String Category) {
    catigoryName = Category;
    emit(ChangeCategoryState());
  }

  changeRecipe(String Name) {
    title = Name;
    emit(ChangeRecipeState());
  }

  sendMessage() async {
    emit(loadingState());
    String sendContent = textController.text;
    final content = Msgcontent(
      uid: 'token',
      content: sendContent,
      type: "text",
      addtime: Timestamp.now(),
    );
    msgcontentList.clear();
    await db
        .collection("Meals")
        .doc(doc_id)
        .collection("msglist")
        .withConverter(
          fromFirestore: Msgcontent.fromFirestore,
          toFirestore: (Msgcontent msgcontent, options) =>
              msgcontent.toFirestore(),
        )
        .add(content)
        .then((DocumentReference doc) {
      print("Document snapshot added with id,${doc.id}");
    });
    textController.clear();
    listenMessage();
    emit(SendMessageSuccess());
  }

  listenMessage() {
    emit(loadingState());
    try {
      // var listener;
      var messages = db
          .collection("Meals")
          .doc(doc_id)
          .collection("msglist")
          .withConverter(
            fromFirestore: Msgcontent.fromFirestore,
            toFirestore: (Msgcontent msgcontent, options) =>
                msgcontent.toFirestore(),
          )
          .orderBy("addtime", descending: true);
      msgcontentList.clear();
      // listener =
      messages.snapshots().listen((event) {
        for (var change in event.docChanges) {
          switch (change.type) {
            case DocumentChangeType.added:
              if (change.doc.data() != null) {
                print("type:${change.doc.data()!.content}");
                msgcontentList.add(change.doc.data() ??
                    Msgcontent(
                        type: "text",
                        content: 'null',
                        addtime: Timestamp.now(),
                        uid: 'null'));
              }
              break;
            case DocumentChangeType.modified:
              break;
            case DocumentChangeType.removed:
              break;
          }
        }
        emit(SendMessageSuccess());
      }, onError: (error) => print("listen fialed: $error"));
    } catch (e) {
      print(e);
    }
    emit(ListenMessageSuccess());
  }

  GoChat(String id) async {
    emit(loadingState());
    var message = await db
        .collection("Meals")
        .withConverter(
          fromFirestore: MealDetial.fromFirestore,
          toFirestore: (MealDetial meal, options) => meal.toFirestore(),
        )
        .where("id", isEqualTo: id)
        .get();
    doc_id = message.docs.first.id;
    await listenMessage();
    emit(GetMessagesSuccess());
  }

  FilterMeals() async {
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
    MainMeal.clear();
    // print(MainMeal[0].title ?? "noMeal");
    for (var doc in getMainMeals.docs) {
      MainMeal.add(doc.data());
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
    SweetesMeal.clear();
    for (var doc in getSweetesMeals.docs) {
      SweetesMeal.add(doc.data());
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
    AprrtieMeal.clear();
    for (var doc in getAprrtieMeals.docs) {
      AprrtieMeal.add(doc.data());
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
    DrinksMeal.clear();
    for (var doc in getDrinksMeals.docs) {
      DrinksMeal.add(doc.data());
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
    CandiesMeal.clear();
    for (var doc in getCandiesMeals.docs) {
      CandiesMeal.add(doc.data());
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
    VeginMeal.clear();
    for (var doc in getVeginMeals.docs) {
      VeginMeal.add(doc.data());
    }
    print("4");
    changeListofMeal(indexofsection);
    print("FilterMealEnd");
    emit(GetDataState());
  }

  openDrawer(context) {
    print(Scaffold.hasDrawer(context));

    Scaffold.of(context).openEndDrawer();
    emit(OpenDrawerState());
  }

  String str = '';
  String title = '';
  String timeMeal = '';
  String description = '';
  List<String> needs = [];
  // final content = Msgcontent(
  //   uid: 'token',
  //   content: 'sendContent',
  //   type: "text",
  //   addtime: Timestamp.now(),
  // );
  AddTheMeal({required MealDetial meal}) async {
    emit(loadingState());

    await db
        .collection("Meals")
        .withConverter(
          fromFirestore: MealDetial.fromFirestore,
          toFirestore: (MealDetial meal, options) => meal.toFirestore(),
        )
        .add(meal)
        .then((value) {
      doc_id = value.id;
      return meal.id = value.id;
    });
    await db
        .collection("Meals")
        .withConverter(
          fromFirestore: MealDetial.fromFirestore,
          toFirestore: (MealDetial mealDetial, options) => meal.toFirestore(),
        )
        .doc(doc_id)
        .update(meal.toFirestore());
    str = '';
    getData();
    emit(AddMealState());
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
      emit(ChangeState());
    } catch (e) {
      print(e);
    }
  }

  // List<String> steps = [];
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
  //!waseam

  List<String> li = [
    'Main',
    'Aprrtie',
    'Sweetes',
    'Drinks',
    'Candies',
    'vegin'
  ];

  String curricepFeedback = "Main";
  List<String> currRicepFeedbackList = [''];
  ChangeFeedbackCategory(String z) {
    curricepFeedback = z;
    if (z == "Main") {
      currRicepFeedbackList.clear();
      for (MealDetial x in MainMeal) {
        currRicepFeedbackList.add(x.title ?? "null");
      }
      ricepfeedback = currRicepFeedbackList[0];
      if (currRicepFeedbackList.isEmpty) {
        currRicepFeedbackList.add('');
      }
      // ricepfeedback = MainMeal[0].title!;
    }
    if (z == "Sweetes") {
      currRicepFeedbackList.clear();
      for (MealDetial x in SweetesMeal) {
        currRicepFeedbackList.add(x.title ?? "null");
      }
      ricepfeedback = currRicepFeedbackList[0];
      if (currRicepFeedbackList.isEmpty) {
        currRicepFeedbackList.add('');
      }
    }
    if (z == "Drinks") {
      currRicepFeedbackList.clear();
      for (MealDetial x in DrinksMeal) {
        currRicepFeedbackList.add(x.title ?? "null");
        ricepfeedback = currRicepFeedbackList[0];
      }
      if (currRicepFeedbackList.isEmpty) {
        currRicepFeedbackList.add('');
      }
    }
    if (z == "Candies") {
      currRicepFeedbackList.clear();
      for (MealDetial x in CandiesMeal) {
        currRicepFeedbackList.add(x.title ?? "null");
        ricepfeedback = currRicepFeedbackList[0];
      }
      if (currRicepFeedbackList.isEmpty) {
        currRicepFeedbackList.add('');
      }
    }
    if (z == "Vegin") {
      currRicepFeedbackList.clear();
      for (MealDetial x in VeginMeal) {
        currRicepFeedbackList.add(x.title ?? "null");
        ricepfeedback = currRicepFeedbackList[0];
      }
      if (currRicepFeedbackList.isEmpty) {
        currRicepFeedbackList.add('');
      }
    }
    if (z == "Aprrtie") {
      currRicepFeedbackList.clear();
      for (MealDetial x in AprrtieMeal) {
        currRicepFeedbackList.add(x.title ?? "null");
        ricepfeedback = currRicepFeedbackList[0];
      }
      if (currRicepFeedbackList.isEmpty) {
        currRicepFeedbackList.add('');
      }
    }
    ricepfeedback = currRicepFeedbackList[0];

    emit(ChangeRicepState());
  }

  String ricepfeedback = '';

  void recipe(String x) {
    ricepfeedback = x;
    emit(changericepState());
  }

  void hometocate(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(builder: (_) {
      return CatagoryPage();
    }));
  }

  int page = 0;
  void homechangeindicator(inte) {
    page = inte;
    emit(HomeChangeIndicator());
  }

  bool a = true;
  bool b1 = false;
  bool c = false;
  bool d = false;
  bool e = false;
  bool f = false;
  //   void homeactive_main(){
  //       a=  true  ;
  //     b=c=d=e=f=false;
  //     emit(HomeActiveMain());
  //   }
  //   void homeactiveactive_apprite(){
  //       b=  true  ;
  //       a=c=d=e=f=false;
  //     emit(HomeActiveAppetizers());
  //   }
  // void homeactive_sweetis(){
  //   c=  true  ;
  //   b=d=a=e=f=false;
  //   emit(HomeActiveSweetis());
  // }
  // void homeactive_drink(){
  //   d=  true  ;
  //   a=b=c=e=f=false;
  //
  //   emit(HomeActiveDrinks());
  // }
  // void homeactive_candies(){
  //   e=  true  ;
  //   b=c=d=a=f=false;
  //
  //   emit(HomeActiveCandies());
  // }
  // void homeactive_vegiterian(){
  //   f=  true  ;
  //   b=c=d=e=a=false;
  //   emit(HomeActiveVegiterian());
  // }
  void homeActive_Catagory(int n) {
    switch (n) {
      case 1:
        {
          a = true;
          b1 = c = d = e = f = false;
          emit(HomeActiveMain());
          // statements;
        }
        break;
      case 2:
        {
          b1 = true;
          a = c = d = e = f = false;
          emit(HomeActiveAppetizers());
          //statements;
        }
        break;
      case 3:
        {
          c = true;
          b1 = d = a = e = f = false;
          emit(HomeActiveSweetis());
          //statements;
        }
        break;
      case 4:
        {
          d = true;
          a = b1 = c = e = f = false;
          emit(HomeActiveDrinks());
          //statements;
        }
        break;
      case 5:
        {
          e = true;
          b1 = c = d = a = f = false;
          emit(HomeActiveCandies());
          //statements;
        }
        break;
      case 6:
        {
          f = true;
          b1 = c = d = e = a = false;
          emit(HomeActiveVegiterian());
        }
        break;
    }
  }

  Future<void> setString(String key, String value) async {
    final _prefs = await SharedPreferences.getInstance();
    await _prefs.remove(STORAGE_USER_PROFILE_KEY);
    await _prefs.setString(key, value);
    emit(ChangeState());
  }

  Future<void> setBool(String key, bool value) async {
    final _prefs = await SharedPreferences.getInstance();
    await _prefs.setBool(key, value);
    emit(ChangeState());
  }

  Future<bool> setList(String key, List<String> value) async {
    final _prefs = await SharedPreferences.getInstance();

    return await _prefs.setStringList(key, value);
  }

  Future<String?> getString(String key) async {
    final _prefs = await SharedPreferences.getInstance();
    return _prefs.getString(key);
  }

  Future<List?> getList(String key) async {
    final _prefs = await SharedPreferences.getInstance();
    return _prefs.getStringList(key);
  }

  Future<void> remove(String key) async {
    final _prefs = await SharedPreferences.getInstance();
    _prefs.remove(key);
  }

  bool isGetStart = false;
  Future<void> ongetStart() async {
    await setBool(STORAGE_USER_GETSTART_KEY, true);
    isGetStart = true;
    emit(ChangeState());
  }

  Future<String?> getProfile() async {
    return await getString(STORAGE_USER_PROFILE_KEY);
  }

  bool isLogin = false;
  Future<void> saveProfile(UserLoginResponseEntity profile) async {
    isLogin = true;
    await setBool(STORAGE_USER_LOGIN_KEY, true);
    await setString(STORAGE_USER_PROFILE_KEY, jsonEncode(profile));
    // await setToken(profile.accessToken!);
    emit(ChangeState());
  }

  int tabIndex = 0;
  changeTabIndex(int index) {
    tabIndex = index;
    emit(RecipeColorState());
  }

  bool valuea = true;
  bool valueb = false;
  void recipecolor() {
    if (valuea == true) {
      valueb = false;
    } else {
      valuea = true;
      valueb = false;
    }
    emit(RecipeColorState());
  }

  void feedbackcolor() {
    if (valueb == true) {
      valuea = false;
    } else {
      valueb = true;
      valuea = false;
    }
    emit(FeedbackColorState());
  }

  Future<void> onlogout() async {
    isLogin = false;
    await remove(STORAGE_USER_PROFILE_KEY);
    await remove(STORAGE_USER_TOKEN_KEY);
    await remove(STORAGE_USER_LOGIN_KEY);
    await FirebaseAuth.instance.signOut();
    // userdata = UserLoginResponseEntity();
    //   token = '';
    // await  googleSignIn.signOut();
    emit(ChangeState());
  }
  // !LogIn

  // final db = FirebaseFirestore.instance;

  TextEditingController userEmail = TextEditingController();
  TextEditingController userPassword = TextEditingController();
  TextEditingController userConfirm = TextEditingController();
  TextEditingController userName = TextEditingController();
  TextEditingController lastUserName = TextEditingController();
  String token = '';
  bool oboscurypass = true;
  bool oboscurycon = true;

  GoogleSignIn googleSignIn = GoogleSignIn(
    scopes: [
      'email',
      'https://www.googleapis.com/auth/contacts.readonly',
    ],
  );

  bool login = true;
  obscurypassword() {
    oboscurypass = !oboscurypass;
    emit(Changeobscurypass());
  }

  obscuryconfige() {
    oboscurycon = !oboscurycon;
    emit(Changeobscurycon());
  }

  changeLogin() {
    login = !login;
    emit(ChangeState());
  }

// //! this is for testing its start here
//   String str = '';
//   final ImagePicker picker = ImagePicker();
//   File? photo;
//   bool addphotoprocces = false;

//   Future imgFromGallery(ImageSource imageSource) async {
//     try {
//       emit(loadingState());
//       final PickedFile = await picker.pickImage(source: imageSource);
//       if (PickedFile != null) {
//         photo = File(PickedFile.path);
//         await uploadFile();
//       } else {
//         print("No Image selected");
//       }
//       emit(ChangeState());
//     } catch (e) {
//       print(e);
//     }
//   }

//   // List<String> steps = [];
//   bool getImage = false;
//   Future getImgUrl(String name) async {
//     try {
//       final spaceRef =
//           // FirebaseStorage.instance.ref("chat").child("path/to/image5.jpg");
//           FirebaseStorage.instance.ref("chat").child(photo!.path);
//       await spaceRef.getDownloadURL().then((url) => str = url);
//       getImage = true;
//       emit(ChangeState());
//       return str;
//     } catch (e) {}
//   }

//   Future uploadFile() async {
//     try {
//       final filename = photo!.path;
//       final ref = FirebaseStorage.instance.ref("chat").child(filename);
//       ref.putFile(photo!).snapshotEvents.listen((event) async {
//         await getImgUrl('name');
//       });

//       emit(ChangeState());
//     } catch (e) {
//       print(e);
//     }
//   }
//! and end here
  bool doneLogin = false;
  String idtoken = 'no image';
  bool finduser = false;
  fonduser({
    required context,
    required String email,
    required String password,
    required bool create,
  }) async {
    emit(loadingState());

    var loginUser = await db
        .collection("users")
        .withConverter(
          fromFirestore: UserData.fromFirestore,
          toFirestore: (UserData user, options) => user.toFirestore(),
        )
        .where("email", isEqualTo: email)
        .where("password", isEqualTo: password)
        .get();
    if (loginUser.docs.isNotEmpty) {
      finduser = true;
      showDialog(
        context: context,
        builder: (context) {
          return const AlertDialog(
            title: Text("authintication error"),
            icon: Icon(Icons.error),
            content: Text("The account is already used"),
          );
        },
      );
    } else {
      finduser = false;
    }
    emit(finduserstate());
  }

  String id = '';
  Future<void> authenticate(
      {required context,
      required String email,
      required String password,
      required bool create,
      String displayName = '',
      bool save = false}) async {
    try {
      emit(loadingState());
      final prefs = await SharedPreferences.getInstance();
      UserData? data;
      String doc = '';
      if (!save) {
        if (!create) {
          doneLogin = true;
          var loginUser = await db
              .collection("users")
              .withConverter(
                fromFirestore: UserData.fromFirestore,
                toFirestore: (UserData user, options) => user.toFirestore(),
              )
              .where("email", isEqualTo: email)
              .where("password", isEqualTo: password)
              .get();
          if (loginUser.docs.isEmpty) {
            doneLogin = false;
            showDialog(
              context: context,
              builder: (context) {
                return const AlertDialog(
                  title: Text("authintication error"),
                  icon: Icon(Icons.error),
                  content: Text("The user isn't founded"),
                );
              },
            );
          } else {
            await FirebaseAuth.instance
                .signInWithEmailAndPassword(email: email, password: password)
                .then((value) => id = value.user!.uid)
                .catchError((e) {
              doneLogin = false;
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: const Text("authintication error"),
                    icon: const Icon(Icons.error),
                    content: Text(e.toString()),
                  );
                },
              );
            });
            if (doneLogin) {
              var userbase = await db
                  .collection("users")
                  .withConverter(
                    fromFirestore: UserData.fromFirestore,
                    toFirestore: (UserData userDaa, options) =>
                        userDaa.toFirestore(),
                  )
                  .where("email", isEqualTo: email)
                  .where("password", isEqualTo: password)
                  .get();
              print("userbase.lenght=${userbase.docs.length}");
              UserLoginResponseEntity userProfile = UserLoginResponseEntity();
              userProfile.photoUrl = '';
              userProfile.email = userbase.docs[0].data().email;
              userProfile.id = userbase.docs[0].data().doc_id;
              userProfile.accessToken = userbase.docs[0].data().id;
              userProfile.photoUrl = userbase.docs[0].data().photourl;
              userProfile.displayName = userbase.docs[0].data().name;
              doneLogin = true;
              print('userProfile');
              print(userProfile.photoUrl);
              await saveProfile(userProfile);
              await prefs.setBool(STORAGE_USER_LOGIN_KEY, true);
              // await printprofile();
              // https://firebasestorage.googleapis.com/v0/b/sanadtest-1a117.appspot.com/o/chat%2Fpath%2Fto%2Fimage5.jpg?alt=media&token=86c446ba-8a28-4d86-8edd-1266d0463b47
              // https://firebasestorage.googleapis.com/v0/b/sanadtest-1a117.appspot.com/o/chat%2Fpath%2Fto%2Fimage5.jpg?alt=media&token=7f057366-7f72-4b8a-bb22-e18fdefc4613
              emit(GetProfileState());
            }
          }
        } else {
          doneLogin = true;
          await FirebaseAuth.instance
              .createUserWithEmailAndPassword(email: email, password: password)
              .then((value) => id = value.user!.uid)
              .catchError((e) {
            doneLogin = false;
            emit(ChangeState());
            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: const Text("authintication error"),
                  icon: const Icon(Icons.error),
                  content: Text(e.toString()),
                );
              },
            );
          });
        }
      } else {
        data = UserData(
            password: password,
            id: id,
            doc_id: doc,
            name: displayName,
            email: email,
            photourl: str,
            addtime: Timestamp.now());
        await db
            .collection("users")
            .withConverter(
              fromFirestore: UserData.fromFirestore,
              toFirestore: (UserData userData, options) =>
                  userData.toFirestore(),
            )
            .add(data)
            .then((value) => doc = value.id);
        // https://firebasestorage.googleapis.com/v0/b/sanadtest-1a117.appspot.com/o/chat%2Fpath%2Fto%2Fimage5.jpg?alt=media&token=4aa835f0-59f8-4f34-90fe-79d790d60f85
        // https://firebasestorage.googleapis.com/v0/b/sanadtest-1a117.appspot.com/o/chat%2Fpath%2Fto%2Fimage5.jpg?alt=media&token=6eabb80d-e768-4989-aeba-7cbc52840203
        data.doc_id = doc;
        await db
            .collection("users")
            .doc(doc)
            .withConverter(
              fromFirestore: UserData.fromFirestore,
              toFirestore: (UserData userData, options) =>
                  userData.toFirestore(),
            )
            .update(data.toFirestore());
        print("email:$email,password:$password,id:$id,doc:$doc,str:$str");
        UserLoginResponseEntity userProfile = UserLoginResponseEntity();
        userProfile.email = email;
        userProfile.accessToken = id;
        userProfile.id = doc;
        userProfile.displayName = displayName;
        userProfile.photoUrl = str;
        emit(setDataprofileState());
        await saveProfile(userProfile);
        await prefs.setBool(STORAGE_USER_LOGIN_KEY, true);
        // str = '';
        emit(ChangeState());
      }
      // String userCredential = FirebaseAuth.instance.;
      // String Email = email;
      // print(idtoken);
      emit(ChangeState());
    } catch (e) {
      print("error is $e");
    }
  }

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
