import 'package:flutter/material.dart';
import '../domain/patient.dart';
import '../domain/clinical_note.dart';

class ClinicalNotesScreen extends StatefulWidget {
  final Patient patient;

  const ClinicalNotesScreen({super.key, required this.patient});

  @override
  State<ClinicalNotesScreen> createState() =>
      _ClinicalNotesScreenState();
}

class _ClinicalNotesScreenState
    extends State<ClinicalNotesScreen> {

  final List<ClinicalNote> notes = [];
  final controller = TextEditingController();

  void addNote() {
    if (controller.text.isEmpty) return;

    setState(() {
      notes.add(
        ClinicalNote(controller.text, DateTime.now()),
      );
      controller.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${widget.patient.name} Notes"),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              children: notes.map((n) => ListTile(
                title: Text(n.text),
                subtitle: Text(n.date.toString()),
              )).toList(),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                Expanded(
                  child: TextField(controller: controller),
                ),
                IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: addNote,
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
