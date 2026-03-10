import 'package:flutter/material.dart';
import 'package:hospice_app/shared/widgets/body_card.dart';

import '../../features/ehr/domain/user_role.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // In a real app, the role is determined by the email/database, 
  // but we can add a toggle for testing purposes.
  UserRole _selectedRole = UserRole.caregiver;

  void _handleLogin() {
    // Logic to navigate based on role
    switch (_selectedRole) {
      case UserRole.admin:
        Navigator.pushReplacementNamed(context, '/admin_dashboard');
        break;
      case UserRole.caregiver:
        Navigator.pushReplacementNamed(context, '/cna_schedule');
        break;
      case UserRole.relative:
        Navigator.pushReplacementNamed(context, '/relative_portal');
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
          child: Column(
            children: [
              const Icon(Icons.shield_moon_outlined, color: Colors.blue, size: 70),
              const SizedBox(height: 16),
              const Text("Hospice Connect", 
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.w800)),
              const Text("Select your portal to continue", 
                style: TextStyle(color: Colors.grey)),
              const SizedBox(height: 40),

              // Role Selector Tabs for better UI
              _buildRoleSelector(),

              const SizedBox(height: 20),

              BodyCard(
                child: Column(
                  children: [
                    TextField(
                      decoration: InputDecoration(
                        labelText: '${_selectedRole.name.toUpperCase()} ID or Email',
                        prefixIcon: const Icon(Icons.person_outline),
                        border: const OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 16),
                    const TextField(
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: 'Secure Password',
                        prefixIcon: Icon(Icons.lock_outline),
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 32),

              SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  onPressed: _handleLogin,
                  child: Text("Access ${_selectedRole.name} Portal", 
                    style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRoleSelector() {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: UserRole.values.map((role) {
          bool isSelected = _selectedRole == role;
          return Expanded(
            child: GestureDetector(
              onTap: () => setState(() => _selectedRole = role),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(
                  color: isSelected ? Colors.white : Colors.transparent,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: isSelected ? [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 4)] : [],
                ),
                child: Center(
                  child: Text(
                    role.name[0].toUpperCase() + role.name.substring(1),
                    style: TextStyle(
                      fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                      color: isSelected ? Colors.blue : Colors.grey[600],
                    ),
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}