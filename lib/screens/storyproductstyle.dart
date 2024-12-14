import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ShoppingPage(),
    );
  }
}

class ShoppingPage extends StatelessWidget {
  const ShoppingPage({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Stack(
          children: [
            // Image and shadow container
            Positioned(
              top: 58,
              left: 25,
              child: Container(
                width: 335,
                height: 556,
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      offset: const Offset(0, 5),
                      blurRadius: 10,
                    ),
                  ],
                  borderRadius: BorderRadius.circular(9),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(9),
                  child: Image.asset(
                    'assets/images/img25.png', // Replace with your image path
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),

           // Text and Button Container
Positioned(
  top: 605,
  left: 20,
  right: 20,
  child: Padding(
    padding: const EdgeInsets.all(15),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Column for splitting text into two lines
        const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Lorem ipsum dolor sit amet,",
              style: TextStyle(
                fontFamily: 'Nunito Sans',
                fontSize: 12,
                fontWeight: FontWeight.w400,
                height: 1.4, // Line height adjustment
              ),
            ),
            SizedBox(height: 4), // Add space between the lines
            Text(
              "consectetur adipiscing elit.",
              style: TextStyle(
                fontFamily: 'Nunito Sans',
                fontSize: 12,
                fontWeight: FontWeight.w400,
                height: 1.4,
              ),
            ),
          ],
        ),
   const SizedBox(width: 10),
        // "Shop" button
        ElevatedButton(
          onPressed: () {
             Navigator.pushNamed(context, '/wishlist');
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF004CFF),
            minimumSize: const Size(120, 40),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(11),
            ),
          ),
          child: const Text(
            "Shop",
            style: TextStyle(
              color: Color(0xFFF3F3F3),
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    ),
  ),
),

            // Scroll Indicator
            Positioned(
              top: screenHeight * 0.84,
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

            // Bottom Navigation Bar
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: BottomNavigationBar(
                type: BottomNavigationBarType.fixed,
                backgroundColor: Colors.white,
                selectedItemColor: const Color(0xFF004CFF),
                unselectedItemColor: Colors.black,
                showSelectedLabels: false,
                showUnselectedLabels: false,
                items: const [
                  BottomNavigationBarItem(
                      icon: Icon(Icons.home), label: "Home"),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.favorite), label: "Wishlist"),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.category_outlined), label: "Categories"),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.shopping_cart), label: "Cart"),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.person), label: "Profile"),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
