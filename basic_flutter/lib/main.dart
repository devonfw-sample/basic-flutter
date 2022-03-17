import 'package:basic_flutter/presentation/screens/employees_list_screen.dart';
import 'business_logic/cubits/response_cubit.dart';
import 'business_logic/cubits/response_state.dart';
import 'package:flutter/material.dart';
import 'package:animated_theme_switcher/animated_theme_switcher.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import '../../presentation/screens/profile_page.dart';
import 'business_logic/cubits/employee_cubit.dart';
import 'business_logic/cubits/employee_state.dart';
import './data/employee.dart';
import './data/routes.dart';
import './presentation/screens/edit_profile_page.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  static const String title = 'Employee Profile';
  MyApp({Key? key}) : super(key: key);
  final List<Employee> employeeList = [];

  @override
  Widget build(BuildContext context) {
    Employee employeeInitializer = Employee(
      id: 1,
      name: '',
      surname: '',
      email: '',
      employeeId: '',
    );
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => EmployeeCubit(
              EmployeeState(employeeInitializer), employeeInitializer),
        ),
        BlocProvider(
          create: (context) => ResponseCubit(
            employeeList,
            false,
            false,
          ),
        ),
      ],
      child: BlocBuilder<ResponseCubit, ResponseState>(
        builder: (context, state) => ThemeProvider(
          child: Builder(
            builder: (context) => MaterialApp(
              debugShowCheckedModeBanner: false,
              title: title,
              routes: {
                Routes.mainRouteName: (context) => const Homepage(),
                Routes.employeeDialogRouteName: (context) =>
                    const ProfilePage(),
                Routes.editProfilePageRouteName: (context) => EditProfilePage(),
                Routes.employeeListScreenRouteName: (context) =>
                    const EmployeesListScreen()
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
                          color:
                              state.isDarkMode ? Colors.white : Colors.black),
                    ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class Homepage extends StatelessWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cubitInstance = context.read<ResponseCubit>();
    return BlocBuilder<ResponseCubit, ResponseState>(
      builder: (context, state) {
        return Scaffold(
            appBar: AppBar(
              title: const Text("text"),
              backgroundColor: Colors.blue.shade900,
            ),
            body: Center(
                child: TextButton(
              style:
                  TextButton.styleFrom(backgroundColor: Colors.blue.shade900),
              onPressed: () {
                cubitInstance.getNewStateData();
                Navigator.of(context)
                    .pushNamed(Routes.employeeListScreenRouteName);
              },
              child: const Text("get next employee",
                  style: TextStyle(color: Colors.white)),
            )));
      },
    );
  }
}
