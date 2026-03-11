import 'auth_repository.dart';
import 'auth_session.dart';
import 'models/auth_user.dart';

class AuthService {

  final AuthRepository _repo = AuthRepository();

  Future<AuthUser?> login(String email, String password) async {

    final user = await _repo.login(email, password);

    if (user != null) {
      AuthSession.currentUser = user;
    }

    return user;
  }

  void logout() {
    AuthSession.logout();
  }

}