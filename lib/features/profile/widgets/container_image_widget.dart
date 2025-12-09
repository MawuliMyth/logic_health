import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ContainerImageWidget extends StatelessWidget {
  const ContainerImageWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 300, // adjust as you want
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        // 1. Remove the gradient from here. The image will now be the base layer.
        image: const DecorationImage(
          image: AssetImage("assets/images/hand.jpg"),
          fit: BoxFit.cover,
        ),
      ),
      child: Stack(
        children: [
          // 2. Add the gradient as a separate Container layer inside the Stack.
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(
                    0xff666666,
                  ), // Use Colors.transparent for better clarity
                  const Color(
                    0xff000000,
                  ).withOpacity(0.0), // Start fully transparent
                  const Color(
                    0xff000000,
                  ).withOpacity(0.8), // End semi-transparent black
                ],
              ),
            ),
          ),

          // 3. Keep the content (Text widgets) aligned to the bottom.
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 20.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "About Us",
                    style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "The leading heart disease prediction app",
                    style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontSize: 8,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
