import 'package:employee_monitoring_app/data/data_state.dart';
import 'package:employee_monitoring_app/data/model/user_model.dart';
import 'package:employee_monitoring_app/data/repository/group_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class LeaderboardCubit extends Cubit<DataState> {
  final GroupRepository repository = GroupRepository();

  LeaderboardCubit() : super(InitialState());

  void getLeaderboard() async {
    try{
      emit(LoadingState());
      final data = await repository.geLeaderboard();
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