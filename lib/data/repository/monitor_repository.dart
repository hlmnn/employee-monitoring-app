import 'package:employee_monitoring_app/main.dart';

class MonitorRepository {

  Future<bool> getIsJoinServer() async {
    try {
      final session = supabase.auth.currentSession;
      if (session == null) throw Exception("User not logged in");
      final String userId = session.user.id;

      final response = await supabase.from('profiles').select('group_id').eq('id', userId).single();
      final int? groupId = response['group_id'] as int?;

      if (groupId == null || groupId == 0) {
        return false; // Return false if user hasn't joined a server
      } else {
        return true; // Return true if user has joined a server
      }
    } catch (e) {
      rethrow;
    }
  }
}