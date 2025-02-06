import 'dart:math';

import 'package:employee_monitoring_app/data/model/group_model.dart';
import 'package:employee_monitoring_app/data/model/user_model.dart';
import 'package:employee_monitoring_app/main.dart';

class GroupRepository {

  Future<bool> createGroup(String name) async {
    try {
      Random random = Random();
      const String chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789';
      final groupCode = List.generate(6, (index) => chars[random.nextInt(chars.length)]).join();

      final response = await supabase.from('groups').insert({
        'name': name,
        'group_code': groupCode
      }).select('id').single();
      final int groupId = response['id'];

      final session = supabase.auth.currentSession;
      if (session == null) throw Exception("User not logged in");
      final String userId = session.user.id;

      await supabase.from('profiles').update({'group_id': groupId}).eq('id', userId);
      return true;
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> joinGroup(String code) async {
    try {
      final session = supabase.auth.currentSession;
      if (session == null) throw Exception("User not logged in");
      final String userId = session.user.id;

      final response = await supabase.from('groups').select('id').eq('group_code', code).single();
      if (response['id'] == null) throw Exception("Group not found!");
      final int groupId = response['id'];

      await supabase.from('profiles').update({'group_id': groupId}).eq('id', userId);
      return true;
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> editGroup(String name) async {
    try {
      final session = supabase.auth.currentSession;
      if (session == null) throw Exception("User not logged in");
      final String userId = session.user.id;
      
      final userResponse = await supabase.from('profiles').select('group_id').eq('id', userId).single();
      final int groupId = userResponse['group_id'];

      final updates = {
        'name': name,
        'updated_at': DateTime.now().toIso8601String(),
      };
      await supabase.from('groups').update(updates).eq('id', groupId);
      
      return true;
    } catch (e) {
      rethrow;
    }
  }

  Future<GroupModel> getGroupDetail() async {
    try {
      final session = supabase.auth.currentSession;
      if (session == null) throw Exception("User not logged in");
      final String userId = session.user.id;

      final userResponse = await supabase.from('profiles').select('group_id').eq('id', userId).single();
      final int groupId = userResponse['group_id'];

      final groupResponse = await supabase.from('groups').select().eq('id', groupId).single();
      final groupData = GroupModel.fromJson(groupResponse);

      final groupUserResponse = await supabase.from('profiles').select().eq('group_id', groupId);
      final List<AuthUserModel> members = groupUserResponse.map<AuthUserModel>((json) {
        return AuthUserModel.fromJson(json);
      }).toList();

      members.sort((a, b) {
        if (a.isMonitor == true && b.isMonitor == false) return -1;
        if (a.isMonitor == false && b.isMonitor == true) return 1;
        return a.name.compareTo(b.name);
      });

      final data = GroupModel(
        id: groupData.id,
        name: groupData.name,
        groupCode: groupData.groupCode,
        memberCount: members.length,
        members: members
      );

      return data;
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> removeUserFromGroup(String userId) async {
    try {
      final session = supabase.auth.currentSession;
      if (session == null) throw Exception("User not logged in");

      final userResponse = await supabase.from('profiles').select('group_id').eq('id', userId).single();
      final int? groupId = userResponse['group_id'];
      if (groupId == null) {
        throw Exception("User is not part of any group");
      }

      final updates = {
        'group_id': null,
        'updated_at': DateTime.now().toIso8601String(),
      };
      await supabase.from('profiles').update(updates).eq('id', userId);

      return true;
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> leaveGroup() async {
    try {
      final session = supabase.auth.currentSession;
      if (session == null) throw Exception("User not logged in");
      final String userId = session.user.id;

      final userResponse = await supabase.from('profiles').select('group_id').eq('id', userId).single();
      final int? groupId = userResponse['group_id'];
      if (groupId == null) throw Exception("User is not part of any group");

      final updates = {
        'group_id': null,
        'updated_at': DateTime.now().toIso8601String(),
      };
      await supabase.from('profiles').update(updates).eq('id', userId);

      return true;
    } catch (e) {
      rethrow;
    }
  }

  Future<List<AuthUserModel>> geLeaderboard() async {
    try {
      final session = supabase.auth.currentSession;
      if (session == null) throw Exception("User not logged in");
      final String userId = session.user.id;

      final userResponse = await supabase.from('profiles').select('group_id').eq('id', userId).single();
      final int groupId = userResponse['group_id'];

      final groupUserResponse = await supabase.from('profiles').select().eq('group_id', groupId).eq('is_monitor', false).order('task_completed_month', ascending: false);
      final List<AuthUserModel> data = groupUserResponse.map<AuthUserModel>((json) {
        return AuthUserModel.fromJson(json);
      }).toList();

      return data;
    } catch (e) {
      rethrow;
    }
  }
}