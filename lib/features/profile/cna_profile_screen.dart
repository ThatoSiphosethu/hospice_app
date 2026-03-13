import 'package:flutter/material.dart';
import 'package:hospice_app/shared/widgets/body_card.dart';

import '../../core/auth/auth_service.dart';
import '../../core/auth/auth_session.dart';


class CNAProfileScreen extends StatelessWidget {
  const CNAProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = AuthSession.currentUser;

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            /// PROFILE HEADER
            Row(
              children: [
                const CircleAvatar(
                  radius: 30,
                  child: Icon(Icons.person, size: 32),
                ),

                const SizedBox(width: 16),

                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    BodyCard(
                      child: Text(
                        user?.name ?? "Unknown User",
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),

                    Text(
                      user?.role.name ?? "",
                      style: const TextStyle(color: Colors.grey),
                    ),
                  ],
                )
              ],
            ),

            const SizedBox(height: 30),

            /// ACCOUNT
            const Text(
              "Account",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 10),

          BodyCard(
              child: ListTile(
                leading: const Icon(Icons.badge_outlined),
                title: const Text("Name"),
                subtitle: Text(user?.name ?? "Unknown"),
              ),
            ),

            BodyCard(
              child: ListTile(
                leading: const Icon(Icons.email_outlined),
                title: const Text("Email"),
                subtitle: Text("${user?.name.toLowerCase()}@hospice.com"),
              ),
            ),

            BodyCard(
              child: ListTile(
                leading: const Icon(Icons.work_outline),
                title: const Text("Role"),
                subtitle: Text(user?.role.name ?? ""),
              ),
            ),

            const Divider(),

            /// SECURITY
            const Text(
              "Security",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),

            BodyCard(
              child: ListTile(
                leading: const Icon(Icons.lock_outline),
                title: const Text("Change Password"),
                trailing: const Icon(Icons.chevron_right),
                onTap: () {},
              ),
            ),

            BodyCard(
              child: ListTile(
                leading: const Icon(Icons.security_outlined),
                title: const Text("Security Settings"),
                trailing: const Icon(Icons.chevron_right),
                onTap: () {},
              ),
            ),

            const Divider(),

            /// PREFERENCES
            const Text(
              "Preferences",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),

            BodyCard(
              child: ListTile(
                leading: const Icon(Icons.notifications_outlined),
                title: const Text("Notification Preferences"),
                trailing: const Icon(Icons.chevron_right),
                onTap: () {},
              ),
            ),

            const SizedBox(height: 30),

            /// LOGOUT
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                icon: const Icon(Icons.logout),
                label: const Text("Logout"),
                onPressed: () {
                  AuthService().logout();

                  Navigator.pushNamedAndRemoveUntil(
                    context,
                    '/login',
                    (route) => false,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}