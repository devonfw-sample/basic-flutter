import 'dart:convert';

// Employee employeeFromJson(String str) => Employee.fromJson(json.decode(str));

// String employeeToJson(Employee data) => json.encode(data.toJson());

class Employee {
  Employee({
    required this.surname,
    required this.name,
    required this.id,
    required this.email,
  });

  String surname;
  String name;
  int id;
  String email;

  static Employee fromJson(Map<String, dynamic> json) => Employee(
        surname: json["surname"],
        name: json["name"],
        id: json["id"],
        email: json["email"],
      );
  Employee copy({
    int? id,
    String? name,
    String? surname,
    String? email,
  }) =>
      Employee(
          id: id ?? this.id,
          name: name ?? this.name,
          surname: surname ?? this.surname,
          email: email ?? this.email);

  Map<String, dynamic> toJson() => {
        "surname": surname,
        "name": name,
        "id": id,
        "email": email,
      };
}
