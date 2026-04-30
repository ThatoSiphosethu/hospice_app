import 'package:flutter/material.dart';
import '../../core/auth/auth_service.dart';
import '../../core/auth/auth_session.dart';
import '../../features/ehr/domain/user_role.dart';
import '../../shared/widgets/body_card.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = AuthSession.currentUser;

    if (user == null) {
      return const Center(child: Text("No user logged in"));
    }

    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            const Text(
              "Profile",
              style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 20),

            _buildHeader(user),

            const SizedBox(height: 20),

            _buildSectionTitle("Account"),
            _buildTile(Icons.badge, "Name", user.name),
            _buildTile(Icons.work, "Role", user.role.name[0].toUpperCase() + user.role.name.substring(1)),

            const Divider(height: 30),

            _buildSectionTitle("Security"),
            _buildNavTile(Icons.lock, "Change Password"),
            _buildNavTile(Icons.security, "Security Settings"),

            const Divider(height: 30),

            _buildSectionTitle("Preferences"),
            _buildNavTile(Icons.notifications, "Notification Preferences"),

            const SizedBox(height: 30),

            /// 🔥 ROLE-SPECIFIC SECTION
            _buildRoleSpecificSection(user.role),

            const SizedBox(height: 30),

            ElevatedButton.icon(
              icon: const Icon(Icons.logout),
              label: const Text("Logout"),
              onPressed: () {
                AuthService().logout();
                AuthSession.logout();
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  '/login',
                  (_) => false,
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(user) {
    return Row(
      children: [
        const CircleAvatar(radius: 30, child: Icon(Icons.person, size: 30)),
        const SizedBox(width: 12),
        Text(
          user.name,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(fontWeight: FontWeight.bold),
    );
  }

  Widget _buildTile(IconData icon, String label, String value) {
    return ListTile(
      leading: Icon(icon),
      title: Text(label),
      subtitle: Text(value),
    );
  }

  Widget _buildNavTile(IconData icon, String label) {
    return BodyCard(
      child: ListTile(
        leading: Icon(icon),
        title: Text(label),
        trailing: const Icon(Icons.chevron_right),
        onTap: () {},
      ),
    );
  }

  Widget _buildRoleSpecificSection(UserRole role) {
    String roleTitle = '';
    
    switch (role) {
      case UserRole.admin:
        roleTitle = "Admin Tools";
        break;
      case UserRole.caregiver:
        roleTitle = "Caregiver Tools";
        break;
      case UserRole.relative:
        roleTitle = "Family Tools";
        break;
    }
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle(roleTitle),
        BodyCard(
          child: ListTile(
            leading: const Icon(Icons.settings),
            title: Text("$roleTitle Settings"),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {},
          ),
        ),
      ],
    );
  }
}