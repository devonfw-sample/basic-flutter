import 'package:shared_preferences/shared_preferences.dart';
import '../../data/employee.dart';

class NewEmployeePreferences {
  static late SharedPreferences _newPreferences;

  static const _newKeyEmployee = 'employee';
  static const newEmployee = Employee(
    imagePath:
        'https://raw.githubusercontent.com/TugbaDalmaz/basic-flutter/d3d9b2ac55bf0a6b04a28d91f63f4af3cf59a8dc/basic_flutter/assets/image.png',
    name: '',
    profession: '',
    country: '',
    email: '',
    phone: '',
    location: '',
    isDarkMode: false,
  );
}
