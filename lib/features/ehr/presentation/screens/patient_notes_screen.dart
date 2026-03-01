import 'package:flutter/material.dart';
import '../../domain/patient.dart';
import '../../domain/note.dart';

class PatientNotesScreen extends StatefulWidget {
  final Patient patient;

  const PatientNotesScreen({
    super.key,
    required this.patient,
  });

  @override
  State<PatientNotesScreen> createState() => _PatientNotesScreenState();
}

class _PatientNotesScreenState extends State<PatientNotesScreen> {
  final List<Note> _notes = [];

  void _openNoteDialog({Note? existingNote}) {
    final controller =
        TextEditingController(text: existingNote?.content ?? '');

    List<NoteTag> selectedTags =
        existingNote?.tags ?? [NoteTag.general];

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(existingNote == null ? "Add Note" : "Edit Note"),
          content: SingleChildScrollView(
            child: Column(
              children: [
                TextField(
                  controller: controller,
                  maxLines: 4,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "Enter clinical note...",
                  ),
                ),
                const SizedBox(height: 16),

                /// Strict tag selection
                Wrap(
                  spacing: 8,
                  children: NoteTag.values.map((tag) {
                    final isSelected = selectedTags.contains(tag);

                    return FilterChip(
                      label: Text(tag.name.toUpperCase()),
                      selected: isSelected,
                      onSelected: (value) {
                        setState(() {
                          if (value) {
                            selectedTags.add(tag);
                          } else {
                            selectedTags.remove(tag);
                          }
                        });
                      },
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: () {
                if (controller.text.trim().isEmpty) return;

                setState(() {
                  if (existingNote == null) {
                    _notes.insert(
                      0,
                      Note(
                        id: DateTime.now().millisecondsSinceEpoch.toString(),
                        content: controller.text.trim(),
                        authorName: "Current User",
                        authorRole: "CNA",
                        timestamp: DateTime.now(),
                        tags: selectedTags,
                      ),
                    );
                  } else {
                    final index = _notes.indexOf(existingNote);
                    _notes[index] = existingNote.copyWith(
                      content: controller.text.trim(),
                      tags: selectedTags,
                    );
                  }
                });

                Navigator.pop(context);
              },
              child: const Text("Save"),
            ),
          ],
        );
      },
    );
  }

  void _deleteNote(Note note) {
    setState(() {
      _notes.remove(note);
    });
  }

  @override
  Widget build(BuildContext context) {
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
                title: Text("Notes - ${widget.patient.name}"),
                backgroundColor: Colors.transparent,
                elevation: 0,
                centerTitle: true,
              ),
            ),
          ),
        ),
      ),
      body: _notes.isEmpty
          ? const Center(
              child: Text("No notes recorded."),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: _notes.length,
              itemBuilder: (context, index) {
                final note = _notes[index];

                return Card(
                  margin: const EdgeInsets.only(bottom: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: ListTile(
                    title: Text(note.content),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 6),
                        Text(
                          "${note.authorName} (${note.authorRole})",
                          style: const TextStyle(fontSize: 12),
                        ),
                        Text(
                          note.timestamp.toString(),
                          style: const TextStyle(
                            fontSize: 11,
                            color: Colors.grey,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Wrap(
                          spacing: 6,
                          children: note.tags
                              .map(
                                (tag) => Chip(
                                  label: Text(
                                    tag.name.toUpperCase(),
                                    style: const TextStyle(fontSize: 10),
                                  ),
                                ),
                              )
                              .toList(),
                        ),
                      ],
                    ),
                    trailing: PopupMenuButton<String>(
                      onSelected: (value) {
                        if (value == 'edit') {
                          _openNoteDialog(existingNote: note);
                        } else if (value == 'delete') {
                          _deleteNote(note);
                        }
                      },
                      itemBuilder: (context) => const [
                        PopupMenuItem(
                          value: 'edit',
                          child: Text("Edit"),
                        ),
                        PopupMenuItem(
                          value: 'delete',
                          child: Text("Delete"),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _openNoteDialog(),
        child: const Icon(Icons.add),
      ),
    );
  }
}