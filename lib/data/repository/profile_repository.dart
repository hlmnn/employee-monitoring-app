import 'package:employee_monitoring_app/data/model/task_model.dart';
import 'package:employee_monitoring_app/data/model/user_model.dart';
import 'package:employee_monitoring_app/main.dart';

class ProfileRepository {
  // logout user
  Future<bool> logout() async {
    try {
      await supabase.auth.signOut();
      return true;
    } catch (e) {
      rethrow;
    }
  }

  Future<AuthUserModel> getCurrentUserProfile() async {
    try {
      final session = supabase.auth.currentSession;
      if (session == null) throw Exception("User not logged in");
      final String userId = session.user.id;

      final response = await supabase.from('profiles').select().eq('id', userId).single();
      final data = AuthUserModel.fromJson(response);

      return data;
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> updateUserProfile(name, phone, address) async {
    try {
      final session = supabase.auth.currentSession;
      if (session == null) throw Exception("User not logged in");
      final String userId = session.user.id;

      final updates = {
        'name': name,
        'phone': phone,
        'address': address,
        'updated_at': DateTime.now().toIso8601String(),
      };
      await supabase.from('profiles').update(updates).eq('id', userId);

      return true;
    } catch (e) {
      rethrow;
    }
  }

  Future<AuthUserModel> getMemberDetail(String memberId) async {
    try {
      final session = supabase.auth.currentSession;
      if (session == null) throw Exception("User not logged in");
      final String userId = session.user.id;

      final userResponse = await supabase.from('profiles').select('group_id').eq('id', userId).single();
      final int groupId = userResponse['group_id'];

      final memberResponse = await supabase.from('profiles').select().eq('id', memberId).eq('group_id', groupId).single();
      final memberData = AuthUserModel.fromJson(memberResponse);

      final taskResponse = await supabase.from('tasks').select('id, title, reward, experience, due_date, assigned_to(id, name, level, is_monitor)').eq('assigned_to', memberId);
      final List<TaskCardModel> tasks = taskResponse.map<TaskCardModel>((json) {
        return TaskCardModel.fromJson(json);
      }).toList();

      final data = AuthUserModel(
        id: memberData.id,
        name: memberData.name,
        phone: memberData.phone,
        email: memberData.email,
        isMonitor: memberData.isMonitor,
        cash: memberData.cash,
        level: memberData.level,
        currentExp: memberData.currentExp,
        maxExp: memberData.maxExp,
        address: memberData.address,
        groupId: groupId,
        taskCompleted: memberData.taskCompleted,
        taskCompletedMonth: memberData.taskCompletedMonth,
        tasks: tasks
      );

      return data;
    } catch (e) {
      rethrow;
    }
  }
}