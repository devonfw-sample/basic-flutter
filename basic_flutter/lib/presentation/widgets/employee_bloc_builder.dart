import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../widgets/list_item.dart';
import '../../business_logic/cubits/response_cubit.dart';
import '../../business_logic/cubits/response_state.dart';
import 'employee_grid_item.dart';

class EmployeeBlocBuilder extends StatelessWidget {
  const EmployeeBlocBuilder({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cubitInstance = context.read<ResponseCubit>();
    return RefreshIndicator(
      onRefresh: () {
        return cubitInstance.getStateData();
      },
      child: BlocBuilder<ResponseCubit, ResponseState>(
        builder: (context, state) {
          if (state.dataState == DataLoadingStates.dataLoaded) {

            if (state.isGridView) {
              return GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    mainAxisSpacing: 10,
                    crossAxisCount: 2,
                    childAspectRatio: 3 / 2,
                    crossAxisSpacing: 10),
                itemBuilder: (context, index) {
                  return EmployeeGridItem(
                      indexedEmployee: state.employeeList[index]);
                },
                itemCount: state.employeeList.length,
              );
            } else {
              return ListView.builder(
                itemBuilder: (ctx, index) {
                  return ListItem(
                    index: index,
                    employeeList: state.employeeList,
                    deleteEntry: () => cubitInstance.deleteEmployeeEntry(
                        state.employeeList, index),
                  );
                },
                itemCount: state.employeeList.length,
              );
            }

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
              onRefresh: () => cubitInstance.getStateData(),
              child: Center(
                child: Text('Data loading failed',
                    style: Theme.of(context).textTheme.headline6),
              ),

            );
          }
        },
      ),
    );
  }
}
