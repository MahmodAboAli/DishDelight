import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'pro_state.dart';

class ProCubit extends Cubit<ProState> {
  ProCubit() : super(ProInitial());

  static ProCubit get(context) => BlocProvider.of(context);

}
