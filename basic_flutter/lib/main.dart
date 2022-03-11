import 'package:basic_flutter/data/employee.dart';
import 'package:flutter/material.dart';
import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../presentation/screens/home.dart';
import '../business_logic/cubits/dialog_cubit.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  static const String title = 'Employee Profile';
  late List<Employee> employeeList = [];

  @override
  Widget build(BuildContext context) {
    return ThemeProvider(
      child: Builder(
        builder: (context) => BlocProvider(
          create: (BuildContext context) =>
              DialogCubit(Employee.employee, employeeList),
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
