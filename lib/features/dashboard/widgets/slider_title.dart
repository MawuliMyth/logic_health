import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SliderTitle extends StatelessWidget {
  final String text;
  const SliderTitle({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Text(
        text,
        style: GoogleFonts.poppins(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: Color(0xff000000),
        ),
      ),
    );
  }
}
