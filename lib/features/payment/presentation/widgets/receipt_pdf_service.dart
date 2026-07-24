import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class ReceiptPdfService {
  static Future<void> generateAndDownloadReceipt({
    required String amount,
    required String accountNumber,
    required String paymentDate,
    required String paymentMethod,
    required String senderName,
    required String housePrice,
    required String serviceFee,
    required String realEstateTitle,
    required String appointmentDate,
  }) async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return pw.Padding(
            padding: const pw.EdgeInsets.all(32),
            child: pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Center(
                  child: pw.Column(
                    children: [
                      pw.Text(
                        'HabiSpace Real Estate',
                        style: pw.TextStyle(
                          fontSize: 24,
                          fontWeight: pw.FontWeight.bold,
                          color: PdfColor.fromHex('#1392A6'),
                        ),
                      ),
                      pw.SizedBox(height: 6),
                      pw.Text(
                        'PAYMENT RECEIPT',
                        style: pw.TextStyle(
                          fontSize: 14,
                          fontWeight: pw.FontWeight.bold,
                          color: PdfColors.grey700,
                        ),
                      ),
                      pw.SizedBox(height: 20),
                      pw.Text(
                        amount,
                        style: pw.TextStyle(
                          fontSize: 32,
                          fontWeight: pw.FontWeight.bold,
                          color: PdfColors.black,
                        ),
                      ),
                      pw.SizedBox(height: 6),
                      pw.Text(
                        'Payment Successful!',
                        style: pw.TextStyle(
                          fontSize: 16,
                          fontWeight: pw.FontWeight.bold,
                          color: PdfColor.fromHex('#4CAF50'),
                        ),
                      ),
                    ],
                  ),
                ),
                pw.SizedBox(height: 24),
                pw.Divider(color: PdfColors.grey300),
                pw.SizedBox(height: 16),
                _buildPdfRow('Account Number', accountNumber),
                pw.SizedBox(height: 12),
                _buildPdfRow('Payment Date', paymentDate),
                pw.SizedBox(height: 12),
                _buildPdfRow('Payment Method', paymentMethod),
                pw.SizedBox(height: 12),
                _buildPdfRow("Sender's Name", senderName),
                pw.SizedBox(height: 16),
                pw.Divider(color: PdfColors.grey300),
                pw.SizedBox(height: 16),
                _buildPdfRow('House Prices', '\$$housePrice'),
                pw.SizedBox(height: 12),
                _buildPdfRow('HabiSpace service fee', '\$$serviceFee'),
                pw.SizedBox(height: 16),
                pw.Divider(color: PdfColors.grey300),
                pw.SizedBox(height: 16),
                _buildPdfRow('Real Estate', realEstateTitle),
                pw.SizedBox(height: 12),
                _buildPdfRow('Book Appointment', appointmentDate),
                pw.Spacer(),
                pw.Divider(color: PdfColors.grey300),
                pw.SizedBox(height: 12),
                pw.Center(
                  child: pw.Text(
                    'Thank you for choosing HabiSpace Real Estate Services.',
                    style: pw.TextStyle(
                      fontSize: 12,
                      color: PdfColors.grey600,
                      fontStyle: pw.FontStyle.italic,
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );

    final bytes = await pdf.save();

    try {
      await Printing.layoutPdf(
        onLayout: (PdfPageFormat format) async => bytes,
        name: 'receipt_$accountNumber.pdf',
      );
    } catch (e) {
      debugPrint('Printing plugin error: $e');
      try {
        final output = await getApplicationDocumentsDirectory();
        final file = File('${output.path}/receipt_$accountNumber.pdf');
        await file.writeAsBytes(bytes);
        debugPrint('Receipt saved to file fallback: ${file.path}');
      } catch (fileError) {
        debugPrint('File save error: $fileError');
      }
    }
  }

  static pw.Widget _buildPdfRow(String label, String value) {
    return pw.Row(
      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
      children: [
        pw.Text(
          label,
          style: pw.TextStyle(
            fontSize: 13,
            color: PdfColors.grey700,
          ),
        ),
        pw.Text(
          value,
          style: pw.TextStyle(
            fontSize: 13,
            fontWeight: pw.FontWeight.bold,
            color: PdfColors.black,
          ),
        ),
      ],
    );
  }
}
