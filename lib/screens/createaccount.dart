import 'dart:io';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:permission_handler/permission_handler.dart';

late List<CameraDescription> _cameras;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  _cameras = await availableCameras(); // Get available cameras
  runApp(const CreateAccountApp());
}

class CreateAccountApp extends StatelessWidget {
  const CreateAccountApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: CreateAccountScreen(cameras: _cameras),
      debugShowCheckedModeBanner: false,
    );
  }
}

class CreateAccountScreen extends StatefulWidget {
  final List<CameraDescription> cameras;

  const CreateAccountScreen({super.key, required this.cameras});

  @override
  _CreateAccountScreenState createState() => _CreateAccountScreenState();
}

class _CreateAccountScreenState extends State<CreateAccountScreen> {
  String selectedFlag = 'assets/images/img1.png'; // Default flag image path
  late CameraController _cameraController;
  bool _isCameraInitialized = false;
  bool _isPasswordVisible = false;
  String? profileImagePath; // Store the captured image path for profile picture

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _requestCameraPermission(); // Request camera permission on start
  }

  // Request camera permission
  Future<void> _requestCameraPermission() async {
    PermissionStatus status = await Permission.camera.request();

    if (status.isGranted) {
      // If permission is granted, initialize the camera
      _initializeCamera();
    } else if (status.isDenied) {
      // If permission is denied, show a message
      _showPermissionDialog("Camera permission denied", false);
    } else if (status.isPermanentlyDenied) {
      // If permission is permanently denied, show a dialog and open app settings
      _showPermissionDialog("Camera permission is permanently denied. Please enable it from settings.", true);
    }
  }

  // Show dialog for permission status
  void _showPermissionDialog(String message, bool openSettings) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Permission Required'),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                if (openSettings) {
                  openAppSettings(); // Open app settings if permission is permanently denied
                }
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _initializeCamera() async {
    try {
      // Find the front camera if available, otherwise fallback to rear camera
      CameraDescription? frontCamera;
      CameraDescription? rearCamera;

      for (var camera in widget.cameras) {
        if (camera.lensDirection == CameraLensDirection.front) {
          frontCamera = camera;
        } else if (camera.lensDirection == CameraLensDirection.back) {
          rearCamera = camera;
        }
      }

      // Use front camera if found, otherwise fall back to rear camera
      if (frontCamera != null) {
        _cameraController = CameraController(
          frontCamera,
          ResolutionPreset.medium,
        );
      } else if (rearCamera != null) {
        _cameraController = CameraController(
          rearCamera,
          ResolutionPreset.medium,
        );
      } else {
        throw CameraException('No camera available', 'Neither front nor back camera found.');
      }

      // Initialize the camera controller
      await _cameraController.initialize();

      setState(() {
        _isCameraInitialized = true;
      });
    } catch (e) {
      print('Error initializing camera: $e');
      setState(() {
        _isCameraInitialized = false;
      });
    }
  }

  // Open camera preview when camera icon is clicked
  void _openCameraPreview() async {
    if (_isCameraInitialized) {
      final result = await Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => CameraPreviewScreen(
            controller: _cameraController,
            onImageCaptured: (String imagePath) {
              setState(() {
                profileImagePath = imagePath; // Update the profile picture with the captured image
              });
            },
          ),
        ),
      );
    } else {
      print("Camera not initialized yet.");
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _phoneController.dispose();
    _cameraController.dispose();
    super.dispose();
  }

  bool _isFormValid() {
    return _emailController.text.isNotEmpty &&
        _passwordController.text.isNotEmpty &&
        _phoneController.text.isNotEmpty &&
        _isValidEmail(_emailController.text) &&
        _isValidPassword(_passwordController.text) &&
        _isValidPhoneNumber(_phoneController.text);
  }

  bool _isValidEmail(String email) {
    final emailRegex = RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$');
    return emailRegex.hasMatch(email);
  }

  bool _isValidPassword(String password) {
    final passwordRegex = RegExp(r'^(?=.*[a-z])(?=.*[A-Z]).{6,8}$'); // Password must have uppercase, lowercase, and be between 6 to 8 characters
    return passwordRegex.hasMatch(password);
  }

  bool _isValidPhoneNumber(String phoneNumber) {
    final phoneRegex = RegExp(r'^[0-9]{10}$'); // Phone number must have exactly 10 digits
    return phoneRegex.hasMatch(phoneNumber);
  }

  void _showSuccessDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Registration Successful'),
          content: const Text('You have successfully registered!'),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
                Navigator.pushNamed(context, '/password'); // Navigate to next page
              },
            ),
          ],
        );
      },
    );
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Error'),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Positioned(
            top: screenHeight * 0.1,
            left: screenWidth * 0.7,
            child: Transform(
              alignment: Alignment.center,
              transform: Matrix4.skewX(0.01)..rotateZ(0.785),
              child: Container(
                width: screenWidth * 0.7,
                height: screenHeight * 0.2,
                decoration: const BoxDecoration(
                  color: Color(0xFF004BFE),
                  shape: BoxShape.circle,
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.08),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: screenHeight * 0.13),
                  Text(
                    "Create\nAccount",
                    style: TextStyle(
                      fontFamily: 'Raleway',
                      fontSize: screenWidth * 0.1, // Scalable font size
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF202020),
                      letterSpacing: -0.5,
                      height: 1.08,
                      decoration: TextDecoration.underline,
                      decorationThickness: 1.5,
                    ),
                  ),
                  const SizedBox(height: 50),
                  // Camera Icon (Blue)
                  GestureDetector(
                    onTap: _openCameraPreview,
                    child: Container(
                      width: screenWidth * 0.22,
                      height: screenWidth * 0.22,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: profileImagePath != null
                            ? DecorationImage(
                                image: FileImage(File(profileImagePath!)),
                                fit: BoxFit.cover,
                              )
                            : const DecorationImage(
                                image: AssetImage('assets/images/img5.png'),
                                fit: BoxFit.cover,
                              ),
                      ),
                      child: profileImagePath == null
                          ? Center(
                              child: Icon(
                                Icons.camera_alt,
                                color: Colors.blue,
                                size: screenWidth * 0.08,
                              ),
                            )
                          : null,
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.04),
                  // Email TextField
                  TextField(
                    controller: _emailController,
                    decoration: const InputDecoration(
                      hintText: 'Email',
                      filled: true,
                      fillColor: Color(0xFFF8F8F8),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(60)),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.01),
                  // Password TextField
                  TextField(
                    controller: _passwordController,
                    obscureText: !_isPasswordVisible,
                    decoration: InputDecoration(
                      hintText: 'Password',
                      filled: true,
                      fillColor: const Color(0xFFF8F8F8),
                      border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(60)),
                        borderSide: BorderSide.none,
                      ),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                          color: Colors.grey,
                        ),
                        onPressed: () {
                          setState(() {
                            _isPasswordVisible = !_isPasswordVisible;
                          });
                        },
                      ),
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.01),
                  // Phone Number TextField
                  Row(
                    children: [
                      DropdownButton<String>(
                        value: selectedFlag,
                        onChanged: (String? newFlag) {
                          setState(() {
                            selectedFlag = newFlag!;
                          });
                        },
                        items: [
                          'assets/images/img1.png',
                          'assets/images/img2.png',
                          'assets/images/img3.png',
                          'assets/images/img4.png',
                        ].map<DropdownMenuItem<String>>((String flag) {
                          return DropdownMenuItem<String>(
                            value: flag,
                            child: Image.asset(flag, width: screenWidth * 0.06, height: screenWidth * 0.06),
                          );
                        }).toList(),
                      ),
                      Expanded(
                        child: TextField(
                          controller: _phoneController,
                          decoration: const InputDecoration(
                            hintText: 'Your number',
                            filled: true,
                            fillColor: Color(0xFFF8F8F8),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(60)),
                              borderSide: BorderSide.none,
                            ),
                          ),
                          keyboardType: TextInputType.phone,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 60),
                  // Done Button (Blue)
                  ElevatedButton(
                    onPressed: () {
                      if (_isFormValid()) {
                        _showSuccessDialog();
                      } else {
                        _showErrorDialog("Please fill in all the details correctly.");
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      backgroundColor: const Color(0xFF004BFE), // Blue button color
                      minimumSize: Size(screenWidth, screenHeight * 0.08),
                    ),
                    child: const Text(
                      "Done",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w300,
                        color: Color(0xFFF3F3F3), // Correct way to set text color
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  // Cancel Button (Red)
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context); // Cancel the registration and go back
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent, // Set the background color to transparent
                      shadowColor: Colors.transparent, // Remove shadow if any
                      padding: EdgeInsets.zero, // Remove padding if any
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30), // Optional: Custom button shape
                      ),
                    ),
                    child: Center(
                      child: Text(
                        'Cancel',
                        style: TextStyle(
                          fontSize: screenWidth * 0.04,
                          fontWeight: FontWeight.w300,
                          color: const Color(0xFF202020), // Text color
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CameraPreviewScreen extends StatelessWidget {
  final CameraController controller;
  final Function(String) onImageCaptured;

  const CameraPreviewScreen({Key? key, required this.controller, required this.onImageCaptured}) : super(key: key);
@override
Widget build(BuildContext context) {
  return Scaffold(
    appBar:  AppBar(title: Text('Camera Preview')),
    body: Stack(
      children: [
        CameraPreview(controller), // Camera preview in the background
        Align(
          alignment: Alignment.bottomCenter, // Align the button at the bottom center
          child: Padding(
            padding: const EdgeInsets.all(16.0), // Adds padding around the button
            child: FloatingActionButton(
              onPressed: () async {
                try {
                  final image = await controller.takePicture();
                  onImageCaptured(image.path);
                  Navigator.pop(context);
                } catch (e) {
                  print('Error capturing image: $e');
                }
              },
              child: const Icon(Icons.camera),
            ),
          ),
        ),
      ],
    ),
  );
}
}
