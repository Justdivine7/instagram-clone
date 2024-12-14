import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:instagram_clone/models/user.dart';
import 'package:instagram_clone/resources/auths/auth_methods.dart';

class UserProvider extends StateNotifier<UserData?> {
  final AuthMethods _authMethods;

  UserProvider(this._authMethods) : super(null);

  Future<void> refreshUser() async {
    try {
      UserData user = await _authMethods.getUserDetails();
      state = user;
    } catch (e) {
      state = null;
    }
  }
}
// Usage in a Riverpod Provider
final userProvider = StateNotifierProvider<UserProvider, UserData?>((ref) {
  final authMethods = AuthMethods(); // Provide the necessary dependency
  return UserProvider(authMethods);
});
