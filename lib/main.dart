import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:flutter_shopping_77/screens/flashsale';
import 'package:flutter_shopping_77/screens/flashsalelive.dart';
import 'package:flutter_shopping_77/screens/createaccount.dart';
import 'package:flutter_shopping_77/screens/password.dart';
import 'package:flutter_shopping_77/screens/password_recovery.dart';
import 'package:flutter_shopping_77/screens/passwordupdate.dart';
import 'package:flutter_shopping_77/screens/storydotstap.dart';
import 'package:flutter_shopping_77/screens/storyproductstyle.dart';
import 'package:flutter_shopping_77/screens/wishlist.dart';
import 'package:flutter_shopping_77/screens/wrongpassword.dart';



late List<CameraDescription> _cameras;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  _cameras = await availableCameras();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Shoppe App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: {
        '/': (context) => const ShoppeHome(), // Home screen
        '/createAccount': (context) =>  CreateAccountScreen(cameras: _cameras), 
        '/passwordUpdate': (context) => const PassWordUpdate1(),
        '/wrongpassword': (context) => const Wrongpassword(),
        '/passwordrecovery': (context) => const PasswordRecoveryScreen(),
        '/flashsalelive': (context) => const FlashSalePage(),
        '/flashsale': (context) => FlashSale(),
        '/password': (context) => const PassWordUpdate(),
        '/storydotstap':(context) => const ResponsivePage(),
        '/storyproductstyle':(context) => const ShoppingPage(),
        '/wishlist':(context) => const WishlistApp(),
        
    
      }, 
    );
  }
}

class ShoppeHome extends StatefulWidget {
  const ShoppeHome({super.key});

  @override
  State<ShoppeHome> createState() => _ShoppeHomeState();
}

class _ShoppeHomeState extends State<ShoppeHome> {
  bool _isCircleHovered = false; // State variable for circle hover
  bool _isBagPressed = false; // State variable for bag press

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
       
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: screenHeight * 0.01),
              Padding(
                padding: EdgeInsets.all(screenWidth * 0.08), // Responsive padding
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: screenHeight * 0.15), // Adjust height dynamically
                    MouseRegion(
                      cursor: SystemMouseCursors.click,
                      onEnter: (_) => setState(() => _isCircleHovered = true),
                      onExit: (_) => setState(() => _isCircleHovered = false),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, '/createAccount');
                        },
                        child: Container(
                          width: screenWidth * 0.35,
                          height: screenWidth * 0.35,
                          padding: const EdgeInsets.all(16.0),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: _isCircleHovered ? Colors.blue : Colors.transparent,
                              width: 2,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                blurRadius: 8,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: Image.asset('assets/images/img.png'),
                        ),
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.03),
                    const Text(
                      'Shoppe',
                      style: TextStyle(
                        fontSize: 52,
                        fontWeight: FontWeight.w700,
                        fontFamily: 'Raleway',
                        height: 61.05 / 52,
                        letterSpacing: -0.52,
                        color: Colors.black,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: screenHeight * 0.03),
                    const Text(
                      'Beautiful eCommerce UI Kit\nfor your online store',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Color(0xFF202020),
                        fontFamily: 'Nunito Sans',
                        fontSize: 19,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.1),
                    SizedBox(
                      width: screenWidth * 0.8,
                      height: 61,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/createAccount');
                          
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color.fromRGBO(0, 76, 255, 1),
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                        child: const Text(
                          "Let's get started",
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w300,
                            fontFamily: 'Nunito Sans',
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.02),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'I already have an account',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(width: screenWidth * 0.02),
                        GestureDetector(
                          onTapDown: (_) {
                            setState(() => _isBagPressed = true);
                          },
                          onTapUp: (_) {
                            setState(() => _isBagPressed = false);
                          },
                          onTapCancel: () {
                            setState(() => _isBagPressed = false);
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: _isBagPressed ? Colors.blue : Colors.transparent,
                                width: 2,
                              ),
                              shape: BoxShape.circle,
                            ),
                            child: const CircleAvatar(
                              radius: 15,
                              backgroundColor: Color.fromRGBO(17, 54, 238, 1),
                              child: Icon(
                                Icons.arrow_forward,
                                color: Colors.white,
                                size: 16,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                
                  ],
                ),
              ),
             
              
             
            ],
          ),
        ),
      
    );
  }
}
