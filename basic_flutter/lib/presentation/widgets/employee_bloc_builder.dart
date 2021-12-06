import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '/repository/data_provider.dart';
import '../widgets/list_item.dart';
import '../../business_logic/cubits/response_cubit.dart';
import '../../business_logic/cubits/response_state.dart';
import '/presentation/screens/employees_list_screen.dart';

class EmployeeBlocBuilder extends StatelessWidget {
  const EmployeeBlocBuilder({
    Key? key,
    required this.switchToEmployeePage,
    required this.dataProvider,
  }) : super(key: key);

  final VoidCallback switchToEmployeePage;
  final DataProvider dataProvider;

  void _deleteEmployeeEntry(DataProvider dataProvider, int index) async {
    await dataProvider.deleteEmployee(
        index.toString(), EmployeesListScreen.deleteEmployeeEndpoint);
    dataProvider.response.removeWhere((employee) {
      return employee.id == dataProvider.response[index].id;
    });
  }

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
                dataProvider: state.stateDataProvider,
                deleteEntry: () =>
                    _deleteEmployeeEntry(state.stateDataProvider, index),
              );
            },
            itemCount: state.stateDataProvider.response.length,
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
        } else if (state.dataState == DataLoadingStates.dataChanged) {
          return Text("dataChanged");
          // TODO: Update List
        } else {
          return Center(
              child: Text('Data loading failed',
                  style: Theme.of(context).textTheme.headline6));
        }
      },
    );
  }
}
