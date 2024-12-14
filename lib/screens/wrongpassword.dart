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
      home: Wrongpassword(),
    );
  }
}

class Wrongpassword extends StatefulWidget {
  const Wrongpassword({super.key});

  @override
  _WrongPasswordState createState() => _WrongPasswordState();
}

class _WrongPasswordState extends State<Wrongpassword> {
  String password = ""; // Variable to hold the entered password

  void Wrongpassword(String value) {
    setState(() {
      if (password.length < 8) {
        password += value; // Add the value to the password
      }
    });
  }

  void deleteLastChar() {
    setState(() {
      if (password.isNotEmpty) {
        password = password.substring(0, password.length - 1); // Remove last character
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SizedBox(
        width: screenWidth, // Full screen width
        height: screenHeight, // Full screen height
        child: Stack(
          children: [
            // Bubble 01
            Positioned(
              top: -screenHeight * 0.2,
              left: -screenWidth * 0.4,
              child: Container(
                width: screenWidth,
                height: screenHeight * 0.55,
                decoration: const BoxDecoration(
                  color: Color(0xFF004BFE),
                  shape: BoxShape.circle,
                ),
              ),
            ),
            // Bubble 02
            Positioned(
              top: screenHeight * 0.4,
              left: screenWidth * 0.6,
              child: Transform.rotate(
                angle: -158 * 3.14159 / 180, // Convert to radians
                child: Container(
                  width: screenWidth,
                  height: screenHeight * 0.3,
                  decoration: const BoxDecoration(
                    color: Color(0xFFD9E4FF),
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ),
            // Profile image background (Ellipse)
            Positioned(
              top: screenHeight * 0.14,
              left: screenWidth * 0.34,
              child: GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, '/passwordrecovery');
                },
                child: Container(
                  width: screenWidth * 0.3,
                  height: screenWidth * 0.3,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.16),
                        blurRadius: 5,
                        spreadRadius: 0,
                        offset: const Offset(0, 0),
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Container(
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: AssetImage('assets/images/img6.png'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            // Title Text
            Positioned(
              top: screenHeight * 0.32,
              left: screenWidth * 0.27,
              child: Text(
                'Hello, Romina!!',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Raleway',
                  fontSize: screenWidth * 0.07,
                  fontWeight: FontWeight.w700,
                  height: 36 / 28,
                  letterSpacing: -0.28,
                  color: const Color(0xFF202020),
                ),
              ),
            ),
            // Subtitle Text
            Positioned(
              top: screenHeight * 0.40,
              left: screenWidth * 0.26,
              child: Text(
                'Type your password',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Nunito Sans',
                  fontSize: screenWidth * 0.049,
                  fontWeight: FontWeight.w300,
                  height: 35 / 19,
                  color: const Color(0xFF000000),
                ),
              ),
            ),
            // Dots (Password Indicators)
            Positioned(
              top: screenHeight * 0.46,
              left: screenWidth * 0.22,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  8,
                  (index) => Padding(
                    padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.015),
                    child: Container(
                      width: screenWidth * 0.04,
                      height: screenWidth * 0.04,
                      decoration: BoxDecoration(
                        color: index < password.length
                            ? const Color(0xFFEC4E4E)
                            : const Color(0xFFE0E0E0), // Active/Inactive dots
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              top: screenHeight * 0.53,
              left: screenWidth * 0.28,
              child: Text(
                'Forgot your password?',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Nunito Sans',
                  fontSize: screenHeight * 0.018,
                  fontWeight: FontWeight.w300,
                  height: 26 / 15,
                  color: const Color(0xFF202020),
                ),
              ),
            ),
            // Custom Keyboard
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                width: screenWidth,
                height: screenHeight * 0.35,
                color: const Color(0xFFCCCED3), // Keyboard background color
                child: Column(
                  children: [
                    SizedBox(height: screenHeight * 0.01), // Top gap
                    // First Row
                    buildKeyRow(['Q', 'W', 'E', 'R', 'T', 'Y', 'U', 'I', 'O', 'P']),
                    SizedBox(height: screenHeight * 0.015),
                    // Second Row
                    buildKeyRow(['A', 'S', 'D', 'F', 'G', 'H', 'J', 'K', 'L']),
                    SizedBox(height: screenHeight * 0.015),
                    // Third Row
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        buildKeyContainer(
                          null,
                          width: MediaQuery.of(context).size.width * (42 / 390),
                          icon: Icons.arrow_upward,
                          iconColor: Colors.black,
                          color: const Color(0xFFFCFCFE),
                          onTap: () => Wrongpassword("UP"),
                        ),
                        SizedBox(width: screenWidth * 0.02),
                        buildKeyRow(['Z', 'X', 'C', 'V', 'B', 'N', 'M']),
                        SizedBox(width: screenWidth * 0.01),
                        _buildSpecialKey(
                          Icons.backspace,
                          iconColor: Colors.black,
                          backgroundColor: const Color(0xFF898A8D),
                          onTap: deleteLastChar,
                        ),
                      ],
                    ),
                    SizedBox(height: screenHeight * 0.02),
                    // Bottom Row
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        buildKeyContainer('123', width: screenWidth * 0.22, color: const Color(0xFF898A8D)),
                        buildKeyContainer('Space', width: screenWidth * 0.45, color: const Color(0xFFFCFCFE), onTap: () => Wrongpassword(" ")),
                        buildKeyContainer('Go', width: screenWidth * 0.22, color: const Color(0xFF898A8D)),
                      ],
                    ),
                    SizedBox(height: screenHeight * 0.018), // Adjusting height proportionally
                  ],
                ),
              ),
            ),
            Positioned(
              left: 0,
              right: 0,
              bottom: screenHeight * 0.02, // Adjust bottom margin proportionally
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween, // Space icons evenly across
                children: [
                  // Smiley Icon positioned below the '123' button
                  Padding(
                    padding: EdgeInsets.only(left: screenWidth * 0.056), // Adjusting left padding
                    child: Icon(
                      Icons.sentiment_satisfied_alt_outlined,
                      size: screenWidth * 0.08, // Adjusting icon size proportionally
                      color: const Color(0xFF50555C),
                    ),
                  ),
                  // Mic Icon positioned below the 'Go' button
                  Padding(
                    padding: EdgeInsets.only(right: screenWidth * 0.056), // Adjusting right padding
                    child: Icon(
                      Icons.mic,
                      size: screenWidth * 0.08, // Adjusting icon size proportionally
                      color: const Color(0xFF50555C),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildKeyRow(List<String> keys) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: keys.map((key) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: GestureDetector(
              onTap: () {
                Wrongpassword(key);
              },
              child: buildKeyContainer(key),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget buildKeyContainer(String? label, {double width = 30, double height = 42, Color color = const Color(0xFFFCFCFE), IconData? icon, Color iconColor = Colors.black, VoidCallback? onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(4.6),
          boxShadow: const [
            BoxShadow(
              color: Color(0xFF898A8D),
              blurRadius: 1,
              offset: Offset(0, 1),
            ),
          ],
        ),
        alignment: Alignment.center,
        child: label != null
            ? Text(
                label,
                style: const TextStyle(
                  fontFamily: 'Nunito Sans',
                  fontSize: 20,
                  fontWeight: FontWeight.w400,
                  color: Colors.black,
                ),
                textAlign: TextAlign.center,
              )
            : (icon != null
                ? Icon(
                    icon,
                    size: 24,
                    color: iconColor,
                  )
                : null),
      ),
    );
  }

  Widget _buildSpecialKey(IconData icon, {Color iconColor = Colors.black, Color backgroundColor = Colors.white, VoidCallback? onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: backgroundColor,
          shape: BoxShape.circle,
        ),
        alignment: Alignment.center,
        child: Icon(
          icon,
          color: iconColor,
          size: 24,
        ),
      ),
    );
  }
}
