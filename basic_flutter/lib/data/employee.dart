class Employee {
  late String firstName;
  late String lastName;
  late int id;
  late String email;

  Employee(
      {required this.firstName,
      required this.email,
      required this.id,
      required this.lastName});

  Employee.fromJson(Map<String, dynamic> json) {
    firstName = json['name'];
    lastName = json['surname'];
    id = json['employeeId'];
    email = json['email'];
  }
}
