import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '/repository/data_provider.dart';
import '../widgets/list_item.dart';
import '../../business_logic/cubits/response_cubit.dart';
import '../../business_logic/cubits/response_state.dart';

class EmployeeBlocBuilder extends StatelessWidget {
  const EmployeeBlocBuilder({
    Key? key,
    required this.dataProvider,
  }) : super(key: key);

  final DataProvider dataProvider;
  // use cubit dataprovider
  // move deleteEmployeeEntry to ResponseCubit

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ResponseCubit, ResponseState>(
      builder: (context, state) {
        if (state.dataState == DataLoadingStates.dataLoaded) {
          return RefreshIndicator(
            onRefresh: () => context.read<ResponseCubit>().getStateData(),
            child: ListView.builder(
              itemBuilder: (ctx, index) {
                return ListItem(
                  index: index,
                  employeeList: state.employeeList,
                  deleteEntry: () => context
                      .read<ResponseCubit>()
                      .deleteEmployeeEntry(state.employeeList, index),
                );
              },
              itemCount: state.employeeList.length,
            ),
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
          return RefreshIndicator(
            onRefresh: () => context.read<ResponseCubit>().getStateData(),
            child: Center(
                child: Text('Data loading failed',
                    style: Theme.of(context).textTheme.headline6)),
          );
        }
      },
    );
  }
}
