import 'dart:math';
import 'package:flutter/material.dart';

void main() {
  runApp(const WishlistApp());
}

class WishlistApp extends StatelessWidget {
  const WishlistApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: WishlistPage(),
    );
  }
}

class WishlistPage extends StatelessWidget {
  final List<String> recentlyViewedImages = [
    'assets/images/img27.png', // Replace with actual image paths
    'assets/images/img28.png',
    'assets/images/img29.png',
    'assets/images/img30.png',
    'assets/images/img31.png',
  ];

  final List<Map<String, String>> mostPopularItems = [
    {
      'image': 'assets/images/img20.png',
      'price': '1780',
      'tag': 'New',
    },
    {
      'image': 'assets/images/img21.png',
      'price': '1780',
      'tag': 'Sale',
    },
    {
      'image': 'assets/images/img23.png',
      'price': '1780',
      'tag': 'Hot',
    },
    {
      'image': 'assets/images/img24.png',
      'price': '1780',
      'tag': 'Trending',
    },
  ];

  WishlistPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Get the screen size using MediaQuery
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    // Determine sizes based on screen width
    double appBarTitleFontSize = screenWidth * 0.07;
    double sectionTitleFontSize = screenWidth * 0.05;
    double heartIconSize = screenWidth * 0.35;
    double heartSize = heartIconSize * 0.2;
    double recentImagesSize = screenWidth * 0.12;
    double mostPopularHeight = screenHeight * 0.2;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          'Wishlist',
          style: TextStyle(
            fontFamily: 'Raleway',
            fontSize: appBarTitleFontSize,
            fontWeight: FontWeight.bold,
            color: const Color(0xFF202020),
          ),
        ),
        centerTitle: false,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),
            // Recently Viewed Section
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Recently viewed',
                  style: TextStyle(
                    fontFamily: 'Raleway',
                    fontSize: sectionTitleFontSize,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF202020),
                  ),
                ),
                Container(
                  width: screenWidth * 0.08,
                  height: screenWidth * 0.08,
                  decoration: const BoxDecoration(
                    color: Color(0xFF004CFF),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.arrow_forward,
                    color: Colors.white,
                    size: 16,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            // Recently Viewed Images
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: recentlyViewedImages.map((imagePath) {
                return ClipOval(
                  child: Container(
                    width: recentImagesSize,
                    height: recentImagesSize,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                    ),
                    child: Image.asset(
                      imagePath,
                      fit: BoxFit.cover, // Ensures image fills the container
                    ),
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 70),
            // Heart Icon with Rays Section
            Center(
        child: SizedBox(
             width: heartIconSize,
            height: heartIconSize,
            child: Image.asset(
              'assets/images/img32.png', // Ensure the path is correct
               fit: BoxFit.contain, // Adjusts the image to fit within the specified size
             ),
              ),
               ),
            const SizedBox(height: 80), // Add some space before "Most Popular" section
            // Most Popular Section
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Most Popular',
                  style: TextStyle(
                    fontFamily: 'Raleway',
                    fontSize: sectionTitleFontSize,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF202020),
                  ),
                ),
                Row(
                  children: [
                    InkWell(
                      onTap: () {
                        // Action when "See All" is tapped
                      },
                      child: const Text(
                        'See All',
                        style: TextStyle(
                          fontFamily: 'Raleway',
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF202020),
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                    const SizedBox(width: 10), // Spacing between "See All" and the button
                    GestureDetector(
                      onTap: () {
                        // Action when arrow button is tapped
                      },
                      child: Container(
                        width: 30,
                        height: 30,
                        decoration: const BoxDecoration(
                          color: Color(0xFF004CFF), // Blue color for the button
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.arrow_forward,
                          color: Colors.white,
                          size: 16,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 20),
            // Scrollable Most Popular Items
            SizedBox(
              height: mostPopularHeight,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: mostPopularItems.length,
                itemBuilder: (context, index) {
                  final item = mostPopularItems[index];
                  return Padding(
                    padding: const EdgeInsets.only(right: 15),
                    child: Container(
                      width: screenWidth * 0.4,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.grey[200],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: ClipRRect(
                              borderRadius: const BorderRadius.vertical(
                                top: Radius.circular(8),
                              ),
                              child: Image.asset(
                                item['image']!,
                                fit: BoxFit.cover, // Ensures image fills the box
                                width: double.infinity,
                                height: double.infinity,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Text(
                                  item['price']!,
                                  style: const TextStyle(
                                    fontFamily: 'Raleway',
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(width: 2),
                                const Icon(
                                  Icons.favorite,
                                  size: 12,
                                  color: Colors.blue,
                                ),
                                const Spacer(),
                                Text(
                                  item['tag']!,
                                  style: const TextStyle(
                                    fontFamily: 'Raleway',
                                    fontSize: 13,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        height: 80, // Set the height you desire
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          currentIndex: 1,
          selectedItemColor: const Color(0xFF004CFF),
          unselectedItemColor: Colors.black,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(icon: Icon(Icons.favorite), label: 'Wishlist'),
            BottomNavigationBarItem(icon: Icon(Icons.category_outlined), label: 'Categories'),
            BottomNavigationBarItem(icon: Icon(Icons.shopping_cart), label: 'Cart'),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
          ],
        ),
      ),
    );
  }
}

// Custom Painter for Heart with Rays
class HeartWithRaysPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = const Color(0xFF004CFF)
      ..strokeWidth = 3
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    // Center of the circle
    final double centerX = size.width / 2;
    final double centerY = size.height / 2;

    const double rayLength = 20; // Length of the rays
    const double raySpacing = 30; // Angle between rays
    const double radius = 20; // Radius from the center for ray positioning (just outside the heart)
    const double heartSize = 25; // Size of the heart

    // Draw the rays around the heart, just touching the heart
    for (int i = 0; i < 12; i++) {
      double angle = i * raySpacing * 3.14159 / 180;
      double startX = centerX + radius * cos(angle); // Start position of ray (just outside the heart)
      double startY = centerY + radius * sin(angle);
      double endX = centerX + (radius + rayLength) * cos(angle); // End position of ray
      double endY = centerY + (radius + rayLength) * sin(angle);

      canvas.drawLine(
        Offset(startX, startY),
        Offset(endX, endY),
        paint,
      );
    }

    // Draw the heart in the center
    final Path heartPath = Path();
    // Adjusting the cubic bezier to center the heart properly
    heartPath.moveTo(centerX, centerY + heartSize / 4);
    heartPath.cubicTo(
      centerX - heartSize / 2, centerY - heartSize / 2, // Control point 1
      centerX - heartSize, centerY + heartSize / 4, // Control point 2
      centerX, centerY + heartSize / 2, // Endpoint
    );
    heartPath.cubicTo(
      centerX + heartSize, centerY + heartSize / 4, // Control point 1
      centerX + heartSize / 2, centerY - heartSize / 2, // Control point 2
      centerX, centerY + heartSize / 4, // Endpoint
    );

    canvas.drawPath(heartPath, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
