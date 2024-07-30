import 'package:flutter/material.dart';
import 'package:goride/DriverSignup.dart';
import 'package:goride/Login.dart';
import 'package:goride/PassengerSignup.dart';
import 'package:lottie/lottie.dart';

// Main Function
void main() {
  runApp(MyApp());
}

// MyApp Widget
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}

// SplashScreen Widget
class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Automatically navigate to HomePage after the animation duration
    Future.delayed(Duration(seconds: 3), () {
      _navigateToHome();
    });
  }

  void _navigateToHome() {
    if (mounted) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Lottie.asset(
          'assets/splash_screen.json', // Path to your splash screen animation
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

// HomePage Widget
class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFF1E3C72), // Dark Blue
              Color(0xFF2A5298), // Light Blue
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Lottie.asset(
                'assets/signup_login_animation.json', // Path to your animation
                width: 300,
                height: 300,
                fit: BoxFit.fill,
                repeat: true,
              ),
              SizedBox(height: 40),
              CustomHoverButton(
                text: 'Sign Up',
                onPressed: () {
                  _showSignUpBottomSheet(context);
                },
                buttonColor: Color(0xFFFFA726), // Orange button color
                hoverColor: Color(0xFFFFB74D), // Light Orange on hover
              ),
              SizedBox(height: 20),
              CustomHoverButton(
                text: "Login",
                onPressed: () {
                  _showLoginBottomSheet(context);
                },
                buttonColor: Color(0xFF29B6F6), // Sky Blue button color
                hoverColor: Color(0xFF4FC3F7), // Light Sky Blue on hover
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showSignUpBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return _buildBottomSheetContent(
          context,
          'Sign Up',
          [
            Colors.blueAccent,
            Colors.pinkAccent,
          ],
          [
            _buildSolidButton("Passenger", Colors.blue, context, "Sign Up"),
            SizedBox(height: 15), // Increased spacing between buttons
            _buildSolidButton("Driver", Colors.green, context, "Sign Up"),
          ],
        );
      },
    );
  }

  void _showLoginBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return _buildBottomSheetContent(
          context,
          'Login',
          [
            Colors.teal,
            Colors.lightBlueAccent,
          ],
          [
            _buildSolidButton("Passenger", Colors.orange, context, "Login"),
            SizedBox(height: 15), // Increased spacing between buttons
            _buildSolidButton("Driver", Colors.red, context, "Login"),
          ],
        );
      },
    );
  }

  Widget _buildBottomSheetContent(BuildContext context, String title,
      List<Color> gradientColors, List<Widget> buttons) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: gradientColors, // Gradient colors for the bottom sheet
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 20.0,
            offset: Offset(0, -10), // Changes position of shadow
          ),
        ],
      ),
      padding: EdgeInsets.all(20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            title,
            style: TextStyle(
                fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
          ),
          SizedBox(height: 20),
          ...buttons,
          SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildSolidButton(
      String text, Color color, BuildContext context, String userSelected) {
    return SizedBox(
      width: 200, // Increased width of the buttons
      child: ElevatedButton(
        onPressed: () {
          // Handle button action
          Navigator.pop(context); // Close bottom sheet
          if (userSelected == "Sign Up" && text == "Passenger") {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => PassengerSignup()));
          } else if (userSelected == "Sign Up" && text == "Driver") {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => DriverSignup()));
          } else if (userSelected == "Login") {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => Login(isUser: text)));
          }
        },
        style: ElevatedButton.styleFrom(
          primary: color, // Button color
          padding: EdgeInsets.symmetric(vertical: 15),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
        child: Text(
          text,
          style: TextStyle(
              fontSize: 20, color: Colors.white), // Increased font size
        ),
      ),
    );
  }
}

// CustomHoverButton Widget
class CustomHoverButton extends StatefulWidget {
  final String text;
  final VoidCallback onPressed;
  final Color buttonColor;
  final Color hoverColor;

  CustomHoverButton({
    required this.text,
    required this.onPressed,
    required this.buttonColor,
    required this.hoverColor,
  });

  @override
  _CustomHoverButtonState createState() => _CustomHoverButtonState();
}

class _CustomHoverButtonState extends State<CustomHoverButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => _onHover(true),
      onExit: (_) => _onHover(false),
      child: SizedBox(
        width: 250,
        child: ElevatedButton(
          onPressed: widget.onPressed,
          style: ElevatedButton.styleFrom(
            primary: _isHovered ? widget.hoverColor : widget.buttonColor,
            padding: EdgeInsets.symmetric(vertical: 20),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
          ),
          child: Text(
            widget.text,
            style: TextStyle(
                fontSize: 18, color: Colors.white), // Text color set to white
          ),
        ),
      ),
    );
  }

  void _onHover(bool isHovered) {
    setState(() {
      _isHovered = isHovered;
    });
  }
}
