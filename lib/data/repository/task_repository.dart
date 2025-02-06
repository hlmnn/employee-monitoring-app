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
      if (userResponse['group_id'] == null) throw Exception("User not joined in group!");
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
      if (userResponse['group_id'] == null) throw Exception("User not joined in group!");
      final int groupId = userResponse['group_id'];

      final updates = {
        'title': title,
        'description': description,
        'reward': reward,
        'start_date': startDate.toIso8601String(),
        'due_date': dueDate.toIso8601String(),
        'group_id': groupId,
        'assigned_to': memberId,
        'assigned_by': userId,
        'updated_at': DateTime.now().toIso8601String(),
      };
      await supabase.from('tasks').update(updates).eq('id', taskId);

      return true;
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> deleteTask(taskId) async {
    try {
      final session = supabase.auth.currentSession;
      if (session == null) throw Exception("User not logged in");

      await supabase.from('tasks').delete().eq('id', taskId);

      return true;
    } catch (e) {
      return false;
    }
  }

  Future<List<TaskCardModel>> getTaskActive() async {
    try {
      final session = supabase.auth.currentSession;
      if (session == null) throw Exception("User not logged in");
      final String userId = session.user.id;

      final userResponse = await supabase.from('profiles').select('group_id').eq('id', userId).single();
      if (userResponse['group_id'] == null) throw Exception("User not joined in group!");
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
      if (userResponse['group_id'] == null) throw Exception("User not joined in group!");
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

  Future<List<TaskCardModel>> getTaskActiveMember() async {
    try {
      final session = supabase.auth.currentSession;
      if (session == null) throw Exception("User not logged in");
      final String userId = session.user.id;

      final userResponse = await supabase.from('profiles').select('group_id').eq('id', userId).single();
      if (userResponse['group_id'] == null) throw Exception("User not joined in group!");
      final int groupId = userResponse['group_id'];

      final taskResponse = await supabase.from('tasks')
          .select('id, title, reward, experience, due_date, assigned_to(id, name, level, is_monitor)')
          .eq('group_id', groupId)
          .eq('is_active', true)
          .eq('assigned_to', userId)
          .order('due_date', ascending: true);
      final List<TaskCardModel> data = taskResponse.map<TaskCardModel>((json) {
        return TaskCardModel.fromJson(json);
      }).toList();

      return data;
    } catch (e) {
      rethrow;
    }
  }

  Future<List<TaskCardModel>> getTaskCompletedMember() async {
    try {
      final session = supabase.auth.currentSession;
      if (session == null) throw Exception("User not logged in");
      final String userId = session.user.id;

      final userResponse = await supabase.from('profiles').select('group_id').eq('id', userId).single();
      if (userResponse['group_id'] == null) throw Exception("User not joined in group!");
      final int groupId = userResponse['group_id'];

      final taskResponse = await supabase.from('tasks')
          .select('id, title, reward, experience, due_date, assigned_to(id, name, level, is_monitor)')
          .eq('group_id', groupId)
          .eq('is_active', false)
          .eq('assigned_to', userId)
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
      if (userResponse['group_id'] == null) throw Exception("User not joined in group!");
      final int groupId = userResponse['group_id'];

      final taskResponse = await supabase.from('tasks').select().eq('id', taskId).eq('group_id', groupId).single();
      final taskData = TaskModel.fromJson(taskResponse);

      final memberResponse = await supabase.from('profiles').select('id, name, level, is_monitor').eq('id', taskData.assignedTo).single();
      final member = UserCardModel.fromJson(memberResponse);

      final data = TaskModel(
          id: taskData.id,
          title: taskData.title,
          description: taskData.description,
          reward: taskData.reward,
          experience: taskData.experience,
          startDate: taskData.startDate,
          dueDate: taskData.dueDate,
          groupId: taskData.groupId,
          assignedTo: taskData.assignedTo,
          assignedBy: taskData.assignedBy,
          isActive: taskData.isActive,
          resultReport: taskData.resultReport,
          resultFile: taskData.resultFile,
          memberCard: member
      );

      return data;
    } catch (e) {
      rethrow;
    }
  }

  Future<TaskModel> getTaskEditDetail(int taskId, [bool detail = false]) async {
    try {
      final session = supabase.auth.currentSession;
      if (session == null) throw Exception("User not logged in");
      final String userId = session.user.id;

      final userResponse = await supabase.from('profiles').select('group_id').eq('id', userId).single();
      if (userResponse['group_id'] == null) throw Exception("User not joined in group!");
      final int groupId = userResponse['group_id'];

      final taskResponse = await supabase.from('tasks').select().eq('id', taskId).eq('group_id', groupId).single();
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
      if (userResponse['group_id'] == null) throw Exception("User not joined in group!");
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