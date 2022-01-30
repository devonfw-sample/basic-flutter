import 'package:http/http.dart' as http;
import 'dart:convert';
import '../data/employee.dart';

class DataProvider {

  List<Employee> response = [];

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

  Future<bool> deleteEmployee(String id, String endpoint, int index) async {
    await http.delete(Uri.parse(endpoint + id)).then((resp) {
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
