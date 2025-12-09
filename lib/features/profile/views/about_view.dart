import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:logic_health/features/profile/widgets/container_image_widget.dart';
import 'package:logic_health/features/profile/widgets/team_%20carousel_widget.dart';

class AboutView extends StatelessWidget {
  static String id = 'about_view';

  const AboutView({super.key});

  // Define a constant horizontal padding for elements that need it
  static const double horizontalPadding = 16.0;

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
        // 1. Removed the Padding widget that wrapped the whole body.
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 2. Wrap elements that need padding with Padding widget.
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: horizontalPadding,
                ),
                child: ContainerImageWidget(),
              ),
              const SizedBox(height: 30),

              // 3. Apply padding to all text elements
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: horizontalPadding,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
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
                        color: const Color(0xff666666),
                        fontSize: 14,
                        height: 1.6,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      "By analysing key health indicators such as blood pressure, cholesterol, ECG results, blood sugar, and exercise response, the app provides fast, data-driven risk predictions to support early diagnosis and treatment planning.",
                      style: GoogleFonts.poppins(
                        color: const Color(0xff666666),
                        fontSize: 14,
                        height: 1.6,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      "This app is designed exclusively for medical professionals and is meant to support not replace clinical judgment.",
                      style: GoogleFonts.poppins(
                        color: const Color(0xff666666),
                        fontSize: 14,
                        height: 1.6,
                      ),
                    ),
                    const SizedBox(height: 12),

                    // 4. Apply padding to the Mission container
                    Container(
                      height: 110,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: const Color(0xffFFE7E7),
                      ),
                      child: const Padding(
                        padding: EdgeInsets.all(8),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 12),
                            Text(
                              'Mission',
                              style: TextStyle(
                                color: Color(0xffFF0000),
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(height: 8),
                            Text(
                              'To improve early detection of heart disease using intelligent digital tools.',
                              style: TextStyle(
                                color: Color(0xff818181),
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),

                    // 5. Apply padding to the Vision container
                    Container(
                      height: 110,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: const Color(0xffFF0000),
                      ),
                      child: const Padding(
                        padding: EdgeInsets.all(8),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 12),
                            Text(
                              'Vision',
                              style: TextStyle(
                                color: Color(0xffFFFFFF),
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(height: 8),
                            Text(
                              'To make AI-powered clinical support accessible to healthcare facilities across Africa and beyond.',
                              style: TextStyle(
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
                    const SizedBox(height: 12),
                  ],
                ),
              ),

              // Container(
              //   width: double.infinity,
              //   decoration: const BoxDecoration(color: Color(0xffFF0000)),
              //   child: Padding(
              //     padding: const EdgeInsets.symmetric(
              //       horizontal: horizontalPadding,
              //       vertical: 20,
              //     ),
              //     child: Column(
              //       crossAxisAlignment: CrossAxisAlignment.start,
              //       mainAxisAlignment: MainAxisAlignment.start,
              //       children: [
              //         Row(
              //           mainAxisAlignment: MainAxisAlignment.center,
              //           children: [
              //             Image.asset('assets/images/logoii.png', height: 100),
              //             const SizedBox(width: 8),
              //             Text(
              //               'Health',
              //               style: GoogleFonts.poppins(
              //                 fontSize: 32,
              //                 fontWeight: FontWeight.w600,
              //                 color: const Color(0xffFFFFFF),
              //               ),
              //             ),
              //           ],
              //         ),
              //
              //         const SizedBox(height: 12),
              //         Text(
              //           'Heart Disease Prediction App is a smart clinical decision support system built to assist doctors in assessing heart disease risk using patient medical data.',
              //           style: GoogleFonts.poppins(
              //             fontWeight: FontWeight.w400,
              //             color: Color(0xffFFFFFF),
              //             fontSize: 16,
              //           ),
              //         ),
              //         const SizedBox(height: 30),
              //
              //         Divider(color: Color(0xffFFFFFF), thickness: 1.5),
              //         Row(
              //           children: [
              //             Icon(
              //               Icons.copyright_outlined,
              //               color: Color(0xffFFFFFF),
              //               size: 20,
              //             ),
              //             const SizedBox(width: 8),
              //             Text(
              //               '2025 Logic Health. All Rights Reserved.',
              //               style: GoogleFonts.poppins(
              //                 color: Color(0xffFFFFFF),
              //                 fontSize: 14,
              //                 fontWeight: FontWeight.w400,
              //               ),
              //             ),
              //           ],
              //         ),
              //       ],
              //     ),
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
