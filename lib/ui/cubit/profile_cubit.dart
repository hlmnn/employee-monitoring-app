import 'package:employee_monitoring_app/data/data_state.dart';
import 'package:employee_monitoring_app/data/repository/profile_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ProfileCubit extends Cubit<DataState>{
  final ProfileRepository repository = ProfileRepository();

  ProfileCubit() : super(InitialState());

  Future<void> logout() async {
    try{
      emit(LoadingState());
      final data = await repository.logout();
      emit(SuccessState<bool>(data));
    } on AuthException catch (e) {
      emit(ErrorState(e.message));
    } catch (e) {
      emit(ErrorState(e.toString()));
      rethrow;
    }
  }

  // get user on the current session
  Future<void> getCurrentUser() async {
    try{
      emit(LoadingState());
      final data = await repository.getCurrentUser();
      emit(SuccessState<User?>(data));
    } on AuthException catch (e) {
      emit(ErrorState(e.message));
    } catch (e) {
      emit(ErrorState(e.toString()));
      rethrow;
    }
  }

  // Future<void> calculateExp(int level, int currentExp, int maxExp) async {
  //   int currentTotalExp = currentExp; // example starting experience (level 7)
  //   int currentMaxExp = maxExp;
  //
  //   while (currentTotalExp >= currentMaxExp) {
  //     currentTotalExp -= maxExp; // subtract maxExp from currentExp
  //     level++; // increase the level
  //     currentExp = currentTotalExp + (level - 1) * 50; // recalculate maxExp
  //   }
  // }

  void resetState() async {
    emit(InitialState());
  }
}