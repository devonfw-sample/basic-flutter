import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../widget/build_circle.dart';
import '../widget/button_widget.dart';
import '../widget/profile_widget.dart';
import '../widget/textfield_widget.dart';
import '../widget/build_edit_appbar.dart';
import '../../business_logic/cubits/dialog_cubit.dart';
import '../../business_logic/cubits/dialog_state.dart';
import '../../../../data/employee.dart';

class NewProfilePage extends StatelessWidget {
  NewProfilePage({Key? key}) : super(key: key);
  Employee employee = const Employee(
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

  Widget buildEditIcon(Color color, BuildContext context, Employee employee) =>
      BuildCircle();

  @override
  Widget build(BuildContext context) {
    const List<String> labels = [
      'First Name',
      'Last Name',
      'Profession',
      'Country',
      'Email address',
      'Phone number',
      'Location'
    ];
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50.0),
        child: BuildEditAppbar().build(context),
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
                          sentWidget: Positioned(
                            bottom: 0,
                            right: 4,
                            child: buildEditIcon(
                                Colors.blue.shade900, context, employee),
                          ),
                        ),
                      ),
                      const SizedBox(height: 40),
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
                              const SizedBox(height: 20)
                            ],
                          );
                        },
                      ).toList(),
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

  void getLabelFunction(
      String label, Employee employeeUnderEdit, String editingText) {
    switch (label) {
      case 'First Name':
        () => employeeUnderEdit.copy(firstName: editingText);
        break;
      case 'Last Name':
        () => employeeUnderEdit.copy(lastName: editingText);
        break;
      case 'Country':
        () => employeeUnderEdit.copy(country: editingText);
        break;
      case 'Profession':
        () => employeeUnderEdit.copy(profession: editingText);
        break;
      case 'Phone number':
        () => employeeUnderEdit.copy(phone: editingText);
        break;
      case 'Email address':
        () => employeeUnderEdit.copy(email: editingText);
        break;
      case 'Location':
        () => employeeUnderEdit.copy(location: editingText);
        break;
    }
  }
}
