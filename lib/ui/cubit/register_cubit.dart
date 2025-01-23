import 'package:employee_monitoring_app/data/repository/auth_repository.dart';
import 'package:employee_monitoring_app/data/data_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class RegisterCubit extends Cubit<DataState>{
  final AuthRepository repository = AuthRepository();

  RegisterCubit() : super(InitialState());

  Future<void> register(String name, String phone, String email, String password, bool isMonitor) async {
    try{
      emit(LoadingState());
      final data = await repository.register(name, phone, email, password, isMonitor);
      emit(SuccessState<bool>(data));
    } on PostgrestException catch (e) {
      emit(ErrorState(e.message.toString()));
    }
  }

  void resetState() async {
    emit(InitialState());
  }
}