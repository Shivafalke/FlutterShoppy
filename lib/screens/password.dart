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
      home: PassWordUpdate(),
    );
  }
}

class PassWordUpdate extends StatefulWidget {
  const PassWordUpdate({super.key});

  @override
  _PassWordUpdateState createState() => _PassWordUpdateState();
}

class _PassWordUpdateState extends State<PassWordUpdate> {
  String password = ""; // Variable to hold the entered password

  void updatePassword(String value) {
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
              top: screenHeight * 0.5,
              left: screenWidth * 0.6,
              child: Transform.rotate(
                angle: -155 * 3.14159 / 180, // Convert to radians
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
                          image: AssetImage('assets/images/img19.png'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            
            // Title Text
            Positioned(
              top: screenHeight * 0.32,
              left: screenWidth * 0.250,
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
              left: screenWidth * 0.245,
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
            // Password input (4 Text Fields)
            Positioned(
              top: screenHeight * 0.48,
              left: screenWidth * 0.2,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildPasswordTextField(),
                  SizedBox(width: screenWidth * 0.02),
                  _buildPasswordTextField(),
                  SizedBox(width: screenWidth * 0.02),
                  _buildPasswordTextField(),
                  SizedBox(width: screenWidth * 0.02),
                  _buildPasswordTextField(),
                ],
              ),
            ),
            // Arrow Button
            Positioned(
              top: screenHeight * 0.832,
              left: screenWidth * 0.52,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/passwordUpdate');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF004CFF),
                  shape: const CircleBorder(),
                  minimumSize: Size(screenWidth * 0.005, screenHeight * 0.039),
                ),
                child: Icon(
                  Icons.arrow_forward,
                  color: Colors.white,
                  size: screenWidth * 0.05,
                ),
              ),
            ),
            // "Not you?" Text
            Positioned(
              top: screenHeight * 0.85,
              left: screenWidth * 0.35,
              child: GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, '/createAccount');
                },
                child: Text(
                  'Not you?',
                  style: TextStyle(
                    fontFamily: 'Nunito Sans',
                    fontSize: screenWidth * 0.045,
                    fontWeight: FontWeight.w300,
                    color: const Color(0xFF202020),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPasswordTextField() {
    return Container(
      width: 49.3,
      height: 50.56,
      padding: const EdgeInsets.symmetric(horizontal: 12.64, vertical: 10.74),
      decoration: BoxDecoration(
        color: const Color(0xFFF8F8F8),
        borderRadius: BorderRadius.circular(10.11),
      ),
      child: const TextField(
        obscureText: true,
        decoration: InputDecoration(
          border: InputBorder.none,
        ),
      ),
    );
  }
}
