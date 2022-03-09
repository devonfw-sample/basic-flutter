import 'dart:io';
import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import '../../../../data/employee.dart';
import '../../themes.dart';
import '../widgets/button_widget.dart';
import '../widgets/profile_widget.dart';
import '../widgets/textfield_widget.dart';

class NewProfilePage extends StatefulWidget {
  const NewProfilePage({Key? key}) : super(key: key);

  @override
  _NewProfilePage createState() => _NewProfilePage();
}

class _NewProfilePage extends State<NewProfilePage> {
  late Employee employee;

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
  Widget build(BuildContext context) {
    final Employee dummyEmployee = Employee(
      email: '',
      employeeId: '',
      id: 0,
      name: '',
      surname: '',
    );
    return Scaffold(
        appBar: buildEditAppBar(context),
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
                          isEdit: true,
                          onClicked: () {},
                          sentWidget: Positioned(
                            bottom: 0,
                            right: 4,
                            child: buildEditIcon(Colors.blue.shade900, context),
                          ),
                        )),
                    const SizedBox(height: 40),
                    TextFieldWidget(
                        label: 'Name',
                        text: '',
                        employeeUnderEdit: dummyEmployee),
                    const SizedBox(height: 40),
                    TextFieldWidget(
                        label: 'Surname',
                        text: '',
                        employeeUnderEdit: dummyEmployee),
                    // const SizedBox(height: 20),
                    // TextFieldWidget(
                    //     label: 'Profession',
                    //     text: '',
                    //     employeeUnderEdit: dummyEmployee),
                    // const SizedBox(height: 20),
                    // TextFieldWidget(
                    //     label: 'Country',
                    //     text: '',
                    //     employeeUnderEdit: dummyEmployee),
                    // const SizedBox(height: 20),
                    // TextFieldWidget(
                    //     label: 'Phone number',
                    //     text: '',
                    //     employeeUnderEdit: dummyEmployee),
                    const SizedBox(height: 20),
                    TextFieldWidget(
                        label: 'Email address',
                        text: '',
                        employeeUnderEdit: dummyEmployee),
                    const SizedBox(height: 20),
                    // TextFieldWidget(
                    //     label: 'Location',
                    //     text: '',
                    //     employeeUnderEdit: dummyEmployee),
                    const SizedBox(height: 40),
                    ButtonWidget(text: 'Save', onClicked: () {}),
                    const SizedBox(height: 150),
                  ],
                )),
          ]),
        )));
  }
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
