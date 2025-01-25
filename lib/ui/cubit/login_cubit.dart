import 'package:employee_monitoring_app/data/repository/auth_repository.dart';
import 'package:employee_monitoring_app/data/data_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class LoginCubit extends Cubit<DataState>{
  final AuthRepository repository = AuthRepository();

  LoginCubit() : super(InitialState());

  Future<void> login(String email, String password) async {
    try{
      emit(LoadingState());
      final data = await repository.login(email, password);
      emit(SuccessState<bool>(data));
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