import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'login.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: WelcomePage(),
    );
  }
}

class WelcomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF12283D),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                child: SvgPicture.asset(
                  'assets/images/smarthome.svg',
                  height: 250,
                  width: 217,
                ),
              ),
              SizedBox(height: 60),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                child: Text(
                  'Hello There',
                  style: TextStyle(
                    fontSize: 40,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.left,
                ),
              ),
              SizedBox(height: 10),
              // ... (other text widgets)
              SizedBox(height: 60),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                child: ElevatedButton.icon(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => LoginPage()),
                    );
                  },
                  icon: Icon(
                    FontAwesomeIcons.arrowRight,
                    color: Color(0xFF12283D),
                  ),
                  label: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Mulai',
                        style: TextStyle(
                          color: Color(0xFF12283D),
                        ),
                      ),
                      SizedBox(width: 8),
                      Icon(FontAwesomeIcons.arrowRight),
                    ],
                  ),
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    primary: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
