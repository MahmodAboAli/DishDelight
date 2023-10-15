import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'meal_detial_state.dart';

class MealDetialCubit extends Cubit<MealDetialState> {
  MealDetialCubit() : super(MealDetialInitial());
  static MealDetialCubit get(context) => BlocProvider.of(context);
 
}
