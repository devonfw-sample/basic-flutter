import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: "Employee App",
        home: const MyHomePage(),
        theme: ThemeData(
            primaryColor: Colors.blue.shade900,
            splashColor: Colors.blue,
            textTheme: ThemeData.light().textTheme.copyWith(
                headline6: const TextStyle(
                    fontFamily: "Raleway-Bold", fontSize: 20))));
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("Employee App")),
        body: const Center(
            child: Text("Hello World", style: TextStyle(fontSize: 30))));
  }
}
