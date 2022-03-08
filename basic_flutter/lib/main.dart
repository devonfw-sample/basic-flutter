import 'package:flutter/material.dart';
import './screens/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const MyHomePage(
        title: 'Employee App',
      ),
      theme: ThemeData(
        primaryColor: Colors.blue.shade900,
        splashColor: Colors.blue,
        textTheme: ThemeData.light().textTheme.copyWith(
              headline6:
                  const TextStyle(fontFamily: "Raleway-Bold", fontSize: 20),
            ),
      ),
    );
  }
}
