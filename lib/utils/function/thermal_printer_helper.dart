import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class ThermalPrinterHelper {
  static Future<void> createThermalPdf(
      String licensePlate,
      List<int> selectedTransactionIds,
      List<dynamic> detailedTransactionItems,
      int companyId,
      String token,
      String companyName,
      String companyPhone
      ) async {
    final fontData = await rootBundle.load('assets/Fonts/OpenSans-Regular.ttf');
    final ttf = pw.Font.ttf(fontData);
    final pdf = pw.Document();
    final time = DateFormat('dd.MM.yyyy / HH:MM').format(DateTime.now());

    pdf.addPage(
      pw.Page(
        build: (context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.center,
            children: [
              pw.Text(companyName, textAlign: pw.TextAlign.center, style: pw.TextStyle(fontSize: 48, font: ttf)),
              pw.Text("İletişim: $companyPhone", style: pw.TextStyle(fontSize: 32, font: ttf)),
              pw.Divider(),
              pw.Text("Plaka: $licensePlate", style: pw.TextStyle(fontSize: 40, font: ttf)),
              pw.SizedBox(height: 10),
              pw.Text("Seçilen Uygulamalar:",
                style: pw.TextStyle(fontSize: 36, fontWeight: pw.FontWeight.bold, font: ttf),
                textAlign: pw.TextAlign.center,
              ),
              for (var transactionId in selectedTransactionIds)
                pw.Padding(
                  padding: const pw.EdgeInsets.symmetric(vertical: 2),
                  child: pw.Text(
                    detailedTransactionItems
                        .firstWhere((item) => item.id == transactionId)
                        .name,
                    style: pw.TextStyle(fontSize: 36, font: ttf),
                    textAlign: pw.TextAlign.center,
                  ),
                ),
              pw.Divider(),
              pw.Text(time,textAlign: pw.TextAlign.center, style: pw.TextStyle(fontSize: 24, font: ttf)),
              pw.Text("Bu belgeyi kaybetmeyiniz.", textAlign: pw.TextAlign.center, style: pw.TextStyle(fontSize: 24, font: ttf)),
            ],
          );
        },
      ),
    );

    await Printing.layoutPdf(
      onLayout: (PdfPageFormat format) async => pdf.save(),
    );
  }

  static Future<void> createThermalListPdf(
      String licensePlate,
      List<int> selectedTransactionIds,
      List<dynamic> detailedTransactionItems,
      int companyId,
      String token,
      String companyName,
      String companyPhone
      ) async {
    final fontData = await rootBundle.load('assets/Fonts/OpenSans-Regular.ttf');
    final ttf = pw.Font.ttf(fontData);
    //final PdfPageFormat pageFormat = PdfPageFormat(80, double.infinity);
    final pdf = pw.Document();
    final time = DateFormat('dd.MM.yyyy / HH:MM').format(DateTime.now());

    pdf.addPage(
      pw.Page(
        //pageFormat: pageFormat,
        build: (context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.center,
            children: [
              pw.Text(companyName, textAlign: pw.TextAlign.center, style: pw.TextStyle(fontSize: 48, font: ttf)),
              pw.Text("İletişim: $companyPhone", style: pw.TextStyle(fontSize: 32, font: ttf)),
              pw.Divider(),
              pw.Text("Plaka: $licensePlate", style: pw.TextStyle(fontSize: 40, font: ttf)),
              pw.SizedBox(height: 10),
              pw.Text("Seçilen Uygulamalar:",
                style: pw.TextStyle(fontSize: 36, fontWeight: pw.FontWeight.bold, font: ttf),
                textAlign: pw.TextAlign.center,
              ),
              for (var transactionId in selectedTransactionIds)
                pw.Padding(
                  padding: const pw.EdgeInsets.symmetric(vertical: 2),
                  child: pw.Text(
                    detailedTransactionItems
                        .firstWhere((item) => item['id'] == transactionId)['name'],
                    style: pw.TextStyle(fontSize: 32, font: ttf),
                    textAlign: pw.TextAlign.center,
                  ),
                ),
              pw.Divider(),
              pw.Text(time, textAlign: pw.TextAlign.center, style: pw.TextStyle(fontSize: 32, font: ttf)),
              pw.Text("Bu belgeyi kaybetmeyiniz.", textAlign: pw.TextAlign.center, style: pw.TextStyle(fontSize: 24, font: ttf)),
            ],
          );
        },
      ),
    );

    await Printing.layoutPdf(
      onLayout: (PdfPageFormat format) async => pdf.save(),
    );
  }
}