import 'package:flutter/material.dart';
import 'package:flutter_shopping_77/screens/storyproductstyle.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false, // Remove debug banner
      home: ResponsivePage(),
    );
  }
}

class ResponsivePage extends StatefulWidget {
  const ResponsivePage({super.key});

  @override
  State<ResponsivePage> createState() => _ResponsivePageState();
}

class _ResponsivePageState extends State<ResponsivePage> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // Image container
          Positioned(
            top: screenHeight * 0.1,
            left: screenWidth * 0.05,
            child: Container(
              width: screenWidth * 0.89,
              height: screenHeight * 0.76,
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    offset: const Offset(0, 5),
                    blurRadius: 10,
                  ),
                ],
                borderRadius: BorderRadius.circular(12),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.asset(
                  'assets/images/img26.png',
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),

          // First button (blue dot)
          Positioned(
            top: screenHeight * 0.33,
            left: screenWidth * 0.24,
            child: GestureDetector(
              onTap: () {
                debugPrint('Blue dot tapped!');
              },
              child: Container(
                width: 23,
                height: 23,
                decoration: BoxDecoration(
                  color: const Color(0xFF004CFF),
                  border: Border.all(color: Colors.white, width: 3),
                  shape: BoxShape.circle,
                ),
              ),
            ),
          ),

          // Second button with dialog (white circle)
         Positioned(
  top: screenHeight * 0.52,
  left: screenWidth * 0.63,
  child: GestureDetector(
    onTap: () {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            backgroundColor: Colors.transparent,
            child: LayoutBuilder(
              builder: (context, constraints) {
                double dialogWidth = constraints.maxWidth;
                double dialogHeight = constraints.maxHeight;

                return Stack(
                  children: [
                    // Popup image (positioned dynamically)
                    Positioned(
                      top: dialogHeight * 0.51,
                      left: dialogWidth * 0.17,
                      child: Container(
                        width: dialogWidth * 0.52,
                        height: dialogHeight * 0.22,
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(7),
                            topRight: Radius.circular(7),
                             bottomLeft: Radius.circular(7),
                              bottomRight: Radius.circular(7),
                          ),
                          border: Border.all(
                            color: Colors.white,
                            width: 9,
                          ),
                        ),
                        child: ClipRRect(
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(7),
                            topRight: Radius.circular(7),
                              bottomLeft: Radius.circular(7),
                              bottomRight: Radius.circular(7),
                          ),
                          child: Image.asset(
                            'assets/images/img22.png',
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  
                              // Popup button
                              Positioned(
                                top: dialogHeight * 0.72,
                                left: dialogWidth * 0.17,
                                child: GestureDetector(
                                  onTap: () {
                                     Navigator.pushNamed(context, '/storyproductstyle');
                                  },
                                  child: Container(
                                    width: dialogWidth * 0.52,
                                    height: 50,
                                    decoration: BoxDecoration(
                                      color: const Color(0xFF004CFF),
                                      borderRadius: BorderRadius.circular(9),
                                      border: Border.all(
                                        color: Colors.white,
                                        width: 9,
                                      ),
                                    ),
                                    child: const Center(
                                      child: Text(
                                        'Shop',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    );
                  },
                );
              },
              child: Container(
                width: 23,
                height: 23,
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: const Color(0xFF004CFF), width: 3),
                  shape: BoxShape.circle,
                ),
              ),
            ),
          ),

          // Slide bar (scroll indicator)
          Positioned(
            top: screenHeight * 0.87,
            left: screenWidth * 0.36,
            child: Row(
              children: [
                for (int i = 0; i < 6; i++)
                  if (i == 2)
                    Container(
                      width: 27,
                      height: 10,
                      margin: const EdgeInsets.symmetric(horizontal: 3),
                      decoration: BoxDecoration(
                        color: const Color(0xFF004CFF),
                        borderRadius: BorderRadius.circular(5),
                      ),
                    )
                  else
                    Container(
                      width: 10,
                      height: 10,
                      margin: const EdgeInsets.symmetric(horizontal: 3),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.2),
                        shape: BoxShape.circle,
                      ),
                    ),
              ],
            ),
          ),

          // Bottom navigation bar
          Positioned(
            bottom: 0,
            left: 0,
            child: Container(
              width: screenWidth,
              height: screenHeight * 0.087,
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    offset: const Offset(0, -1),
                    blurRadius: 1,
                  ),
                ],
                color: Colors.white,
              ),
              child: BottomNavigationBar(
                type: BottomNavigationBarType.fixed,
                backgroundColor: Colors.white,
                selectedItemColor: const Color(0xFF004CFF),
                unselectedItemColor: Colors.black,
                showSelectedLabels: false,
                showUnselectedLabels: false,
                items: const [
                  BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
                  BottomNavigationBarItem(icon: Icon(Icons.favorite), label: "Wishlist"),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.category_outlined), label: "Categories"),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.shopping_cart), label: "Cart"),
                  BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
                ],
              
              ),
            ),
          ),
        ],
      ),
    );
  }
}
