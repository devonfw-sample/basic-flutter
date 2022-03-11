import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../widgets/button_widget.dart';
import '../widgets/profile_widget.dart';
import '../widgets/textfield_widget.dart';
import '../widgets/build_edit_appbar.dart';
import '../../business_logic/cubits/dialog_cubit.dart';
import '../../business_logic/cubits/dialog_state.dart';
import '../../../../data/employee.dart';

class NewProfilePage {
  Employee employee = const Employee(
    imagePath: 'assets/image.png',
    name: '',
    surename: '',
    employeeId: '',
    email: '',
  );

  Widget build(BuildContext context) {
    const List<String> labels = [
      'Name',
      'Surename',
      'Employee ID',
      'Email address',
    ];
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50.0),
        child: const BuildEditAppbar().build(context),
      ),
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
                          imagePath: 'assets/image.png',
                          isEdit: true,
                          onClicked: () {},
                        ),
                      ),
                      SizedBox(
                          width: double.infinity,
                          height: MediaQuery.of(context).size.height * 0.10),
                      ...labels.map(
                        (label) {
                          return Column(
                            children: [
                              TextFieldWidget(
                                label: label,
                                text: '',
                                onChanged: (editingText) => getLabelFunction(
                                    label, employee, editingText),
                              ),
                              SizedBox(
                                  width: double.infinity,
                                  height: MediaQuery.of(context).size.height *
                                      0.05),
                            ],
                          );
                        },
                      ).toList(),
                      SizedBox(
                          width: double.infinity,
                          height: MediaQuery.of(context).size.height * 0.02),
                      ButtonWidget(
                          text: 'Save',
                          onClicked: () {
                            context
                                .read<DialogCubit>()
                                .changeEmployeeData(employee);
                          }),
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

  void getLabelFunction(
      String label, Employee employeeUnderEdit, String editingText) {
    switch (label) {
      case 'Name':
        () => employeeUnderEdit.copy(name: editingText);
        break;
      case 'Surename':
        () => employeeUnderEdit.copy(surename: editingText);
        break;
      case 'Employee Id':
        () => employeeUnderEdit.copy(employeeId: editingText);
        break;
      case 'Email address':
        () => employeeUnderEdit.copy(email: editingText);
        break;
    }
  }
}
