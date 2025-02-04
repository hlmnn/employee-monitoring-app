import 'package:employee_monitoring_app/data/data_state.dart';
import 'package:employee_monitoring_app/data/model/task_model.dart';
import 'package:employee_monitoring_app/data/repository/task_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class TaskCubit extends Cubit<DataState> {
  final TaskRepository repository = TaskRepository();

  TaskCubit() : super(InitialState());

  void getTaskActive() async {
    try{
      emit(LoadingState());
      final data = await repository.getTaskActive();
      emit(SuccessState<List<TaskCardModel>>(data));
    } on PostgrestException catch (e) {
      emit(ErrorState(e.message));
    } catch (e) {
      emit(ErrorState(e.toString()));
      rethrow;
    }
  }

  void getTaskCompleted() async {
    try{
      emit(LoadingState());
      final data = await repository.getTaskCompleted();
      emit(SuccessState<List<TaskCardModel>>(data));
    } on PostgrestException catch (e) {
      emit(ErrorState(e.message));
    } catch (e) {
      emit(ErrorState(e.toString()));
      rethrow;
    }
  }

  void getTaskDetail(int taskId) async {
    try{
      emit(LoadingState());
      final data = await repository.getTaskDetail(taskId);
      emit(SuccessState<TaskModel>(data));
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