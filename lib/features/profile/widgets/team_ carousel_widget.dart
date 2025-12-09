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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            "Meet The Team",
            style: GoogleFonts.poppins(
              fontSize: 22,
              fontWeight: FontWeight.w700,
              color: Colors.black,
            ),
          ),
        ),

        const SizedBox(height: 15),

        CarouselSlider.builder(
          itemCount: team.length,
          options: CarouselOptions(
            height: 350,
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
                      height: 60,
                      padding: const EdgeInsets.symmetric(horizontal: 15),
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
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                member.role,
                                style: GoogleFonts.poppins(
                                  color: Colors.white,
                                  fontSize: 11,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),

                          const Icon(
                            Icons.open_in_new,
                            color: Colors.white,
                            size: 20,
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
    );
  }
}
