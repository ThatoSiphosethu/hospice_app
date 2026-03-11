import '../../../features/ehr/domain/user_role.dart';

class AuthUser {
  final String id;
  final String name;
  final UserRole role;

  AuthUser({
    required this.id,
    required this.name,
    required this.role,
  });
}