import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class EventCarouselSlider extends StatefulWidget {
  final List<String> imagePaths;
  final bool autoPlay;
  final Duration autoPlayInterval;

  const EventCarouselSlider({
    super.key,
    required this.imagePaths,
    this.autoPlay = true,
    this.autoPlayInterval = const Duration(seconds: 6),
  });

  @override
  State<EventCarouselSlider> createState() => _EventCarouselSliderState();
}

class _EventCarouselSliderState extends State<EventCarouselSlider> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      height: size.height * 0.24,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey,
            spreadRadius: 2,
            blurRadius: 8.6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Stack(
          fit: StackFit.expand,
          children: [
            // Full Image Carousel
            CarouselSlider.builder(
              itemCount: widget.imagePaths.length,
              itemBuilder: (context, index, realIndex) {
                return Image.asset(
                  widget.imagePaths[index],
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: double.infinity,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      color: Colors.grey[300],
                      child: const Icon(
                        Icons.broken_image,
                        size: 60,
                        color: Colors.grey,
                      ),
                    );
                  },
                );
              },
              options: CarouselOptions(
                viewportFraction: 1.0,
                enlargeCenterPage: false,
                autoPlay: widget.autoPlay,
                autoPlayInterval: widget.autoPlayInterval,
                onPageChanged: (index, _) {
                  setState(() {
                    _currentIndex = index;
                  });
                },
              ),
            ),

            Positioned(
              bottom: 20,
              left: 0,
              right: 0,
              child: Center(
                child: AnimatedSmoothIndicator(
                  activeIndex: _currentIndex,
                  count: widget.imagePaths.length,
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
    );
  }
}
