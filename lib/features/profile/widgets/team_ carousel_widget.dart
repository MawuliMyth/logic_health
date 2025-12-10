import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:logic_health/features/profile/models/team_member_model.dart';

class TeamCarouselWidget extends StatelessWidget {
  TeamCarouselWidget({super.key});

  final List<TeamMember> team = [
    TeamMember(
      image: "assets/images/mm.png",
      name: "Joseph Mawule Mensah",
      role: "Mobile Developer",
    ),
    TeamMember(
      image: "assets/images/C.png",
      name: "Cyprian Anku",
      role: "AI/ML Engineer",
    ),
    TeamMember(
      image: "assets/images/A.png",
      name: "Albertina Agboli",
      role: "UI/UX Designer",
    ),
    TeamMember(
      image: "assets/images/M.png",
      name: "Joseph Micheal ",
      role: "PowerPoint Developer",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    // Get screen dimensions once for use throughout the widget
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    // Define responsive dimensions
    // The base size is good for a phone (e.g., width 400).
    // Scale factor: screenWidth / base_width (e.g., 400)
    final double baseWidth = 400.0;
    final double scaleFactor = screenWidth / baseWidth;

    // Define responsive padding and font sizes
    final double horizontalPadding = screenWidth * 0.05; // 5% of screen width
    final double titleFontSize =
        32 * scaleFactor * 0.9; // Scale down slightly on large screens
    final double carouselHeight = screenHeight * 0.45; // 45% of screen height
    final double nameFontSize = 14 * scaleFactor;
    final double roleFontSize = 11 * scaleFactor;
    final double gradientBarHeight = 60 * scaleFactor;

    return Container(
      // Keep background color
      color: const Color(0xffFFE7E7),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // --- Title: Scaled Font and Padding ---
          Padding(
            padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
            child: Text(
              "Meet The Team",
              style: GoogleFonts.poppins(
                // Use the calculated responsive font size
                fontSize: titleFontSize,
                fontWeight: FontWeight.w700,
                color: Colors.black,
              ),
            ),
          ),

          const SizedBox(height: 15),

          // --- Carousel Slider: Scaled Height ---
          CarouselSlider.builder(
            itemCount: team.length,
            options: CarouselOptions(
              // Use the calculated responsive height
              height: carouselHeight,
              autoPlay: true,
              // Keep viewportFraction relative to the screen size (0.85 is a good relative value)
              viewportFraction: 0.85,
              enlargeCenterPage: true,
              autoPlayInterval: const Duration(seconds: 3),
              enableInfiniteScroll: true,
            ),
            itemBuilder: (context, index, realIndex) {
              final member = team[index];

              return ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    Image.asset(member.image, fit: BoxFit.cover),

                    // --- Bottom Gradient Bar: Scaled Height and Font Size ---
                    Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: Container(
                        // Use the calculated responsive height
                        height: gradientBarHeight,
                        padding: EdgeInsets.symmetric(
                          horizontal: horizontalPadding * 0.6,
                        ), // Scale padding
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(
                            colors: [Color(0xffFF2D2D), Color(0xffD10000)],
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  member.name,
                                  style: GoogleFonts.poppins(
                                    color: Colors.white,
                                    // Use the calculated responsive font size
                                    fontSize: nameFontSize,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Text(
                                  member.role,
                                  style: GoogleFonts.poppins(
                                    color: Colors.white,
                                    // Use the calculated responsive font size
                                    fontSize: roleFontSize,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),

                            // --- Icon: Scaled Size ---
                            Icon(
                              Icons.open_in_new,
                              color: Colors.white,
                              size: 20 * scaleFactor, // Scale the icon size
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
