class Employee {
  static const Employee employee = Employee(
    imagePath: 'assets/image.png',
    name: '',
    surename: '',
    employeeId: '',
    email: '',
  );

  final String imagePath;
  final String name;
  final String surename;
  final String employeeId;
  final String email;

  const Employee({
    required this.imagePath,
    required this.name,
    required this.surename,
    required this.employeeId,
    required this.email,
  });

  Employee copy({
    String? imagePath,
    String? name,
    String? surename,
    String? employeeId,
    String? email,
  }) =>
      Employee(
          imagePath: imagePath ?? this.imagePath,
          name: name ?? this.name,
          surename: surename ?? this.surename,
          employeeId: employeeId ?? this.employeeId,
          email: email ?? this.email);

  static Employee fromJson(Map<String, dynamic> json) => Employee(
        imagePath: json['imagePath'],
        name: json['Name'],
        surename: json['Surename'],
        employeeId: json['Employee ID'],
        email: json['Email address'],
      );

  Map<String, dynamic> toJson() => {
        'imagePath': imagePath,
        'Name': name,
        'Surename': surename,
        'Employee ID': employeeId,
        'Email address': email,
      };
}
