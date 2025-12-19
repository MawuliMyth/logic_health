import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class PdfService {
  static Future<void> shareResult(Map<String, dynamic> result) async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Text(
                "Logic Health - Heart Analysis Report",
                style: pw.TextStyle(
                  fontSize: 24,
                  fontWeight: pw.FontWeight.bold,
                ),
              ),
              pw.Divider(),
              pw.SizedBox(height: 20),
              pw.Text(
                "Risk Level: ${result['risk_level']}",
                style: pw.TextStyle(fontSize: 18, color: PdfColors.red),
              ),
              pw.Text(
                "Confidence: ${((result['risk_probability'] ?? 0) * 100).toStringAsFixed(1)}%",
              ),
              pw.SizedBox(height: 20),
              pw.Text(
                "Recommendation:",
                style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
              ),
              pw.Text(result['recommendation'] ?? "N/A"),
              pw.SizedBox(height: 20),
              pw.Text("Top Contributing Factors:"),
              if (result['top_contributors'] != null)
                ...(result['top_contributors'] as List).map(
                  (item) => pw.Bullet(
                    text:
                        "${item['feature']}: ${item['importance'].toStringAsFixed(2)} (${item['impact']})",
                  ),
                ),
            ],
          );
        },
      ),
    );

    await Printing.sharePdf(
      bytes: await pdf.save(),
      filename: 'Heart_Analysis_${DateTime.now().millisecondsSinceEpoch}.pdf',
    );
  }
}
