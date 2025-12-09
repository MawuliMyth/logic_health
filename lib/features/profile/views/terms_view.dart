import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TermsView extends StatelessWidget {
  static String id = 'TermsView';

  const TermsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Our Terms & Condition',
          style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Image.asset('assets/images/logoI.png', height: 50),
                  const SizedBox(width: 5),
                  Text(
                    'TERMS & CONDITIONS',
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Header text
                    Text(
                      "By using this application, you agree to the following:",
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                    ),

                    const SizedBox(height: 12),

                    // Bullet point list
                    buildBullet(
                      "This app is a clinical decision support tool, not a diagnostic authority.",
                    ),
                    buildBullet(
                      "Final diagnosis and treatment decisions remain the responsibility of the licensed medical practitioner.",
                    ),
                    buildBullet(
                      "The app’s predictions are based on historical medical data and machine learning models.",
                    ),
                    buildBullet(
                      "The developers are not liable for medical decisions made using the system.",
                    ),
                    buildBullet(
                      "Users must ensure patient data is entered accurately and ethically.",
                    ),

                    const SizedBox(height: 16),

                    // Last line paragraph
                    Text(
                      "Unauthorized use, data misuse, or attempts to breach system security are strictly prohibited.",
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Method to easily build bullet point rows
  Widget buildBullet(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Bullet dot
          const Padding(
            padding: EdgeInsets.only(top: 4.0),
            child: Icon(Icons.circle, size: 6),
          ),

          const SizedBox(width: 10),

          // Text
          Expanded(
            child: Text(
              text,
              style: GoogleFonts.poppins(
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
