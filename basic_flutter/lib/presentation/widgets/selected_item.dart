import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/employee.dart';
import '../../business_logic/cubits/response_cubit.dart';
import '../../business_logic/cubits/response_state.dart';

class SelectedItem extends StatelessWidget {
  const SelectedItem({Key? key, required this.employee}) : super(key: key);

  final Employee employee;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onLongPress: () {
            BlocProvider.of<ResponseCubit>(context).toggleDeleteMode();
            employee.isSelected = !employee.isSelected;
          },
          onTap: () {
            employee.isSelected = !employee.isSelected;
            BlocProvider.of<ResponseCubit>(context)
                .addEmployeeToDelete(employee);
            BlocProvider.of<ResponseCubit>(context).declareStateChange();
          },
          child: ListTile(
            title: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('${employee.name} ${employee.surname}',
                  style: Theme.of(context).textTheme.headline6),
            ),
            tileColor:
                employee.isSelected ? Colors.grey.shade200 : Colors.white,
            subtitle: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                employee.email,
                style: const TextStyle(
                    fontFamily: 'Raleway-ExtraBold', fontSize: 16),
                softWrap: true,
              ),
            ),
            trailing: Column(
              children: [
                Text(
                  employee.employeeId,
                  style: Theme.of(context).textTheme.headline5,
                ),
                BlocConsumer<ResponseCubit, ResponseState>(
                  bloc: BlocProvider.of<ResponseCubit>(context),
                  listener: (context, state) {
                    if (!context.read<ResponseCubit>().deleteMode) {
                      state.employeeList.map((currentEmployee) =>
                          currentEmployee.isSelected = false);
                    }
                  },
                  builder: (context, state) {
                    return Icon(employee.isSelected
                        ? Icons.check_box_outlined
                        : Icons.check_box_outline_blank_outlined);
                  },
                )
              ],
            ),
          ),
        ),
        const Divider(height: 10)
      ],
    );
  }
}
