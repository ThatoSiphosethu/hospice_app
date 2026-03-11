import 'models/auth_user.dart';
import '../../features/ehr/domain/user_role.dart';

class AuthRepository {

  Future<AuthUser?> login(String email, String password) async {

    await Future.delayed(const Duration(milliseconds: 800));

    // MOCK USERS
    if (email == "admin@hospice.com" && password == "admin") {
      return AuthUser(
        id: "1",
        name: "Administrator",
        role: UserRole.admin,
      );
    }

    if (email == "cna@hospice.com" && password == "cna") {
      return AuthUser(
        id: "2",
        name: "CNA Staff",
        role: UserRole.caregiver,
      );
    }

    if (email == "family@hospice.com" && password == "family") {
      return AuthUser(
        id: "3",
        name: "Family Member",
        role: UserRole.relative,
      );
    }

    return null;
  }
}