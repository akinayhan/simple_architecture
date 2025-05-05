import 'package:flutter/material.dart';
import 'package:flutter/services.dart' as services;
import 'dart:convert';

class UpdateNotesPage extends StatefulWidget {
  const UpdateNotesPage({super.key});

  @override
  UpdateNotesPageState createState() => UpdateNotesPageState();
}

class UpdateNotesPageState extends State<UpdateNotesPage> {

  Future<List<dynamic>> fetchUpdateNotes() async {
    final String response = await services.rootBundle.loadString('assets/update_version_notes.json');
    final data = jsonDecode(response);
    return data['versions'];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Güncelleme Notları')),
      body: FutureBuilder<List<dynamic>>(
        future: fetchUpdateNotes(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Hata: ${snapshot.error}'));
          }

          final updateNotes = snapshot.data!;
          return ListView.builder(
            itemCount: updateNotes.length,
            itemBuilder: (context, index) {
              final note = updateNotes[index];
              return Card(
                margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Versiyon: ${note['version']}", style: TextStyle(fontWeight: FontWeight.bold)),
                      SizedBox(height: 8),
                      Text("Tarih: ${note['release_date']}"),
                      SizedBox(height: 12),
                      ...note['release_notes'].map<Widget>((note) => Text("- $note")).toList(),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}