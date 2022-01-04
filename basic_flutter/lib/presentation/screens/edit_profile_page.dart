import 'dart:io';
import 'package:path/path.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import '../../data/employee.dart';
import '../../presentation/screens/employee_preferences.dart';
import '../../presentation/widget/button_widget.dart';
import '../../presentation/widget/profile_widget.dart';
import '../../presentation/widget/textfield_widget.dart';
import '../../themes.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({Key? key}) : super(key: key);

  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  late Employee employee;

  @override
  void initState() {
    super.initState();
    employee = EmployeePreferences.getEmployee();
  }

  Widget buildEditIcon(Color color, BuildContext context) => buildCircle(
        color: Colors.white,
        all: 3,
        child: buildCircle(
          color: color,
          all: 10,
          child: GestureDetector(
            onTap: () async {
              final image =
                  await ImagePicker().getImage(source: ImageSource.gallery);

              if (image == null) return;

              final directory = await getApplicationDocumentsDirectory();
              final name = basename(image.path);
              final imageFile = File('${directory.path}/$name');
              final newImage = await File(image.path).copy(imageFile.path);

              setState(
                  () => employee = employee.copy(imagePath: newImage.path));
            },
            child: const Icon(
              Icons.add_a_photo,
              color: Colors.white,
              size: 20,
            ),
          ),
        ),
      );

  Widget buildCircle({
    required Widget child,
    required double all,
    required Color color,
  }) =>
      ClipOval(
        child: Container(
          padding: EdgeInsets.all(all),
          color: color,
          child: child,
        ),
      );

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: buildEditAppBar(context),
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width * 0.1),
            child: Column(
              children: [
                SizedBox(
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height,
                  child: ListView(
                    children: [
                      SizedBox(
                          width: double.infinity,
                          height: MediaQuery.of(context).size.height * 0.28,
                          child: ProfileWidget(
                            imagePath: employee.imagePath,
                            isEdit: true,
                            onClicked: () {},
                            sentWidget: Positioned(
                              bottom: 0,
                              right: 4,
                              child:
                                  buildEditIcon(Colors.blue.shade900, context),
                            ),
                          )),
                      const SizedBox(height: 40),
                      TextFieldWidget(
                        label: 'First Name',
                        text: employee.firstName,
                        onChanged: (firstName) =>
                            employee = employee.copy(firstName: firstName),
                      ),
                      const SizedBox(height: 40),
                      TextFieldWidget(
                        label: 'Last Name',
                        text: employee.lastName,
                        onChanged: (lastName) =>
                            employee = employee.copy(lastName: lastName),
                      ),
                      const SizedBox(height: 20),
                      TextFieldWidget(
                        label: 'Profession',
                        text: employee.profession,
                        onChanged: (profession) =>
                            employee = employee.copy(profession: profession),
                      ),
                      const SizedBox(height: 20),
                      TextFieldWidget(
                        label: 'Country',
                        text: employee.country,
                        onChanged: (country) =>
                            employee = employee.copy(country: country),
                      ),
                      const SizedBox(height: 20),
                      TextFieldWidget(
                        label: 'Phone number',
                        text: employee.phone,
                        onChanged: (phone) =>
                            employee = employee.copy(phone: phone),
                      ),
                      const SizedBox(height: 20),
                      TextFieldWidget(
                        label: 'Email address',
                        text: employee.email,
                        onChanged: (email) =>
                            employee = employee.copy(email: email),
                      ),
                      const SizedBox(height: 20),
                      TextFieldWidget(
                        label: 'Location',
                        text: employee.location,
                        onChanged: (location) =>
                            employee = employee.copy(location: location),
                      ),
                      const SizedBox(height: 40),
                      ButtonWidget(
                          text: 'Save',
                          onClicked: () {
                            EmployeePreferences.setEmployee(employee);
                            Navigator.of(context).pop();
                          }),
                      const SizedBox(height: 150),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );
}

AppBar buildEditAppBar(BuildContext context) {
  final isDarkMode = Theme.of(context).brightness == Brightness.dark;
  final icon = isDarkMode ? Icons.light_mode : Icons.dark_mode;

  return AppBar(
    backgroundColor: Colors.blue.shade900,
    title: const Text('Employee dialog'),
    centerTitle: true,
    leading: const BackButton(
      color: Colors.white,
    ),
    elevation: 0,
    actions: [
      ThemeSwitcher(
        builder: (context) => IconButton(
          icon: Icon(icon),
          onPressed: () {
            final theme = isDarkMode ? MyThemes.lightTheme : MyThemes.darkTheme;
            final switcher = ThemeSwitcher.of(context)!;
            switcher.changeTheme(theme: theme);
          },
        ),
      ),
    ],
  );
}
