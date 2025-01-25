import 'package:employee_monitoring_app/main.dart';

class AuthRepository {
  // login with email and password
  Future<bool> login(String email, String password) async {
    await supabase.auth.signInWithPassword(
        email: email,
        password: password,
    );
    return true;
  }

  // register with email and password
  Future<bool> register(String name, String phone, String email, String password, bool isMonitor) async {
    int level = 1;
    int currentExp = 0;
    int maxExp = 100;
    await supabase.auth.signUp(
      email: email,
      password: password,
      data: {
        'name': name,
        'phone': phone,
        'is_monitor': isMonitor,
        'level': level,
        'current_exp': currentExp,
        'max_exp': maxExp
      }
    );
    return true;
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