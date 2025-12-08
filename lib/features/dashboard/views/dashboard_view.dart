// lib/views/dashboard_view.dart
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:logic_health/features/dashboard/widgets/slider_title.dart';
import 'package:provider/provider.dart';

import '../../auth/provider/auth_provider.dart';
import '../widgets/event_slider_widget.dart';
import '../widgets/tips_carousel_card.dart';

class DashboardView extends StatelessWidget {
  static String id = '/dashboard';

  DashboardView({super.key});

  final List<String> eventImages = [
    'assets/images/musc.jpeg',
    'assets/images/po.jpeg',
    'assets/images/awre.jpeg',
  ];
  final List<TipItem> hostelTips = [
    const TipItem(
      imagePath: 'assets/images/sleep.png',
      title: 'Rest Smart',
      description:
          'Protect at least one block of deep sleep. Keep your room dark, cool, and quiet for quality rest. ',
    ),
    const TipItem(
      imagePath: 'assets/images/excer.jpg',
      title: 'Move a Little',
      description:
          'Short 5–10 minute workouts and walking between tasks help reduce stress and fatigue.',
    ),
    const TipItem(
      imagePath: 'assets/images/healt.jpeg',
      title: 'Eat to Stay Energized',
      description:
          'Carry healthy snacks and hydrate often. Balanced nutrition improves focus and mood',
    ),
    const TipItem(
      imagePath: 'assets/images/burn.jpg',
      title: 'Protect Your Energy',
      description:
          'Set boundaries, take micro-breaks, and avoid perfectionism. Your well-being matters.',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthProvider>(context);
    final firstName = (auth.user?.fullName ?? 'Colleague').split(' ').first;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(13),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset('assets/images/logoI.png', height: 50),
                  const SizedBox(width: 8),
                  Text(
                    'Home',
                    style: GoogleFonts.poppins(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Text(
                  'Good Morning, Dr.$firstName',
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              const SizedBox(height: 30),
              SliderTitle(text: 'Health Tips'),
              const SizedBox(height: 10),
              TipsCarouselCard(tips: hostelTips),
              const SizedBox(height: 30),
              SliderTitle(text: 'Events'),
              const SizedBox(height: 10),
              EventCarouselSlider(
                imagePaths: eventImages,
                autoPlayInterval: const Duration(seconds: 4),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
