import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

import '/presentation/screens/employee_dialog.dart';
import '/repository/data_provider.dart';
import '../../business_logic/cubits/response_cubit.dart';
import '../../business_logic/cubits/response_state.dart';
import '../widgets/employee_bloc_builder.dart';

class EmployeesListScreen extends StatefulWidget {
  static const String routeName = "/employees-list-screen";
  static const String deleteEmployeeEndpoint =
      'https://virtserver.swaggerhub.com/flutterteam2/flutter/1.0.0/employeemanagement/v1/employee/';
  static const searchEmployeeListEndpoint =
      "https://virtserver.swaggerhub.com/flutterteam2/flutter/1.0.0/employeemanagement/v1/employee/search";

  const EmployeesListScreen({Key? key}) : super(key: key);

  @override
  State<EmployeesListScreen> createState() => _EmployeesListScreenState();
}

class _EmployeesListScreenState extends State<EmployeesListScreen> {
  void _switchToEmployeePage(BuildContext context) {
    Navigator.pushNamed(context, EmployeeDialog.routeName);
    // TODO:
  }

  Future buildListViewWidget(
      DataProvider dataProvider, String endpoint, ResponseState state) {
    dynamic response = dataProvider.getEmployeesList(endpoint).then((response) {
      if (response != null) {
        state.dataState = DataLoadingStates.dataLoaded;
      } else {
        state.dataState = DataLoadingStates.loadingFailed;
      }
    });
    return response;
  }

  @override
  Widget build(BuildContext context) {
    DataProvider dataProvider = DataProvider();
    return Scaffold(
      appBar: AppBar(
        title:
            const Text('Employees List', style: TextStyle(color: Colors.white)),
        centerTitle: true,
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: BlocProvider(
          create: (context) => ResponseCubit(dataProvider),
          child: EmployeeBlocBuilder(
            switchToEmployeePage: () => _switchToEmployeePage(context),
            dataProvider: dataProvider,
          )),
    );
  }
}
