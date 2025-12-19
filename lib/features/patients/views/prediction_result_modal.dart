import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../services/pdf_service.dart';

class PredictionResultModal extends StatelessWidget {
  final Map<String, dynamic> result;

  const PredictionResultModal({super.key, required this.result});

  @override
  Widget build(BuildContext context) {
    final String risk = result['risk_level'] ?? "Unknown";
    final bool isHigh = risk.toLowerCase().contains('high');
    final Color color = isHigh ? Colors.red : Colors.green;
    final String prob =
        "${((result['risk_probability'] ?? 0) * 100).toStringAsFixed(1)}%";
    final List contributors = result['top_contributors'] ?? [];

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Drag Handle
          Center(
            child: Container(
              width: 50,
              height: 5,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
          const SizedBox(height: 20),
          Text(
            "Prediction Results",
            style: GoogleFonts.poppins(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Divider(),

          ListTile(
            contentPadding: EdgeInsets.zero,
            leading: Icon(
              isHigh ? Icons.warning_amber_rounded : Icons.check_circle_outline,
              color: color,
              size: 40,
            ),
            title: Text(
              risk,
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.bold,
                color: color,
                fontSize: 18,
              ),
            ),
            subtitle: Text("Confidence: $prob", style: GoogleFonts.poppins()),
          ),

          const SizedBox(height: 10),
          Text(
            "Recommendation:",
            style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
          ),
          Text(
            result['recommendation'] ?? "N/A",
            style: GoogleFonts.poppins(color: Colors.grey[700], fontSize: 13),
          ),

          const SizedBox(height: 20),

          if (contributors.isNotEmpty) ...[
            Text(
              "Top Contributing Factors:",
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.w600,
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 8),
            ...contributors.map((item) {
              final bool isIncrease = item['impact'] == 'increase';
              return Padding(
                padding: const EdgeInsets.only(bottom: 6),
                child: Row(
                  children: [
                    Icon(
                      isIncrease ? Icons.arrow_upward : Icons.arrow_downward,
                      size: 14,
                      color: isIncrease ? Colors.red : Colors.green,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      item['feature'].toString(),
                      style: GoogleFonts.poppins(fontSize: 13),
                    ),
                    const Spacer(),
                    Text(
                      item['importance'].toStringAsFixed(2),
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.bold,
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ],

          const SizedBox(height: 24),

          // Action Buttons
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              icon: const Icon(Icons.share, color: Colors.white),
              label: const Text(
                "Share Report",
                style: TextStyle(color: Colors.white),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xffFF0000),
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onPressed: () => PdfService.shareResult(result),
            ),
          ),
          const SizedBox(height: 10),
          SizedBox(
            width: double.infinity,
            child: OutlinedButton(
              style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onPressed: () => Navigator.pop(context),
              child: const Text("Done"),
            ),
          ),
        ],
      ),
    );
  }
}
