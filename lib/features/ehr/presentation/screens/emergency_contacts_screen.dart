import 'package:flutter/material.dart';
import '../../domain/patient.dart';

class EmergencyContactsScreen extends StatelessWidget {
  const EmergencyContactsScreen({super.key, required Patient patient});

  @override
  Widget build(BuildContext context) {
    final patient =
        ModalRoute.of(context)!.settings.arguments as Patient;

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(80),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
            child: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).appBarTheme.backgroundColor,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    blurRadius: 8,
                    offset: const Offset(0, 3),
                    color: Colors.black.withOpacity(.08),
                  ),
                ],
              ),
              child: AppBar(
                title: Text("Emergency Contacts"),
                backgroundColor: Colors.transparent,
                elevation: 0,
                centerTitle: true,
              ),
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Contacts for ${patient.name}",
              style: Theme.of(context).textTheme.headlineSmall,
              
            ),
            const SizedBox(height: 20),

            // Example contacts
            _buildContactCard(
              name: "Jane Doe",
              relationship: "Daughter",
              phone: "(555) 123-4567",
            ),

            const SizedBox(height: 12),

            _buildContactCard(
              name: "John Smith",
              relationship: "Spouse",
              phone: "(555) 987-6543",
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContactCard({
    required String name,
    required String relationship,
    required String phone,
  }) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        leading: const Icon(Icons.person),
        title: Text(name),
        subtitle: Text("$relationship • $phone"),
        trailing: const Icon(Icons.phone),
      ),
    );
  }
}