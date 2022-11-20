import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class SliderBanner extends StatefulWidget {
  const SliderBanner({Key? key}) :  super(key: key);

  @override
  State<SliderBanner> createState() => _SliderBannerState();
}

class _SliderBannerState extends State<SliderBanner> {
  int activeIndex = 0;
  final images = [
    'assets/images/banner/banner1.png',
    'assets/images/banner/banner2.png',
    'assets/images/banner/banner3.png',
    'assets/images/banner/banner4.png'
  ];

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Center(
          child: CarouselSlider.builder(
            options: CarouselOptions(
              height: 170.0,
              autoPlay: true,
              reverse: true,
              viewportFraction: 0.9,
              autoPlayInterval: const Duration(seconds: 3),
              enlargeCenterPage: true,
              enlargeStrategy: CenterPageEnlargeStrategy.height,
              onPageChanged: (index, reason) => 
                setState(() => activeIndex = index),
            ),
            itemCount: images.length,
            itemBuilder: (context, index, realIndex) {
              final image = images[index];
              return buildImage(image, index);
            },
          ),
        ),
        Positioned(
          bottom: 0,
          right: 0,
          left: 0,
          child: Padding(
            padding: const EdgeInsets.only(bottom: 5),
            child: Center(child: buildIndicator()),
          )
        )
      ],
    );
  }

  
  Widget buildImage(String image, int index) => Container(
    margin: const EdgeInsets.symmetric(horizontal: 5),
    child: ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: Image.asset(
          image,
          fit: BoxFit.fill,
        ),
    ),
    
  );

  Widget buildIndicator() => AnimatedSmoothIndicator(
    activeIndex: activeIndex,
    count: images.length,
    effect: const ExpandingDotsEffect(
      dotHeight: 10,
      dotWidth: 10,
      activeDotColor: Color(0xFF0C9869),
      dotColor: Colors.white70
    ),
  );
}


