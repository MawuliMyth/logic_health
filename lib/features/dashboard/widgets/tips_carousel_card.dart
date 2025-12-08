// lib/widgets/tips_carousel_card.dart

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class TipsCarouselCard extends StatefulWidget {
  final List<TipItem> tips;

  const TipsCarouselCard({super.key, required this.tips});

  @override
  State<TipsCarouselCard> createState() => _TipsCarouselCardState();
}

class _TipsCarouselCardState extends State<TipsCarouselCard> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      height: size.height * 0.23,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(color: Colors.grey, spreadRadius: 2, blurRadius: 8.6),
        ],
      ),
      child: Row(
        children: [
          // LEFT SIDE: TEXT CONTENT
          Expanded(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(24, 20, 16, 20),
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 500),
                transitionBuilder: (child, animation) =>
                    FadeTransition(opacity: animation, child: child),
                child: Column(
                  key: ValueKey(_currentIndex),
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.tips[_currentIndex].title,
                      style: const TextStyle(
                        fontSize: 19,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 14),

                    // DESCRIPTION — overflow-proof
                    Expanded(
                      child: SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
                        child: Text(
                          widget.tips[_currentIndex].description,
                          style: TextStyle(
                            fontSize: 14.5,
                            height: 1.6,
                            color: Colors.grey[700],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // RIGHT SIDE: IMAGE SLIDER
          Expanded(
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(10),
                bottomRight: Radius.circular(10),
              ),
              child: Stack(
                fit: StackFit.expand,
                children: [
                  CarouselSlider.builder(
                    itemCount: widget.tips.length,
                    itemBuilder: (context, index, realIndex) {
                      return Image.asset(
                        widget.tips[index].imagePath,
                        fit: BoxFit.cover,
                        width: double.infinity,
                        height: double.infinity,
                      );
                    },
                    options: CarouselOptions(
                      viewportFraction: 1.0,
                      enlargeCenterPage: false,
                      autoPlay: true,
                      autoPlayInterval: const Duration(seconds: 6),
                      onPageChanged: (index, _) {
                        setState(() => _currentIndex = index);
                      },
                    ),
                  ),

                  // PAGE INDICATOR
                  Positioned(
                    bottom: 20,
                    left: 0,
                    right: 0,
                    child: Center(
                      child: AnimatedSmoothIndicator(
                        activeIndex: _currentIndex,
                        count: widget.tips.length,
                        effect: const ExpandingDotsEffect(
                          dotHeight: 8,
                          dotWidth: 8,
                          spacing: 8,
                          activeDotColor: Color(0xffFF0000),
                          dotColor: Colors.white70,
                          expansionFactor: 3,
                        ),
                      ),
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

class TipItem {
  final String imagePath;
  final String title;
  final String description;

  const TipItem({
    required this.imagePath,
    required this.title,
    required this.description,
  });
}
