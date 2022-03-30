class Employee {
  Employee({
    required this.surname,
    required this.name,
    required this.id,
    required this.email,
    required this.employeeId,
  });

  String surname;
  String name;
  int id;
  String email;
  String employeeId;
  bool isSelected = false;

  static Employee fromJson(Map<String, dynamic> json) => Employee(
        surname: json["surname"],
        name: json["name"],
        id: json["id"],
        email: json["email"],
        employeeId: json["employeeId"],
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
        email: email ?? this.email,
        employeeId: employeeId,
      );

  Map<String, dynamic> toJson() => {
        "surname": surname,
        "name": name,
        "id": id,
        "email": email,
        "employeeId": employeeId,
      };
}
