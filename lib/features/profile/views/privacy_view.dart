import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PrivacyView extends StatelessWidget {
  static String id = 'privacy_view';

  const PrivacyView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Privacy Policy',
          style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Image.asset('assets/images/logoI.png', height: 50),
                    const SizedBox(width: 5),
                    Text(
                      'PRIVACY NOTICE',
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
                      Text(
                        "Your privacy and your patients’ data security are extremely important to us.",
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),

                      const SizedBox(height: 20),

                      const Text(
                        "What We Collect:",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 10),

                      buildBullet(
                        "Patient medical information entered by doctors",
                      ),
                      buildBullet("Assessment results and predictions"),
                      buildBullet("Doctor account details"),

                      const SizedBox(height: 20),

                      Text(
                        "How We Protect Data:",
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      const SizedBox(height: 10),

                      buildBullet("Secure login and authentication"),
                      buildBullet("Encrypted data storage"),
                      buildBullet("Restricted doctor-only access"),
                      buildBullet("No unauthorized data sharing"),

                      const SizedBox(height: 20),

                      Text(
                        "What We Do NOT Do:",
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      const SizedBox(height: 10),

                      buildBullet("We do not sell patient data"),
                      buildBullet("We do not share data with third parties"),
                      buildBullet(
                        "We do not allow public access to medical records",
                      ),

                      const SizedBox(height: 20),

                      Text(
                        "All data is used strictly for medical assessment and clinical decision support.",
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
      ),
    );
  }

  // Reusable bullet point row
  Widget buildBullet(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 4),
            child: Icon(Icons.circle, size: 6),
          ),
          const SizedBox(width: 10),
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
