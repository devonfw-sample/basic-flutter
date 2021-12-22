import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

import '/repository/data_provider.dart';
import '../widgets/list_item.dart';
import '/business_logic/cubits/response_cubit.dart';
import '/business_logic/cubits/response_state.dart';
import '/data/routes.dart';
import '../../data/employee.dart';

class EmployeesListScreen extends StatefulWidget {
  const EmployeesListScreen({Key? key}) : super(key: key);

  @override
  State<EmployeesListScreen> createState() => _EmployeesListScreenState();
}

class _EmployeesListScreenState extends State<EmployeesListScreen> {
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
          create: (context) => ResponseCubit(employeeList),
          child: EmployeeBlocBuilder(employeeList: employeeList)),
    );
  }
}

class EmployeeBlocBuilder extends StatelessWidget {
  const EmployeeBlocBuilder({Key? key, required this.employeeList})
      : super(key: key);
  final List<Employee> employeeList;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ResponseCubit, ResponseState>(
      builder: (context, state) {
        if (state.dataState == DataLoadingStates.dataLoaded) {
          return ListView.builder(
            itemBuilder: (ctx, index) {
              return ListItem(
                index: index,
                employeeList: state.employeeList,
              );
            },
            itemCount: state.employeeList.length,
          );
        } else if (state.dataState == DataLoadingStates.dataLoading) {
          return Center(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(
                    Theme.of(context).primaryColor),
              ),
              const SizedBox(height: 5),
              Text(
                'Data loading',
                style: Theme.of(context).textTheme.headline6,
              ),
            ],
          ));
        } else {
          return Center(
              child: Text('Data loading failed',
                  style: Theme.of(context).textTheme.headline6));
        }
      },
    );
  }
}
