import 'package:employee_monitoring_app/main.dart';

class AuthRepository {
  // login with email and password
  Future<bool> login(String email, String password) async {
    try {
      final response = await supabase.auth.signInWithPassword(
        email: email,
        password: password,
      );

      // If login is successful, refresh the session
      if (response.user != null) {
        await supabase.auth.refreshSession();
        return true;
      } else {
        throw Exception("Login failed: User not found.");
      }
    } catch (e) {
      throw Exception("Login failed: ${e.toString()}");
    }
  }

  // register with email and password
  Future<bool> register(String name, String phone, String email, String password, bool isMonitor) async {
    try {
      final response = await supabase.auth.signUp(
        email: email,
        password: password,
        data: {
          'name': name,
          'phone': phone,
          'is_monitor': isMonitor
        }
      );
      if (response.user == null) {
        return false;
      }
      await supabase.auth.signOut();
      return true;
    } catch (e) {
      rethrow;
    }
  }

  Future<bool?> getCurrentSession() async {
    final session = supabase.auth.currentSession;
    if (session != null) {
      if (session.user.userMetadata!['is_monitor'] == true) {
        return true;
      } else {
        return false;
      }
    } else {
      return null;
    }
  }
}