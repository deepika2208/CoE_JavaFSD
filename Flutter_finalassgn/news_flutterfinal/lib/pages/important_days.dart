import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ImportantDaysPage extends StatefulWidget {
  @override
  _ImportantDaysPageState createState() => _ImportantDaysPageState();
}

class _ImportantDaysPageState extends State<ImportantDaysPage> {
  final TextEditingController _noteController = TextEditingController();
  DateTime? _selectedDate;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  void _saveImportantDay() {
    if (_selectedDate != null && _noteController.text.isNotEmpty) {
      FirebaseFirestore.instance.collection('important_days').add({
        'date': _selectedDate,
        'note': _noteController.text,
        'timestamp': FieldValue.serverTimestamp(),
      });

      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Important Day Saved!"))
      );

      setState(() {
        _selectedDate = null;
      });

      _noteController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Important Days")),
      body: Container(
        color: const Color(0xFFFFE0B2),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextButton(
                onPressed: () => _selectDate(context),
                child: Text(
                  _selectedDate == null
                      ? "Select Date"
                      : "${_selectedDate!.toLocal()}".split(' ')[0],
                  style: const TextStyle(color: Colors.black, fontSize: 18),
                ),
              ),
              TextField(
                controller: _noteController,
                decoration: const InputDecoration(
                  labelText: "Enter a note",
                  filled: true,
                  fillColor: Colors.white70,
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _saveImportantDay,
                child: const Text("Save"),
              ),
              const SizedBox(height: 10),
              Expanded(child: ImportantDaysList()),
            ],
          ),
        ),
      ),
    );
  }
}

class ImportantDaysList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('important_days')
          .orderBy('timestamp', descending: true)
          .snapshots(),
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }
        return ListView(
          children: snapshot.data!.docs.map((document) {
            return Card(
              color: Colors.white.withOpacity(0.8),
              margin: const EdgeInsets.all(8),
              child: ListTile(
                title: Text(document['note']),
                subtitle: Text(document['date'].toDate().toString()),
                trailing: IconButton(
                  icon: const Icon(Icons.delete, color: Colors.red),
                  onPressed: () {
                    FirebaseFirestore.instance
                        .collection('important_days')
                        .doc(document.id)
                        .delete();
                  },
                ),
              ),
            );
          }).toList(),
        );
      },
    );
  }
}