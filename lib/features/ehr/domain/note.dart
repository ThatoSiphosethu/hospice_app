
enum NoteTag {
  general,
  vitals,
  medication,
  incident,
  pain,
  behavioral,
}

class Note {
  final String id;
  final String content;
  final String authorName;
  final String authorRole;
  final DateTime timestamp;
  final List<NoteTag> tags;

  Note({
    required this.id,
    required this.content,
    required this.authorName,
    required this.authorRole,
    required this.timestamp,
    required this.tags,
  });

  Note copyWith({
    String? content,
    List<NoteTag>? tags,
  }) {
    return Note(
      id: id,
      content: content ?? this.content,
      authorName: authorName,
      authorRole: authorRole,
      timestamp: DateTime.now(), // update on edit
      tags: tags ?? this.tags,
    );
  }
}