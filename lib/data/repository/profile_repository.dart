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
      final response = await supabase.from('profiles').select().eq('id', session!.user.id).single();
      final data = AuthUserModel.fromJson(response);
      return data;
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> updateUserProfile(name, phone, address) async {
    try {
      final user = supabase.auth.currentUser;
      final updates = {
        'name': name,
        'phone': phone,
        'address': address,
        'updated_at': DateTime.now().toIso8601String(),
      };
      await supabase.from('profiles').update(updates).eq('id', user!.id);
      return true;
    } catch (e) {
      rethrow;
    }
  }
}