import '/business_logic/cubits/dialog_cubit.dart';
import 'package:flutter/material.dart';
import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'presentation/screens/home.dart';
import './data/employee.dart';
import 'business_logic/cubits/dialog_state.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  static const String title = 'Employee Profile';
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Employee> employeeList = [];
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
              )),
    );
  }
}
