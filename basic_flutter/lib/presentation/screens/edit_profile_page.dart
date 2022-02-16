import 'package:basic_flutter/presentation/widgets/email_textfield.dart';

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
import '../widgets/name_textfield.dart';

class EditProfilePage extends StatelessWidget {
  EditProfilePage({Key? key}) : super(key: key);
  final TextEditingController emailController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController idController = TextEditingController();

  void _submitEmailData(BuildContext context, String enteredText) {
    bool emailValid = RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(enteredText);
    if (!emailValid) {
      ScaffoldMessenger.of(context).showSnackBar(_snackBarContent('email'));
    }
  }

  void _submitData(BuildContext context, String enteredText, String label,
      Employee employeeUnderEdit) {
    final String detectedLabel = detectLabel(label);
    if (detectedLabel == 'First Name') {
      if (checkName(enteredText)) employeeUnderEdit.name = enteredText;
    } else if (detectedLabel == 'Last Name') {
      if (checkName(enteredText)) employeeUnderEdit.surname = enteredText;
    } else if (detectedLabel == 'ID ') {
      if (checkId(enteredText)) employeeUnderEdit.employeeId = enteredText;
    }
  }

  bool checkName(String name) {
    return double.parse(name) == null;
  }

  bool checkId(String employeeId) {
    final double parsedNumber = double.parse(employeeId);
    if (parsedNumber == null) {
      return false;
    } else {
      return true;
    }
  }

  Function executeLabelFunction(
      String detectedLabel, Employee employeeUnderEdit, String enteredText) {
    switch (detectedLabel) {
      case 'name':
        return () => employeeUnderEdit.name = enteredText;
      case 'surname':
        return () => employeeUnderEdit.surname = enteredText;
      case 'employeeId':
        return () => employeeUnderEdit.employeeId = enteredText;
      default:
        return () {};
    }
  }

  SnackBar _snackBarContent(String text) {
    return SnackBar(content: Text("Please enter a valid $text"));
  }

  @override
  Widget build(BuildContext context) {
    final cubitInstance = context.read<EmployeeCubit>();
    Employee receivedEmployeeInstance =
        ModalRoute.of(context)!.settings.arguments as Employee;
    Employee emptyEmployee = Employee(
        surname: 'surname',
        name: 'name',
        id: 1,
        email: 'email',
        employeeId: '');

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
                  child: SingleChildScrollView(
                    child: SizedBox(
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
                          const SizedBox(height: 10),
                          NameTextField(
                            label: 'ID',
                            controller: idController,
                            employeeUnderEdit: receivedEmployeeInstance,
                            submitData: _submitData,
                          ),
                          const SizedBox(height: 20),
                          NameTextField(
                            label: 'First Name',
                            controller: nameController,
                            submitData: _submitData,
                            employeeUnderEdit: receivedEmployeeInstance,
                          ),
                          const SizedBox(height: 20),
                          NameTextField(
                            label: 'Last Name',
                            controller: lastNameController,
                            submitData: _submitData,
                            employeeUnderEdit: receivedEmployeeInstance,
                          ),
                          const SizedBox(height: 20),
                          emailTextField(context),
                          const SizedBox(height: 40),
                          ButtonWidget(
                              text: 'Save',
                              onClicked: () {
                                cubitInstance.updateEmployeeData(
                                    emptyEmployee,
                                    receivedEmployeeInstance,
                                    responseState.employeeList);
                                Navigator.of(context).pop();
                              }),
                          const SizedBox(height: 150),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  Column emailTextField(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Email',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        const SizedBox(height: 8),
        TextField(
          onSubmitted: (enteredText) => _submitEmailData(context, enteredText),
          controller: emailController,
          decoration: InputDecoration(
            hintText: 'Email',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
      ],
    );
  }

  Column nameTextField(
      BuildContext context, String label, Employee employeeUnderEdit) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        const SizedBox(height: 8),
        TextField(
          onSubmitted: (enteredText) =>
              _submitData(context, enteredText, label, employeeUnderEdit),
          controller: nameController,
          decoration: InputDecoration(
            hintText: '',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
      ],
    );
  }

  String detectLabel(String label) {
    switch (label) {
      case 'name':
        return 'name';
      case 'surname':
        return 'surname';
      case 'employeeId':
        return 'employeeId';
      default:
        return 'nothing';
    }
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
