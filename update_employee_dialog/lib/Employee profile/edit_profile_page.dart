import 'dart:io';
import 'package:employee/Employee%20profile/employee.dart';
import 'package:employee/Employee%20profile/employee_preferences.dart';
import 'package:employee/Widgets/appbar_widget.dart';
import 'package:employee/Widgets/button_widget.dart';
import 'package:employee/Widgets/profile_widget.dart';
import 'package:employee/Widgets/textfield_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({Key? key}) : super(key: key);

  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  Employee employee = EmployeePreferences.myEmployee;

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
                        setState(() =>
                            employee = employee.copy(imagePath: newImage.path));
                      },
                    ),
                  ),
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
                  const SizedBox(height: 20),
                  ButtonWidget(
                    text: 'Save',
                    onClicked: () {
                      EmployeePreferences.setEmployee(employee);
                      Navigator.of(context).pop();
                    },
                  ),
                  const SizedBox(height: 150),
                ],
              )),
        ]),
      )));
}
