import 'package:employee_monitoring_app/data/data_state.dart';
import 'package:employee_monitoring_app/data/model/group_model.dart';
import 'package:employee_monitoring_app/data/repository/group_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class EditGroupCubit extends Cubit<DataState> {
  final GroupRepository repository = GroupRepository();

  EditGroupCubit() : super(InitialState());

  void editGroup(name) async {
    try{
      emit(LoadingState());
      final data = await repository.editGroup(name);
      emit(SuccessState<bool>(data));
    } on PostgrestException catch (e) {
      emit(ErrorState(e.message));
    } catch (e) {
      emit(ErrorState(e.toString()));
      rethrow;
    }
  }

  void getGroupDetail() async {
    try{
      emit(LoadingState());
      final data = await repository.getGroupDetail();
      emit(SuccessState<GroupModel>(data));
    } on PostgrestException catch (e) {
      emit(ErrorState(e.message));
    } catch (e) {
      emit(ErrorState(e.toString()));
      rethrow;
    }
  }

  void removeUserFromGroup(userId) async {
    try{
      emit(LoadingState());
      final data = await repository.removeUserFromGroup(userId);
      emit(SuccessState<bool>(data));
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