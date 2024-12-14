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
      home: PasswordRecoveryScreen(),
    );
  }
}

class PasswordRecoveryScreen extends StatelessWidget {
  const PasswordRecoveryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Get the screen width and height using MediaQuery
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // Top Section with Background Bubbles
         Positioned(
            top: -250,
            left: 170,
            right: -200,
            child: Container(
              width: width * 0.45,  // 45% of screen width
              height: height * 0.45, // 42% of screen height
              decoration: const BoxDecoration(
                color: Color(0xFF004BFE),
                shape: BoxShape.circle,
              ),
            ),
          ),
         
          Column(
            children: [
              SizedBox(height: height * 0.15), // Dynamic spacing based on screen height
              // Profile Picture
              Center(
                child: Container(
                  width: width * 0.28, // 28% of screen width
                  height: width * 0.28, // 28% of screen width (keeping it square)
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFFFFF),
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
                  child: const Padding(
                    padding: EdgeInsets.all(5.0),
                    child: CircleAvatar(
                      radius: 34,
                      backgroundImage: AssetImage('assets/images/img7.png'),
                    ),
                  ),
                ),
              ),
              SizedBox(height: height * 0.01), // Adjusted spacing
              // "Password Recovery" Text
              const Text(
                "Password Recovery",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Raleway',
                  fontSize: 21,
                  fontWeight: FontWeight.w700,
                  height: 1.875,
                  letterSpacing: -0.21,
                  color: Color(0xFF202020),
                  decoration: TextDecoration.none,
                ),
              ),
              const SizedBox(height: 1),
              // Instruction Text
              Padding(
                padding: EdgeInsets.symmetric(horizontal: width * 0.2), // Dynamic padding
                child: const Text(
                  "Enter 4-digits code we sent you on your phone number",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'Nunito Sans',
                    fontSize: 19,
                    fontWeight: FontWeight.w300,
                    height: 1.42,
                    color: Color(0xFF000000),
                    decoration: TextDecoration.none,
                  ),
                ),
              ),
              SizedBox(height: height * 0.02), // Dynamic spacing
              // Phone Number Text
              const Text(
                "+98*******00",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Nunito Sans',
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  height: 1.5625,
                  letterSpacing: 1.6,
                  color: Color(0xFF000000),
                  decoration: TextDecoration.none,
                ),
              ),
              SizedBox(height: height * 0.04), // Adjusted spacing
              // Dots for OTP
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(4, (index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5.0),
                    child: Container(
                      width: 17,
                      height: 17,
                      decoration: const BoxDecoration(
                        color: Color(0xFFD9E4FF),
                        shape: BoxShape.circle,
                      ),
                    ),
                  );
                }),
              ),
              const Spacer(),
              // "Send Again" Button
              Padding(
                padding: EdgeInsets.symmetric(horizontal: width * 0.1), // Dynamic padding
                child: ElevatedButton(
                  onPressed: () {
                    
                    _showDialog(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFFf5790),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    padding: EdgeInsets.symmetric(vertical: height * 0.01), // Dynamic padding
                  ),
                  child: const Center(
                    child: Text(
                      "Send Again",
                      style: TextStyle(
                        fontFamily: 'Nunito Sans',
                        fontSize: 22,
                        fontWeight: FontWeight.w300,
                        color: Color(0xFF202020),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: height * 0.03), // Adjusted spacing
              // "Cancel" Button
              TextButton(
                onPressed: () {
                     Navigator.pushNamed(context, '/createAccount');  // Replace with your Create Account page widget
                
                },
                child: const Text(
                  "Cancel",
                  style: TextStyle(
                    fontFamily: 'Nunito Sans',
                    fontWeight: FontWeight.w300,
                    fontSize: 16,
                    color: Color(0xE6202020),
                  ),
                ),
              ),
              SizedBox(height: height * 0.06), // Adjusted spacing

              
            ],
          ),
        ],
      ),
    );
  }

  void _showDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false, // Prevents closing the dialog by tapping outside
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: const Color(0xFFF8F8F8),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(19), // Rounded corners
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Exclamation Icon with new design properties
              Container(
                width: 22, // Width of the icon
                height: 22, // Height of the icon
                decoration: BoxDecoration(
                  color: const Color(0xFFF1AEAE), // Background color of the icon
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Colors.white, // White border around the icon
                    width: 2, // Border width
                  ),
                ),
                child: const Icon(
                  Icons.error,
                  color: Colors.red,
                  size: 12, // Icon size to fit within the container
                ),
              ),
              const SizedBox(width: 10),
              const Text(
                'Alert',
                style: TextStyle(fontSize: 20),
              ),
            ],
          ),
          content: const Text(
            "You reached out maximum amount of attempts. Please, try later.",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
               Navigator.of(context).pop(); // Close the dialog
              Navigator.pushNamed(context, '/flashsalelive'); // Navigate to the next page
    },
              child: const Text(
                "Okay",
                style: TextStyle(fontSize: 16, color: Colors.black),
              ),
            ),
          ],
        );
      },
    );
  }
}
