import 'package:flutter/material.dart';

import '/presentation/screens/employees_list_screen.dart';
import './data/routes.dart';
import '/presentation/screens/employee_dialog.dart';

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
        routes: {
          Routes.employeeListScreenRouteName: (context) =>
              const EmployeesListScreen(),
          Routes.employeeDialogRouteName: (context) => const EmployeeDialog(),
        },
        theme: ThemeData(
            primaryColor: Colors.blue.shade900,
            splashColor: Colors.blue,
            textTheme: ThemeData.light().textTheme.copyWith(
                headline6: const TextStyle(
                    fontFamily: 'Raleway-Bold',
                    fontSize: 20,
                    color: Colors.black))));
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
      appBar: AppBar(
        title: const Text('Employee App'),
        backgroundColor: Theme.of(context).primaryColor,
        centerTitle: true,
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.pushNamed(context, Routes.employeeListScreenRouteName);
          },
          child: const Text('Get Employees List'),
          style: ButtonStyle(
            backgroundColor:
                MaterialStateProperty.all(Theme.of(context).primaryColor),
          ),
        ),
      ),
    );
  }
}
