import 'package:employee_monitoring_app/data/data_state.dart';
import 'package:employee_monitoring_app/data/repository/monitor_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class HomeCubit extends Cubit<DataState> {
  final MonitorRepository repository = MonitorRepository();

  HomeCubit() : super(InitialState());

  void getIsJoinServer() async {
    try{
      emit(LoadingState());
      final data = await repository.getIsJoinServer();
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