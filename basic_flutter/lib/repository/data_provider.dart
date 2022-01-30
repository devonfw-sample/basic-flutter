import 'package:http/http.dart' as http;
import 'dart:convert';
import '../data/employee.dart';

class DataProvider {
  late List<Employee> response;
  bool isDeleted = false;

  Future<List<Employee>> getEmployeesList(String endpoint) async {
    await http.post(
      Uri.parse(endpoint),
      body: [],
    ).then((resp) {
      if (resp.statusCode == 200) {
        final employeeListJson = json.decode(resp.body);
        for (dynamic currentEmployee in employeeListJson) {
          response.add(Employee.fromJson(currentEmployee));
        }
      }
    });
    return response;
  }

  Future<Employee> getEmployeeWithId(String endpoint, String id) async {
    Map<String, dynamic> currentRetrievedEmployee = {};
    late Employee newEmployee;
    await http
        .get(Uri.parse(endpoint + '/employeemanagement/v1/employee/$id'))
        .then((resp) {
      if (resp.statusCode == 200) {
        currentRetrievedEmployee = json.decode(resp.body);
        newEmployee = Employee.fromJson(currentRetrievedEmployee);
      }
    });
    return newEmployee;
  }

  Future<void> deleteEmployee(String id, String endpoint) async {
    await http.delete(Uri.parse('$endpoint"\$"$id')).then((resp) {
      if (resp.statusCode == 200) {
        isDeleted = true;
      }
    });
  }
}
