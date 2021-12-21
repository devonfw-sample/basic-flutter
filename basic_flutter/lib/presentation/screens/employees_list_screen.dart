import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

import '/repository/data_provider.dart';
import '../../business_logic/cubits/response_cubit.dart';
import '../../data/employee.dart';
import '../widgets/employee_bloc_builder.dart';

class EmployeesListScreen extends StatefulWidget {
  static const String deleteEmployeeEndpoint =
      'https://virtserver.swaggerhub.com/flutterteam2/flutter/1.0.0/employeemanagement/v1/employee/';
  static const searchEmployeeListEndpoint =
      "http://localhost:8080/employeemanagement/v1/employee/search/";

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
        actions: [
          TextButton(
              onPressed: () {}, child: Image.asset('assets/images/dots.png'))
        ],
      ),
      body: BlocProvider(
          create: (context) => ResponseCubit(dataProvider, employeeList),
          child: EmployeeBlocBuilder()),
    );
  }
}
