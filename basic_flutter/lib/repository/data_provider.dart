import 'package:http/http.dart' as http;
import 'dart:convert';
import '../data/employee.dart';

class DataProvider {
  late List<Employee> response;

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

  Future<void> deleteEmployee(String id, String endpoint) async {
    await http.delete(Uri.parse('$endpoint"\$"$id')).then((resp) {
      if (resp.statusCode == 200) {
        // TODO: handle the boolean whether the item has been deleted
      }
    });
  }
}
