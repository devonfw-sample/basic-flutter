import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'data/employee.dart';
import '/repository/data_provider.dart';
import '/business_logic/cubits/response_cubit.dart';
import 'business_logic/cubits/response_state.dart';
import '/presentation/screens/employees_list_screen.dart';
import './data/routes.dart';
import '/presentation/screens/employee_dialog.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);
  final DataProvider dataProvider = DataProvider();
  final List<Employee> employeeList = [];
  final bool isDarkModeDefault = false;
  final bool isGridViewDefault = false;
  @override
  Widget build(BuildContext context) {
    // final Brightness brightnessValue =
    //     MediaQuery.of(context).platformBrightness;

    return BlocProvider(
      create: (context) => ResponseCubit(
          dataProvider, employeeList, isDarkModeDefault, isGridViewDefault),
      child: BlocBuilder<ResponseCubit, ResponseState>(
        builder: (context, state) => MaterialApp(
          debugShowCheckedModeBanner: false,
          title: "Employee App",
          home: const MyHomePage(),
          routes: {
            Routes.employeeListScreenRouteName: (context) =>
                const EmployeesListScreen(),
            Routes.employeeDialogRouteName: (context) => const EmployeeDialog(),
          },
          darkTheme: ThemeData.dark(),
          theme: ThemeData(
            primaryColor: Colors.blue.shade900,
            splashColor: Colors.blue,
            cardColor: Colors.white,
            canvasColor: state.isDarkMode ? Colors.black87 : Colors.white,
            textTheme: ThemeData.light().textTheme.copyWith(
                  headline6: TextStyle(
                      fontFamily: 'Raleway-Bold',
                      fontSize: 20,
                      color: state.isDarkMode ? Colors.white : Colors.black),
                ),
          ),
        ),
      ),
    );
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
      backgroundColor: Theme.of(context).canvasColor,
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
