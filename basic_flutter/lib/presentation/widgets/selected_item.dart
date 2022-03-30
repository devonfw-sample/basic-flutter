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
    return ListTile(
      title: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text('${employee.name} ${employee.surname}',
            style: Theme.of(context).textTheme.headline6),
      ),
      subtitle: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          employee.email,
          style: const TextStyle(fontFamily: 'Raleway-ExtraBold', fontSize: 16),
          softWrap: true,
        ),
      ),
      trailing: Stack(
        children: [
          Text(
            employee.employeeId,
            style: TextStyle(fontSize: 16),
          ),
          BlocConsumer<ResponseCubit, ResponseState>(
            listener: (context, state) {},
            builder: (context, state) {
              return Icon(employee.isSelected
                  ? Icons.check_box_outlined
                  : Icons.check_box_outline_blank_outlined);
            },
          )
        ],
      ),
    );
  }
}
