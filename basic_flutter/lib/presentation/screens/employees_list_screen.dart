import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

import '/presentation/screens/employee_dialog.dart';
import '/repository/data_provider.dart';
import '../widgets/list_item.dart';
import '../../business_logic/cubits/response_cubit.dart';
import '../../business_logic/cubits/response_state.dart';

class EmployeesListScreen extends StatefulWidget {
  static const String routeName = "/employees-list-screen";
  static const url =
      "https://app.swaggerhub.com/apis/flutterteam2/basic-flutter/1.0.0#/searchCriteria/post/employeemanagement/v1/employee/search/";

  const EmployeesListScreen({Key? key}) : super(key: key);

  @override
  State<EmployeesListScreen> createState() => _EmployeesListScreenState();
}

class _EmployeesListScreenState extends State<EmployeesListScreen> {
  void _switchToEmployeePage(BuildContext context) {
    Navigator.pushNamed(context, EmployeeDialog.routeName);
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
    const String endpoint =
        "https://virtserver.swaggerhub.com/flutterteam2/basic-flutter/1.0.0/searchCriteria/post/employeemanagement/v1/employee/search/";
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
              dataProvider: dataProvider)),
    );
  }
}

class EmployeeBlocBuilder extends StatelessWidget {
  const EmployeeBlocBuilder(
      {Key? key,
      required this.switchToEmployeePage,
      required this.dataProvider})
      : super(key: key);
  final VoidCallback switchToEmployeePage;
  final DataProvider dataProvider;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ResponseCubit, ResponseState>(
      builder: (context, state) {
        if (state.dataState == DataLoadingStates.dataLoaded) {
          return ListView.builder(
            itemBuilder: (ctx, index) {
              return ListItem(
                index: index,
                switchToEmployeePage: switchToEmployeePage,
                dataProvider: dataProvider,
              );
            },
            itemCount: //dataProvider.response['content'].length
                1,
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
