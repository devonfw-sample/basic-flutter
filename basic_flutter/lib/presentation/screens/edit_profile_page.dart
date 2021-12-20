import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:path/path.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import '../../data/employee.dart';
import '../../presentation/screens/employee_preferences.dart';
import '../../presentation/widget/appbar_widget.dart';
import '../../presentation/widget/button_widget.dart';
import '../../presentation/widget/profile_widget.dart';
import '../../presentation/widget/textfield_widget.dart';

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

  // Widget buildEditableTextField(
  //     String label, String text, Function onChangedFunction, String functionString) {
  //   return TextFieldWidget(
  //     label: label,
  //     text: text,
  //     onChanged: () => onChangedFunction(functionString),
  //   );
  // ignore: todo
  // } TODO: refactor the code

  Widget buildEditIcon(Color color, BuildContext context) => buildCircle(
        color: Colors.white,
        all: 3,
        child: buildCircle(
          color: color,
          all: 10,
          child: GestureDetector(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const EditProfilePage()));
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
      appBar: buildAppBar(context),
      body: SingleChildScrollView(
          child: Container(
        padding: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width * 0.1),
        child: Column(children: [
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
                        onClicked: () async {
                          final image = await ImagePicker()
                              .getImage(source: ImageSource.gallery);

                          if (image == null) return;

                          final directory =
                              await getApplicationDocumentsDirectory();
                          final name = basename(image.path);
                          final imageFile = File('${directory.path}/$name');
                          final newImage =
                              await File(image.path).copy(imageFile.path);

                          setState(() => employee =
                              employee.copy(imagePath: newImage.path));
                        },
                        sentWidget: Positioned(
                          bottom: 0,
                          right: 4,
                          child: buildEditIcon(Colors.blue.shade900, context),
                        ),
                      )),
                  const SizedBox(height: 40),
                  TextFieldWidget(
                    label: 'First name and last name',
                    text: employee.name,
                    onChanged: (name) => employee = employee.copy(name: name),
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
              )),
        ]),
      )));
}
