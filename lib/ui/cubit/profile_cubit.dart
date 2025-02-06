import 'package:employee_monitoring_app/data/data_state.dart';
import 'package:employee_monitoring_app/data/model/user_model.dart';
import 'package:employee_monitoring_app/data/repository/profile_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ProfileCubit extends Cubit<DataState>{
  final ProfileRepository repository = ProfileRepository();

  ProfileCubit() : super(InitialState());

  void logout() async {
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

  // get current user profile
  void getCurrentUserProfile() async {
    try{
      emit(LoadingState());
      final data = await repository.getCurrentUserProfile();
      emit(SuccessState<AuthUserModel>(data));
    } on PostgrestException catch (e) {
      emit(ErrorState(e.message));
    } catch (e) {
      emit(ErrorState(e.toString()));
      rethrow;
    }
  }

  // update user profile
  void updateUserProfile(name, phone, address) async {
    try{
      emit(LoadingState());
      final data = await repository.updateUserProfile(name, phone, address);
      emit(SuccessState<bool?>(data));
    } on PostgrestException catch (e) {
      emit(ErrorState(e.message));
    } catch (e) {
      emit(ErrorState(e.toString()));
      rethrow;
    }
  }

  void getMemberDetail(String memberId) async {
    try{
      emit(LoadingState());
      final data = await repository.getMemberDetail(memberId);
      emit(SuccessState<AuthUserModel>(data));
    } on PostgrestException catch (e) {
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