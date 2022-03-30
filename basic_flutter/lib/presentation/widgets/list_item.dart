import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/employee.dart';
import '../../data/routes.dart';
import '../../business_logic/cubits/response_cubit.dart';
import '../../business_logic/cubits/response_state.dart';

class ListItem extends StatelessWidget {
  const ListItem(
      {Key? key,
      required this.employee,
      required this.deleteEntry,
      required this.index})
      : super(key: key);

  final Employee employee;
  final VoidCallback deleteEntry;
  final int index;

  void _switchToEmployeePage(BuildContext context) {
    Navigator.pushNamed(context, Routes.employeeDialogRouteName,
        arguments: employee);
  }

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(employee.id),
      direction: DismissDirection.endToStart,
      confirmDismiss: (direction) {
        return showDialog(
            context: context,
            builder: (ctx) => AlertDialog(
                  content: const Text(
                    'Are you sure you want to remove this item?',
                  ),
                  title: const Text('Careful'),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop(false);
                      },
                      child: const Text('No'),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop(true);
                      },
                      child: const Text('Yes'),
                    )
                  ],
                ));
      },
      onDismissed: (_) => deleteEntry,
      background: Container(
        color: Theme.of(context).errorColor,
        child: const Icon(
          Icons.delete_forever,
          color: Colors.white,
        ),
      ),
      child: InkWell(
        highlightColor: Colors.blue.shade900,
        onTap: () => _switchToEmployeePage(context),
        child: Card(
          elevation: 1,
          child: ListTile(
            title: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('${employee.name} ${employee.surname}',
                  style: Theme.of(context).textTheme.headline6),
            ),
            subtitle: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                employee.email,
                style: const TextStyle(
                    fontFamily: 'Raleway-ExtraBold', fontSize: 16),
                softWrap: true,
              ),
            ),
            trailing: BlocConsumer<ResponseCubit, ResponseState>(
              listener: (context, state) {},
              builder: (context, state) {
                return TextButton(
                  onPressed: () async {
                    context
                        .read<ResponseCubit>()
                        .deleteEmployeeEntry(employee.id);
                  },
                  child: Text('delete'),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
