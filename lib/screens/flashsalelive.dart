 import 'dart:async';

import 'package:flutter/material.dart';

void main() {
  runApp(FlashSalePage());
}

class FlashSalePage extends StatefulWidget {
  const FlashSalePage({super.key});

  @override
  _FlashSalePageState createState() => _FlashSalePageState();
}

class _FlashSalePageState extends State<FlashSalePage> {
  String selectedTab = "20%"; // Default selected tab

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final double horizontalPadding = screenSize.width * 0.03;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          toolbarHeight: screenSize.height * 0.067,
          title: const Text(
            'Flash Sale',
            style: TextStyle(
              color: Color(0xFF202020),
              fontFamily: 'Raleway',
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: false,
           leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.black),
           onPressed: () {
          Navigator.pop(context); // Pops the current page from the navigation stack
        },
      ),
          actions: [
            TimerWidget(),
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSectionHeader(
                "Choose Your Discount",
                horizontalPadding: horizontalPadding,
              ),
              _buildDiscountTabs(horizontalPadding),
              _buildBanner(horizontalPadding),
              _buildSectionHeader(
                "$selectedTab Discount",
                showFilter: true,
                horizontalPadding: horizontalPadding,
              ),
              _buildProductGrid(horizontalPadding),
            ],
          ),
        ),
        bottomNavigationBar: _buildBottomNavigationBar(),
      ),
    );
  }

  Widget _buildSectionHeader(String title,
      {bool showFilter = false, double horizontalPadding = 0}) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: horizontalPadding, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontFamily: 'Raleway',
              fontSize: 17.5,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          if (showFilter) const Icon(Icons.filter_list, color: Colors.black),
        ],
      ),
    );
  }

  Widget _buildDiscountTabs(double horizontalPadding) {
    final List<String> discounts = ["All", "10%", "20%", "30%", "40%", "50%"];

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: discounts.map((discount) {
          final bool isSelected = selectedTab == discount;
          return GestureDetector(
            onTap: () {
               Navigator.pushNamed(context, '/flashsale');
              setState(() {
                selectedTab = discount; // Update selected tab
              });
              
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 11, vertical: 4),
              decoration: BoxDecoration(
                color: isSelected ? Colors.blue : Colors.grey.shade300,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                discount,
                style: TextStyle(
                  fontFamily: 'Raleway',
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: isSelected ? Colors.white : Colors.black,
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }


  Widget _buildBanner(double horizontalPadding) {
    final screenSize = MediaQuery.of(context).size;
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(13),
        border: Border.all(color: const Color(0xFFE9E5E5)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(13),
            child: Image.asset(
              'assets/images/img8.png',
              width: double.infinity,
              height: screenSize.height * 0.2,
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).size.height * (130 / 800),
            right: 10,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
              decoration: BoxDecoration(
                color: const Color(0xFF08C514),
                borderRadius: BorderRadius.circular(4),
              ),
              child: const Text(
                'Live',
                style: TextStyle(
                  fontFamily: 'Raleway',
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProductGrid(double horizontalPadding) {
  final screenWidth = MediaQuery.of(context).size.width;
  final double adjustedChildAspectRatio = screenWidth < 600 ? 0.69 : 0.7;

  // Calculate cross axis count based on screen size
  final crossAxisCount = screenWidth < 1000
      ? 2 // 2 columns for small screens
      : screenWidth < 1000
          ? 3 // 3 columns for medium screens
          : 4; // 4 columns for large screens

  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 0),
    child: GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount, // Use dynamic column count
        crossAxisSpacing: screenWidth * 0.02,
        mainAxisSpacing: screenWidth * 0.02,
        childAspectRatio: adjustedChildAspectRatio, // Use the calculated aspect ratio
        ),
        itemCount: 4,
        itemBuilder: (context, index) {
          return ProductCard(
            imagePath: 'assets/images/img${9 + index}.png',
            title: "Lorem ipsum dolor sit amet consectetur",
            price: "16,00",
            discountedPrice: "20,00",
          );
        },
      ),
    );
  }

  


  Widget _buildBottomNavigationBar() {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      backgroundColor: Colors.white,
      selectedItemColor: const Color(0xFF004CFF),
      unselectedItemColor: Colors.black,
      showSelectedLabels: false,
      showUnselectedLabels: false,
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
        BottomNavigationBarItem(icon: Icon(Icons.favorite), label: "Wishlist"),
        BottomNavigationBarItem(icon: Icon(Icons.category_outlined), label: "Categories"),
        BottomNavigationBarItem(icon: Icon(Icons.shopping_cart), label: "Cart"),
        BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
      ],
    );
  }
}


class TimerWidget extends StatefulWidget {
  const TimerWidget({super.key});

  @override
  _TimerWidgetState createState() => _TimerWidgetState();
}

class _TimerWidgetState extends State<TimerWidget> {
  late Timer _timer;
  Duration _timeLeft = const Duration( minutes: 36, seconds: 58); // Adjusted to hours

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_timeLeft.inSeconds > 0) {
        setState(() {
          _timeLeft = _timeLeft - const Duration(seconds: 1);
        });
      } else {
        _timer.cancel();
      }
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  String _formatTime(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0'); // Ensures 2 digits for time
    String hours = twoDigits(duration.inHours);
    String minutes = twoDigits(duration.inMinutes.remainder(60));
    String seconds = twoDigits(duration.inSeconds.remainder(60));
    return "$hours:$minutes:$seconds"; // Return formatted time string
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 2),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
     
       child: Row(
        mainAxisAlignment: MainAxisAlignment.center, // Align horizontally centered
        children: [
          // Timer Icon
          const Icon(
            Icons.timer,
            color: Colors.black,
            size: 24, // Adjust the size of the icon
          ),
          const SizedBox(width: 10), // Space between the icon and the time
          // Hour Box
          _buildTimeBox(_timeLeft.inHours),
          const SizedBox(width: 4),
          // Minute Box
          _buildTimeBox(_timeLeft.inMinutes.remainder(60)),
          const SizedBox(width: 4),
          // Second Box
          _buildTimeBox(_timeLeft.inSeconds.remainder(60)),
        ],
      ),
    );
  }

  // Helper function to build a box for each time component (hour, minute, second)
  Widget _buildTimeBox(int time) {
    return Container(
      width: 30, // Width of the box
      height: 30, // Height of the box
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(9),
          topRight: Radius.circular(9),
          bottomLeft: Radius.circular(9),
          bottomRight: Radius.circular(9),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 5,
            offset: const Offset(1, 2),
          ),
        ],
      ),
      child: Center(
        child: Text(
          time.toString().padLeft(2, '0'), // Format number with 2 digits
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}


class DiscountTab extends StatelessWidget {
  final String label;
  final bool selected;

  const DiscountTab({super.key, 
    required this.label,
    required this.selected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 5 , horizontal: 12.2),
      decoration: BoxDecoration(
        color: selected ? Colors.blue : const Color.fromARGB(0, 233, 230, 230),
        borderRadius: BorderRadius.circular(7),
        border: Border.all(
          color: selected ? Colors.transparent : Colors.black,
        ),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: selected ? Colors.white : Colors.black,
          fontSize: 14,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}


class ProductCard extends StatelessWidget {
  final String imagePath;
  final String title;
  final String price;
  final String discountedPrice;

  const ProductCard({super.key, 
    required this.imagePath,
    required this.title,
    required this.price,
    required this.discountedPrice,
  });

  // Function to format the price and apply custom styles
  Widget buildFormattedPrice(String price) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Loop through each character in the price, but handle $ sign separately
        const Text(
          '\$', // Directly add the dollar symbol
          style: TextStyle(
            fontSize: 20, // Font size for the $ symbol
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        // Loop through the remaining price string (after the $ symbol)
        ...price.split('').map((char) {
          if (char == '6') {
            // Special handling for '6' to make it raised slightly
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 0.0),
              child: Transform.translate(
                offset: const Offset(0, -0.8), // Move '6' slightly up
                child: Text(
                  char,
                  style: const TextStyle(
                    fontSize: 20, // Same font size for '6'
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
            );
          }

          // Default styling for all other characters
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 0),
            child: Text(
              char,
              style: const TextStyle(
                fontSize: 17, // Default font size for other digits
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          );
        }).toList(),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 175, // Width of the container
          height: 151, // Height of the container
          padding: const EdgeInsets.all(4), // Thin padding for the white layer
          decoration: BoxDecoration(
            color: Colors.white, // White layer color
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(9),
              topRight: Radius.circular(9),
              bottomLeft: Radius.circular(9),
              bottomRight: Radius.circular(9),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                offset: const Offset(2, 5),
                blurRadius: 10,
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(9), // Slightly smaller to match padding
              topRight: Radius.circular(9),
              bottomLeft: Radius.circular(9),
              bottomRight: Radius.circular(9),
            ),
            child: Stack(
              children: [
                Image.asset(
                  imagePath,
                  width: double.infinity,
                  height: double.infinity,
                  fit: BoxFit.cover,
                ),
                Positioned(
                  top: 0,
                  right: 0,
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                        colors: [
                          Color(0xFFFF5790),
                          Color(0xFFF81140),
                        ],
                      ),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: const Text(
                      '-20%',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          title,
          style: const TextStyle(
            fontSize: 12,
            color: Color(0xFF000000),
          ),
        ),
        Row(
          children: [
            buildFormattedPrice(price), // Use the formatted price here
            const SizedBox(width: 8),
            Text(
              "\$$discountedPrice",
              style: const TextStyle(
                fontSize: 14,
                decoration: TextDecoration.lineThrough,
                color: Color(0xFFF1AEAE),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

