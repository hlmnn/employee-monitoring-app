import 'package:employee_monitoring_app/main.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ProfileRepository {
  // logout user
  Future<bool> logout() async {
    await supabase.auth.signOut();
    return true;
  }

  Future<User?> getCurrentUser() async {
    final user = supabase.auth.currentUser;
    return user;
  }
}