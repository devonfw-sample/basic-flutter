import 'dart:convert';

import 'package:employee/data/employee.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EmployeePreferences {
  static late SharedPreferences _preferences;
  static const _keyEmployee = 'employee';

  static const myEmployee = Employee(
    imagePath:
        'https://raw.githubusercontent.com/devonfw-sample/basic-flutter/d988700d786af494b2b2ef4877cb6a06fc545dda/employee_dialog/assets/employee1.jpg',
    name: 'Max Mustermann',
    profession: 'Senior Delivery Architect CSS',
    country: 'Germany',
    email: 'max.mustermann@muster.com',
    phone: '+490123456789',
    location: 'DE-HH-K',
    isDarkMode: false,
  );

  static Future init() async =>
      _preferences = await SharedPreferences.getInstance();

  static Future setEmployee(Employee employee) async {
    final json = jsonEncode(employee.toJson());
    await _preferences.setString(_keyEmployee, json);
  }

  static Employee getEmployee() {
    final json = _preferences.getString(_keyEmployee);
    return json == null ? myEmployee : Employee.fromJson(jsonDecode(json));
  }
}
