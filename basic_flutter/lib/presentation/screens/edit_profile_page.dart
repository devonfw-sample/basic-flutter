import '/business_logic/cubits/employee_cubit.dart';
import '/business_logic/cubits/employee_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:animated_theme_switcher/animated_theme_switcher.dart';

import '../../presentation/widgets/button_widget.dart';
import '../../presentation/widgets/textfield_widget.dart';
import '../../themes.dart';
import '../../data/employee.dart';
import '../../business_logic/cubits/response_cubit.dart';
import '../../business_logic/cubits/response_state.dart';

class EditProfilePage extends StatelessWidget {
  const EditProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cubitInstance = context.read<EmployeeCubit>();
    Employee receivedEmployeeInstance =
        ModalRoute.of(context)!.settings.arguments as Employee;
    return BlocBuilder<ResponseCubit, ResponseState>(
      builder: (context, responseState) {
        return BlocBuilder<EmployeeCubit, EmployeeState>(
          builder: (context, state) {
            return Scaffold(
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
                            // SizedBox(
                            //     width: double.infinity,
                            //     height: MediaQuery.of(context).size.height * 0.28,
                            //     child: ProfileWidget(
                            //       imagePath: state.employee.imagePath,
                            //       isEdit: true,
                            //       onClicked: () {},
                            //       sentWidget: Positioned(
                            //         bottom: 0,
                            //         right: 4,
                            //         child: EditIcon(color: Colors.blue.shade900),
                            //       ),
                            //     )),
                            const SizedBox(height: 40),
                            TextFieldWidget(
                              label: 'First Name',
                              text: receivedEmployeeInstance.name,
                              onChanged: (name) => state.employee =
                                  state.employee.copy(name: name),
                            ),
                            const SizedBox(height: 20),
                            TextFieldWidget(
                              label: 'Last Name',
                              text: receivedEmployeeInstance.surname,
                              onChanged: (surname) => receivedEmployeeInstance =
                                  receivedEmployeeInstance.copy(
                                      surname: surname),
                            ),
                            const SizedBox(height: 40),

                            const SizedBox(height: 20),
                            TextFieldWidget(
                              label: 'Email address',
                              text: receivedEmployeeInstance.email,
                              onChanged: (email) => receivedEmployeeInstance =
                                  receivedEmployeeInstance.copy(email: email),
                            ),
                            const SizedBox(height: 40),
                            ButtonWidget(
                                text: 'Save',
                                onClicked: () {
                                  cubitInstance.updateEmployeeData(
                                      receivedEmployeeInstance,
                                      responseState.employeeList);
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
          },
        );
      },
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
