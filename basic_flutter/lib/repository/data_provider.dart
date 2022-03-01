import 'package:http/http.dart' as http;
import 'dart:convert';
import '../data/employee.dart';

class DataProvider {
  List<dynamic> response = [];

  bool isDeleted = false;
  bool noData = false;

  Future<List<Employee>> getEmployeesList(String endpoint) async {
    final bodyMap = json.encode(
        {'employeeId': 'whatever'}); //nur um die Endpoint laufen zu kriegen
    List<Employee> employeeList = [];

    await http.post(Uri.parse(endpoint),
        body: bodyMap,
        headers: {"Content-Type": "application/json"}).then((resp) {
      if (resp.statusCode == 200) {
        final Map<String, dynamic> employeeListJson = json.decode(resp.body);
        response = employeeListJson['content'];
        if (response.isEmpty) {
          noData = true;
          return employeeList;
        }
        employeeList = response
            .map((currentEmployee) => Employee.fromJson(currentEmployee))
            .toList();
      } else {
        return Error();
      }
    });
    return employeeList;
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

  Future<void> updateEmployeeData(String deleteEndpoint, String insertEndpoint,
      Employee newEmployee) async {
    await http.delete(Uri.parse('$deleteEndpoint${newEmployee.id}'),
        headers: {"Content-Type": "application/json"}).then((resp1) async {
      if (resp1.statusCode == 200) {
        final insertBody = {
          {
            "surname": newEmployee.surname,
            "name": newEmployee.name,
            "email": newEmployee.email,
            "employeeId": newEmployee.employeeId,
            "id": newEmployee.id,
          }
        };
        await http.post(Uri.parse(insertEndpoint), body: insertBody);
      }
    });
  }

  Future<bool> deleteEmployee(String id, String endpoint, int index) async {
    await http.delete(Uri.parse('$endpoint"\$"$id')).then((resp) {
      if (resp.statusCode == 200) {
        response.removeWhere((employee) {
          return employee.id == response[index].id;
        });
        isDeleted = true;
      }
    });
    return isDeleted;
  }
}
