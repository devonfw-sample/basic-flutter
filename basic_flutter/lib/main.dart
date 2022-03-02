import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import '../data/employee.dart';
import '../presentation/screens/home.dart';
import '../business_logic/cubits/dialog_state.dart';
import '../business_logic/cubits/dialog_cubit.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  static const String title = 'Employee Profile';
  MyApp({Key? key}) : super(key: key);
  List<Employee> employeeList = [];

  @override
  Widget build(BuildContext context) {
    return ThemeProvider(
      child: Builder(
        builder: (context) => BlocProvider(
          create: (BuildContext context) => DialogCubit(
              DialogState(Employee.employee, employeeList),
              Employee.employee,
              employeeList),
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeProvider.of(context),
            title: title,
            home: const Home(),
          ),
        ),
      ),
    );
  }
}
