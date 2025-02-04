import 'package:employee_monitoring_app/data/model/task_model.dart';
import 'package:employee_monitoring_app/data/model/user_model.dart';
import 'package:employee_monitoring_app/main.dart';

class TaskRepository {

  Future<bool> createTask(title, description, reward, startDate, dueDate, memberId) async {
    try {
      final session = supabase.auth.currentSession;
      if (session == null) throw Exception("User not logged in");
      final String userId = session.user.id;

      final userResponse = await supabase.from('profiles').select('group_id').eq('id', userId).single();
      final int groupId = userResponse['group_id'];

      await supabase.from('tasks').insert({
        'title': title,
        'description': description,
        'reward': reward,
        'start_date': startDate.toIso8601String(),
        'due_date': dueDate.toIso8601String(),
        'group_id': groupId,
        'assigned_to': memberId,
        'assigned_by': userId
      });

      return true;
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> updateTask(taskId, title, description, reward, startDate, dueDate, memberId) async {
    try {
      final session = supabase.auth.currentSession;
      if (session == null) throw Exception("User not logged in");
      final String userId = session.user.id;

      final userResponse = await supabase.from('profiles').select('group_id').eq('id', userId).single();
      final int groupId = userResponse['group_id'];

      await supabase.from('tasks').update({
        'title': title,
        'description': description,
        'reward': reward,
        'start_date': startDate.toIso8601String(),
        'due_date': dueDate.toIso8601String(),
        'group_id': groupId,
        'assigned_to': memberId,
        'assigned_by': userId
      }).eq('id', taskId);

      return true;
    } catch (e) {
      rethrow;
    }
  }

  Future<List<TaskCardModel>> getTaskActive() async {
    try {
      final session = supabase.auth.currentSession;
      if (session == null) throw Exception("User not logged in");
      final String userId = session.user.id;

      final userResponse = await supabase.from('profiles').select('group_id').eq('id', userId).single();
      final int groupId = userResponse['group_id'];

      final taskResponse = await supabase.from('tasks')
        .select('id, title, reward, experience, due_date, assigned_to(id, name, level, is_monitor)')
        .eq('group_id', groupId)
        .eq('is_active', true)
        .order('due_date', ascending: true);
      final List<TaskCardModel> data = taskResponse.map<TaskCardModel>((json) {
        return TaskCardModel.fromJson(json);
      }).toList();

      return data;
    } catch (e) {
      rethrow;
    }
  }

  Future<List<TaskCardModel>> getTaskCompleted() async {
    try {
      final session = supabase.auth.currentSession;
      if (session == null) throw Exception("User not logged in");
      final String userId = session.user.id;

      final userResponse = await supabase.from('profiles').select('group_id').eq('id', userId).single();
      final int groupId = userResponse['group_id'];

      final taskResponse = await supabase.from('tasks')
        .select('id, title, reward, experience, due_date, assigned_to(id, name, level, is_monitor)')
        .eq('group_id', groupId)
        .eq('is_active', false)
        .order('due_date', ascending: true);
      final List<TaskCardModel> data = taskResponse.map<TaskCardModel>((json) {
        return TaskCardModel.fromJson(json);
      }).toList();

      return data;
    } catch (e) {
      rethrow;
    }
  }

  Future<TaskModel> getTaskDetail(int taskId) async {
    try {
      final session = supabase.auth.currentSession;
      if (session == null) throw Exception("User not logged in");
      final String userId = session.user.id;

      final userResponse = await supabase.from('profiles').select('group_id').eq('id', userId).single();
      final int groupId = userResponse['group_id'];

      final taskResponse = await supabase.from('tasks')
        .select('*, assigned_to(id, name, level, is_monitor)')
        .eq('id', taskId)
        .eq('group_id', groupId)
        .single();
      final data = TaskModel.fromJson(taskResponse);

      return data;
    } catch (e) {
      rethrow;
    }
  }

  Future<List<AuthUserModel>> getMemberList() async {
    try {
      final session = supabase.auth.currentSession;
      if (session == null) throw Exception("User not logged in");
      final String userId = session.user.id;

      final userResponse = await supabase.from('profiles').select('group_id').eq('id', userId).single();
      final int groupId = userResponse['group_id'];

      final groupUserResponse = await supabase.from('profiles').select('').eq('group_id', groupId).eq('is_monitor', false).order('name', ascending: true);
      final List<AuthUserModel> data = groupUserResponse.map<AuthUserModel>((json) {
        return AuthUserModel.fromJson(json);
      }).toList();

      return data;
    } catch (e) {
      rethrow;
    }
  }
}