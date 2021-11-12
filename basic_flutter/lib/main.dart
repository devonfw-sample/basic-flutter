import 'package:flutter/material.dart';

import 'presentation/screens/employees_list_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: "Employee App",
        home: EmployeesListScreen(),
        routes: {
          // EmployeesListScreen.routeName: (context) => EmployeesListScreen(),
          // MyHomePage.routeName: (context) => MyHomePage()
        },
        theme: ThemeData(
            primaryColor: Colors.blue.shade900,
            splashColor: Colors.blue,
            textTheme: ThemeData.light().textTheme.copyWith(
                headline6: const TextStyle(
                    fontFamily: "Raleway-Bold", fontSize: 24))));
  }
}

class MyHomePage extends StatefulWidget {
  // static const routeName = "/";
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Employee App"),
          backgroundColor: Theme.of(context).primaryColor,
        ),
        body: const Center(
            child: Text("Hello World", style: TextStyle(fontSize: 30))));
  }
}
