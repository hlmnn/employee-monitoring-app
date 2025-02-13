import 'package:employee_monitoring_app/data/data_state.dart';
import 'package:employee_monitoring_app/data/model/task_model.dart';
import 'package:employee_monitoring_app/data/model/user_model.dart';
import 'package:employee_monitoring_app/data/repository/task_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class CreateTaskCubit extends Cubit<DataState> {
  final TaskRepository repository = TaskRepository();

  CreateTaskCubit() : super(InitialState());

  void createTask(title, description, reward, startDate, dueDate, memberId) async {
    try{
      emit(LoadingState());
      final data = await repository.createTask(title, description, reward, startDate, dueDate, memberId);
      emit(SuccessState<bool>(data));
    } on PostgrestException catch (e) {
      emit(ErrorState(e.message));
    } catch (e) {
      emit(ErrorState(e.toString()));
      rethrow;
    }
  }

  void updateTask(taskId, title, description, reward, startDate, dueDate, memberId) async {
    try{
      emit(LoadingState());
      final data = await repository.updateTask(taskId, title, description, reward, startDate, dueDate, memberId);
      emit(SuccessState<bool>(data));
    } on PostgrestException catch (e) {
      emit(ErrorState(e.message));
    } catch (e) {
      emit(ErrorState(e.toString()));
      rethrow;
    }
  }

  void deleteTask(int taskId) async {
    try{
      emit(LoadingState());
      final data = await repository.deleteTask(taskId);
      emit(SuccessState<bool>(data));
    } on PostgrestException catch (e) {
      emit(ErrorState(e.message));
    } catch (e) {
      emit(ErrorState(e.toString()));
      rethrow;
    }
  }

  void getTaskEditDetail(int taskId) async {
    try{
      emit(LoadingState());
      final data = await repository.getTaskEditDetail(taskId);
      emit(SuccessState<TaskModel>(data));
    } on PostgrestException catch (e) {
      emit(ErrorState(e.message));
    } catch (e) {
      emit(ErrorState(e.toString()));
      rethrow;
    }
  }

  void getMemberList() async {
    try{
      emit(LoadingState());
      final data = await repository.getMemberList();
      emit(SuccessState<List<AuthUserModel>>(data));
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