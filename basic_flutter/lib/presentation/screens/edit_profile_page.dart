import '/business_logic/cubits/employee_cubit.dart';
import '/business_logic/cubits/employee_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:animated_theme_switcher/animated_theme_switcher.dart';

import '../../presentation/widgets/button_widget.dart';
import '../../themes.dart';
import '../../data/employee.dart';
import '../../business_logic/cubits/response_cubit.dart';
import '../../business_logic/cubits/response_state.dart';
import '../widgets/name_textfield.dart';
import '../widgets/edit_app_bar.dart';
import '../widgets/email_text_field.dart';

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
    if (detectedLabel == 'name') {
      if (checkName(enteredText)) employeeUnderEdit.name = enteredText;
    } else if (detectedLabel == 'surname') {
      if (checkName(enteredText)) employeeUnderEdit.surname = enteredText;
    } else if (detectedLabel == 'employeId') {
      if (isNumeric(enteredText)) employeeUnderEdit.employeeId = enteredText;
    }
  }

  bool checkName(String name) {
    return double.tryParse(name) == null;
  }

  bool isNumeric(String s) {
    if (s == null) {
      return false;
    }
    return double.tryParse(s) != null;
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

  Employee emptyEmployee = Employee(
      surname: 'surname', name: 'name', id: 1, email: 'email', employeeId: '');

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
              appBar: const PreferredSize(
                child: EditAppBar(),
                preferredSize: Size.fromHeight(50.0),
              ),
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
                          const SizedBox(height: 10),
                          NameTextField(
                            label: 'employeeId',
                            controller: idController,
                            employeeUnderEdit: receivedEmployeeInstance,
                            submitData: _submitData,
                          ),
                          const SizedBox(height: 20),
                          NameTextField(
                            label: 'name',
                            controller: nameController,
                            submitData: _submitData,
                            employeeUnderEdit: receivedEmployeeInstance,
                          ),
                          const SizedBox(height: 20),
                          NameTextField(
                            label: 'surname',
                            controller: lastNameController,
                            submitData: _submitData,
                            employeeUnderEdit: receivedEmployeeInstance,
                          ),
                          const SizedBox(height: 20),
                          EmailTextField(
                              controller: emailController,
                              submitEmailData: _submitEmailData),
                          const SizedBox(height: 40),
                          ButtonWidget(
                              text: 'Save',
                              onClicked: () {
                                cubitInstance.updateEmployeeData(
                                    emptyEmployee,
                                    receivedEmployeeInstance,
                                    responseState.employeeList);
                                context.read<ResponseCubit>().getNewStateData();
                                Navigator.of(context).pop();
                              }),
                          SizedBox(
                              height: MediaQuery.of(context).size.height * 0.3),
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
