import 'package:flutter/material.dart';
import '../notes_database.dart';

class NotesPage extends StatefulWidget {
  @override
  _NotesPageState createState() => _NotesPageState();
}

class _NotesPageState extends State<NotesPage> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();
  List<Map<String, dynamic>> _notes = [];

  @override
  void initState() {
    super.initState();
    _loadNotes();
  }

  Future<void> _loadNotes() async {
    final notes = await NotesDatabase.instance.fetchNotes();
    setState(() {
      _notes = notes;
    });
  }

  Future<void> _addNote() async {
    if (_titleController.text.isEmpty || _contentController.text.isEmpty) return;

    await NotesDatabase.instance.insertNote(_titleController.text, _contentController.text);
    _titleController.clear();
    _contentController.clear();
    _loadNotes();
  }

  Future<void> _deleteNote(int id) async {
    await NotesDatabase.instance.deleteNote(id);
    _loadNotes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("News Notes")),
      body: Container(
        color: const Color(0xFFFFE0B2), 
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextField(
                controller: _titleController,
                decoration: const InputDecoration(
                  labelText: 'News Title',
                  filled: true,
                  fillColor: Colors.white70, 
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: _contentController,
                decoration: const InputDecoration(
                  labelText: 'Your Notes',
                  filled: true,
                  fillColor: Colors.white70, 
                  border: OutlineInputBorder(),
                ),
                maxLines: 3,
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: _addNote,
                child: const Text('Save Note'),
              ),
              const SizedBox(height: 10),
              Expanded(
                child: ListView.builder(
                  itemCount: _notes.length,
                  itemBuilder: (context, index) {
                    return Card(
                      color: Colors.white.withOpacity(0.8),
                      margin: const EdgeInsets.all(8),
                      child: ListTile(
                        title: Text(_notes[index]['title']),
                        subtitle: Text(_notes[index]['content']),
                        trailing: IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () => _deleteNote(_notes[index]['id']),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
