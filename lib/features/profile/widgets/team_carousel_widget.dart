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
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    final double baseWidth = 400.0;
    final double scaleFactor = screenWidth / baseWidth;

    final double horizontalPadding = screenWidth * 0.05;
    final double titleFontSize = 32 * scaleFactor * 0.9;
    final double carouselHeight = screenHeight * 0.45;
    final double nameFontSize = 14 * scaleFactor;
    final double roleFontSize = 11 * scaleFactor;
    final double gradientBarHeight = 60 * scaleFactor;

    return Container(
      color: const Color(0xffFFE7E7),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
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

          CarouselSlider.builder(
            itemCount: team.length,
            options: CarouselOptions(
              height: carouselHeight,
              autoPlay: true,
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

                    Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: Container(
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
                                    fontSize: nameFontSize,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Text(
                                  member.role,
                                  style: GoogleFonts.poppins(
                                    color: Colors.white,
                                    fontSize: roleFontSize,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),

                            Icon(
                              Icons.open_in_new,
                              color: Colors.white,
                              size: 20 * scaleFactor,
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
