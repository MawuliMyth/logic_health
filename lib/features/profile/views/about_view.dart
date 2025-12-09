import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:logic_health/features/profile/widgets/container_image_widget.dart';
import 'package:logic_health/features/profile/widgets/team_%20carousel_widget.dart';

class AboutView extends StatelessWidget {
  static String id = 'about_view';

  const AboutView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'About Us',
          style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ContainerImageWidget(),
                const SizedBox(height: 30),
                Text(
                  'Minimizing The Risk Of Heart Disease',
                  style: GoogleFonts.poppins(
                    fontSize: 32,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  "This app is a smart clinical decision support system built to assist doctors in assessing heart disease risk using patient medical data.",
                  style: GoogleFonts.poppins(
                    color: Color(0xff666666),
                    fontSize: 14,
                    height: 1.6, // line height like screenshot
                  ),
                ),

                const SizedBox(height: 12),

                Text(
                  "By analysing key health indicators such as blood pressure, cholesterol, ECG results, blood sugar, and exercise response, the app provides fast, data-driven risk predictions to support early diagnosis and treatment planning.",
                  style: GoogleFonts.poppins(
                    color: Color(0xff666666),
                    fontSize: 14,
                    height: 1.6,
                  ),
                ),

                const SizedBox(height: 12),

                Text(
                  "This app is designed exclusively for medical professionals and is meant to support not replace clinical judgment.",
                  style: GoogleFonts.poppins(
                    color: Color(0xff666666),
                    fontSize: 14,
                    height: 1.6,
                  ),
                ),

                const SizedBox(height: 12),

                Container(
                  height: 110,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Color(0xffFFE7E7),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 12),
                        Text(
                          'Mission',
                          style: GoogleFonts.poppins(
                            color: Color(0xffFF0000),
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'To improve early detection of heart disease using intelligent digital tools.',
                          style: GoogleFonts.poppins(
                            color: Color(0xff818181),
                            fontSize: 13,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                Container(
                  height: 110,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Color(0xffFF0000),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 12),
                        Text(
                          'Vision',
                          style: GoogleFonts.poppins(
                            color: Color(0xffFFFFFF),
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'To make AI-powered clinical support accessible to healthcare facilities across Africa and beyond.',
                          style: GoogleFonts.poppins(
                            color: Color(0xffFFFFFF),
                            fontSize: 13,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 12),
                TeamCarouselWidget(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
