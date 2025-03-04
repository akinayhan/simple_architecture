import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'package:path_provider/path_provider.dart';

Future<void> saveAndShareExcel(Uint8List fileBytes, BuildContext context) async {
  final directory = await getApplicationDocumentsDirectory();
  final filePath = '${directory.path}/auto_club_rapor.xlsx';
  final file = File(filePath);
  await file.writeAsBytes(fileBytes);

  Share.shareXFiles([XFile(filePath)], text: 'Firma Bazlı Uygulama Sayıları');
}
