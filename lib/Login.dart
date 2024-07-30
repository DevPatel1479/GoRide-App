import 'package:flutter/material.dart';

class Login extends StatelessWidget {
  final String isUser;
  Login({required this.isUser});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: this.isUser == "Passenger"
            ? Text("Passenger Login Panel... ")
            : Text("Driver Login Panel... "),
      ),
    );
  }
}
