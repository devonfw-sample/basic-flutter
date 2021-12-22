import 'package:basic_flutter/presentation/screens/employees_list_screen.dart';
import 'package:basic_flutter/repository/data_provider.dart';
import 'package:bloc/bloc.dart';

import '../../data/employee.dart';
import '/business_logic/cubits/response_state.dart';
import '../../data/routes.dart';

class ResponseCubit extends Cubit<ResponseState> {
  List<Employee> employeeList;
  DataProvider dataProvider = DataProvider();

  ResponseCubit(this.employeeList)
      : super(ResponseState(DataLoadingStates.dataLoading, employeeList)) {
    getStateData();
  }

  void getStateData() async {
    try {
      employeeList =
          await dataProvider.getEmployeesList(EmployeesListScreen.url);
      if (employeeList.isNotEmpty) {
        emit(ResponseState(DataLoadingStates.dataLoaded, employeeList));
      } else {
        emit(ResponseState(DataLoadingStates.loadingFailed, employeeList));
      }
    } catch (error) {
      emit(ResponseState(DataLoadingStates.loadingFailed, employeeList));
    }
  }
}
