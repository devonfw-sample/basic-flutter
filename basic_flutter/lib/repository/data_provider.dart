import 'package:http/http.dart' as http;
import 'dart:convert';

class DataProvider {
  dynamic response;

  Future getEmployeesList(String endpoint) async {
    await http.post(Uri.parse(endpoint),
        body: [], headers: {"Content-Type": "application/json"}).then((resp) {
      response = resp;
      print(resp.body);
    });
    return response;
  }

  static void postEmployeeData(String url) async {
    await http.post(Uri.parse(url),
        body: jsonEncode(<String, dynamic>{
          'modificationCounter': 0,
          'id': 1,
          'employeeId': 1,
          'name': 'John',
          'surname': 'Smith',
          'email': 'john.smith@kisama.com'
        }));
  }

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
