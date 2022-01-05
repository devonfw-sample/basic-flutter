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

  // THIS LIST COULD BE USED FOR TESTING PURPOSES
  // static const List<Employee> dummyList = [
  //   Employee(
  //       id: 1,
  //       firstName: "Smith",
  //       lastName: "John",
  //       email: "smith.john@kisama.com"),
  //   Employee(
  //       id: 2,
  //       firstName: "Joanna",
  //       lastName: "George",
  //       email: "Joanna.George@kisama.com"),
  //   Employee(
  //       id: 3,
  //       firstName: "Michael",
  //       lastName: "David",
  //       email: "michael.david@kisama.com"),
  //   Employee(
  //       id: 4,
  //       firstName: "Susan",
  //       lastName: "Clinton",
  //       email: "susan.clinton@kisama.com")
  // ];

}
