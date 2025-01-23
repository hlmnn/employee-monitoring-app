import 'dart:math';

import 'package:supabase_flutter/supabase_flutter.dart';

class AuthRepository {
  final supabase = Supabase.instance.client;

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
    final isMonitorString = isMonitor.toString();
    await supabase.auth.signUp(
      email: email,
      password: password,
      data: {
        'name': name,
        'phone': phone,
        'is_monitor': isMonitorString,
      }
    );
    return true;
  }

  // logout user
  Future<void> logout() async {
    return await supabase.auth.signOut();
  }

  // get current user email
  String? getCurrentUser() {
    final session = supabase.auth.currentSession;
    final user = session?.user;
    return user?.id;
  }
}