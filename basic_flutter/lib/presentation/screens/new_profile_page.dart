import 'dart:io';
import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../data/employee.dart';
import '../../themes.dart';
import '../widget/button_widget.dart';
import '../widget/profile_widget.dart';
import '../widget/textfield_widget.dart';
import '../../business_logic/cubits/dialog_cubit.dart';
import '../../business_logic/cubits/dialog_state.dart';

class NewProfilePage extends StatelessWidget {
  NewProfilePage({Key? key}) : super(key: key);

  Widget buildEditIcon(Color color, BuildContext context, Employee employee) =>
      buildCircle(
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

              employee = employee.copy(imagePath: newImage.path);
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
    Employee employee = const Employee(
      imagePath:
          'https://raw.githubusercontent.com/TugbaDalmaz/basic-flutter/d3d9b2ac55bf0a6b04a28d91f63f4af3cf59a8dc/basic_flutter/assets/image.png',
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
    return Scaffold(
      appBar: buildEditAppBar(context),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width * 0.1),
          child: BlocBuilder<DialogCubit, DialogState>(
            builder: (context, state) => Column(
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
                          imagePath:
                              'https://raw.githubusercontent.com/TugbaDalmaz/basic-flutter/d3d9b2ac55bf0a6b04a28d91f63f4af3cf59a8dc/basic_flutter/assets/image.png',
                          isEdit: true,
                          onClicked: () {},
                          sentWidget: Positioned(
                            bottom: 0,
                            right: 4,
                            child: buildEditIcon(
                                Colors.blue.shade900, context, employee),
                          ),
                        ),
                      ),
                      const SizedBox(height: 40),
                      TextFieldWidget(
                          label: 'First Name',
                          text: '',
                          onChanged: (firstName) =>
                              employee.copy(firstName: firstName)),
                      const SizedBox(height: 20),
                      TextFieldWidget(
                          label: 'Last Name',
                          text: '',
                          onChanged: (lastName) =>
                              employee.copy(lastName: lastName)),
                      const SizedBox(height: 20),
                      TextFieldWidget(
                        label: 'Profession',
                        text: '',
                        onChanged: (profession) =>
                            employee.copy(profession: profession),
                      ),
                      const SizedBox(height: 20),
                      TextFieldWidget(
                        label: 'Country',
                        text: '',
                        onChanged: (country) => employee.copy(country: country),
                      ),
                      const SizedBox(height: 20),
                      TextFieldWidget(
                        label: 'Phone number',
                        text: '',
                        onChanged: (phone) => employee.copy(phone: phone),
                      ),
                      const SizedBox(height: 20),
                      TextFieldWidget(
                        label: 'Email address',
                        text: '',
                        onChanged: (email) => employee.copy(email: email),
                      ),
                      const SizedBox(height: 20),
                      TextFieldWidget(
                        label: 'Location',
                        text: '',
                        onChanged: (location) =>
                            employee.copy(location: location),
                      ),
                      const SizedBox(height: 40),
                      ButtonWidget(
                          text: 'Save',
                          onClicked: () {
                            context
                                .read<DialogCubit>()
                                .changeEmployeeData(employee);
                          }),
                      const SizedBox(height: 150),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
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
