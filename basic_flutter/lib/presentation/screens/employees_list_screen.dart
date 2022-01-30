import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

import '/repository/data_provider.dart';

import '../../business_logic/cubits/response_cubit.dart';
import '../../data/employee.dart';
import '../widgets/employee_bloc_builder.dart';

class EmployeesListScreen extends StatefulWidget {
  const EmployeesListScreen({Key? key}) : super(key: key);

  @override
  State<EmployeesListScreen> createState() => _EmployeesListScreenState();
}

class _EmployeesListScreenState extends State<EmployeesListScreen> {
  final DataProvider dataProvider = DataProvider();

  final List<Employee> employeeList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            const Text('Employees List', style: TextStyle(color: Colors.white)),
        centerTitle: true,
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: BlocProvider(
          create: (context) => ResponseCubit(dataProvider, employeeList),
          child: const EmployeeBlocBuilder()),
    );
  }
}
