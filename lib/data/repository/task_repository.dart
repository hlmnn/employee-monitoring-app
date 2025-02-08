import 'dart:io';

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

  Future<bool> updateTaskMember(int taskId, int cash, int experience, String resultReport, String fileName, File file) async {
    try {
      final session = supabase.auth.currentSession;
      if (session == null) throw Exception("User not logged in");
      final String userId = session.user.id;

      final userResponse = await supabase.from('profiles')
          .select('cash, level, current_exp, max_exp, task_completed, task_completed_month, group_id')
          .eq('id', userId)
          .single();
      final int? groupId = userResponse['group_id'];
      if (groupId == null) throw Exception("User not joined in group!");

      int memberCash = userResponse['cash'];
      int memberLevel = userResponse['level'];
      int memberCurrentExp = userResponse['current_exp'];
      int memberMaxExp = userResponse['max_exp'];
      int memberTaskCompleted = userResponse['task_completed'];
      int memberTaskCompletedMonth = userResponse['task_completed_month'];

      memberCash += cash;
      memberCurrentExp += experience;
      if (memberCurrentExp >= memberMaxExp) {
        memberLevel++;
        memberMaxExp += 50;
        memberCurrentExp -= memberCurrentExp;
      }
      final taskStorageResponse = await supabase.storage.from('task_results').upload(
          'group-$groupId/$fileName',
          file
      );
      if (taskStorageResponse.isEmpty) throw Exception("Failed to upload file!");
      final String resultFileUrl = supabase.storage.from('task_results').getPublicUrl(fileName);

      final taskUpdates = {
        'result_report': resultReport,
        'result_file': resultFileUrl,
        'is_active': false,
        'updated_at': DateTime.now().toIso8601String(),
      };
      await supabase.from('tasks').update(taskUpdates).eq('id', taskId);

      final memberUpdates = {
        'cash': memberCash,
        'level': memberLevel,
        'current_exp': memberCurrentExp,
        'max_exp': memberMaxExp,
        'task_completed': memberTaskCompleted + 1,
        'task_completed_month': memberTaskCompletedMonth + 1,
        'updated_at': DateTime.now().toIso8601String(),
      };
      await supabase.from('profiles').update(memberUpdates).eq('id', userId);

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