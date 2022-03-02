class Employee {
  static const Employee employee = Employee(
    imagePath: 'assets/image.png',
    id: '',
    firstName: '',
    lastName: '',
    profession: '',
    country: '',
    email: '',
    phone: '',
    location: '',
    isDarkMode: false,
  );

  final String imagePath;
  final String id;
  final String firstName;
  final String lastName;
  final String profession;
  final String country;
  final String email;
  final String phone;
  final String location;
  final bool isDarkMode;

  const Employee({
    required this.imagePath,
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.profession,
    required this.country,
    required this.email,
    required this.phone,
    required this.location,
    required this.isDarkMode,
  });

  Employee copy({
    String? imagePath,
    String? id,
    String? firstName,
    String? lastName,
    String? profession,
    String? country,
    String? email,
    String? phone,
    String? location,
    bool? isDarkMode,
  }) =>
      Employee(
          imagePath: imagePath ?? this.imagePath,
          id: id ?? this.id,
          firstName: firstName ?? this.firstName,
          lastName: lastName ?? this.lastName,
          profession: profession ?? this.profession,
          country: country ?? this.country,
          email: email ?? this.email,
          phone: phone ?? this.phone,
          location: location ?? this.location,
          isDarkMode: isDarkMode ?? this.isDarkMode);

  static Employee fromJson(Map<String, dynamic> json) => Employee(
        imagePath: json['imagePath'],
        id: json['ID'],
        firstName: json['First Name'],
        lastName: json['last Name'],
        profession: json['profession'],
        country: json['country'],
        email: json['email'],
        phone: json['phone'],
        location: json['location'],
        isDarkMode: json['isDarkMode'],
      );

  Map<String, dynamic> toJson() => {
        'imagePath': imagePath,
        'ID': id,
        'First Name': firstName,
        'Last Name': lastName,
        'profession': profession,
        'country': country,
        'email': email,
        'phone': phone,
        'location': location,
        'isDarkMode': isDarkMode,
      };
}
