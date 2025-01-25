import 'package:employee_monitoring_app/data/data_state.dart';
import 'package:employee_monitoring_app/data/repository/auth_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SplashCubit extends Cubit<DataState>{
  final AuthRepository repository = AuthRepository();

  SplashCubit() : super(InitialState()) {
    getCurrentSession();
  }

  // get the current session
  void getCurrentSession() async {
    try {
      emit(LoadingState());
      final data = await repository.getCurrentSession();
      emit(SuccessState<bool?>(data));
    } on AuthException catch (e) {
      emit(ErrorState(e.message));
    } catch (e) {
      emit(ErrorState(e.toString()));
      rethrow;
    }
  }

  void resetState() async {
    emit(InitialState());
  }
}