import 'package:http/http.dart' as http;
import 'dart:convert';
import '../data/employee.dart';

class DataProvider {
  List<dynamic> response = [];
  bool isDeleted = false;
  bool noData = false;

  Future<List<Employee>> getEmployeesList(String endpoint) async {
    final bodyMap = json.encode(
        {'employeeId': 'whatever'}); //nur um die Endpoint weiterzulaufen
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
    await http
        .delete(Uri.parse('$deleteEndpoint${newEmployee.id}'))
        .then((resp1) async {
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
        await http
            .post(Uri.parse(insertEndpoint), body: insertBody)
            .then((resp2) {
          if (resp2.statusCode == 200)
            print("SHA8AAAAAL");
          else
            print('MESH SHA8AAAAAAAL' + resp2.statusCode.toString());
        });
      }
    });
  }

  Future<void> deleteEmployee(String id, String endpoint) async {
    await http.delete(Uri.parse('$endpoint"\$"$id')).then((resp) {
      if (resp.statusCode == 200) {
        isDeleted = true;
      }
    });
  }
}
