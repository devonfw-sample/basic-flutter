import 'package:flutter/material.dart';
import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import '../themes.dart';
import '../../presentation/screens/profile_page.dart';
import '../../presentation/screens/employee_preferences.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  EmployeePreferences.init();
  await EmployeePreferences.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  static const String title = 'Employee Profile';
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const employee = EmployeePreferences.myEmployee;

    return ThemeProvider(
        initTheme:
            employee.isDarkMode ? MyThemes.darkTheme : MyThemes.lightTheme,
        child: Builder(
            builder: (context) => MaterialApp(
                  debugShowCheckedModeBanner: false,
                  theme: ThemeProvider.of(context),
                  title: title,
                  home: const ProfilePage(
                      employee: EmployeePreferences.myEmployee),
                )));
  }
}
