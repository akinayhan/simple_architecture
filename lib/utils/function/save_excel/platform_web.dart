import 'dart:html' as html;
import 'dart:typed_data';
import 'package:flutter/material.dart';

Future<void> saveAndShareExcel(Uint8List fileBytes, BuildContext context) async {
  final blob = html.Blob([fileBytes]);
  final url = html.Url.createObjectUrlFromBlob(blob);
  final anchor = html.AnchorElement(href: url)
    ..setAttribute("download", "auto_club_rapor.xlsx")
    ..click();
  html.Url.revokeObjectUrl(url);

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Başarılı'),
        content: Text('Excel dosyası başarıyla indirildi.'),
        actions: <Widget>[
          TextButton(
            child: Text('Tamam'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}