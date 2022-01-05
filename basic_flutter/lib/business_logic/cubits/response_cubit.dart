
import 'package:bloc/bloc.dart';

import '../../presentation/screens/employees_list_screen.dart';
import '/../repository/data_provider.dart';
import '/business_logic/cubits/response_state.dart';
import '../../data/employee.dart';

class ResponseCubit extends Cubit<ResponseState> {
  late List<Employee> employeeList;
  final DataProvider dataProvider;
  late int currentListIndex;
  ResponseCubit(this.dataProvider, this.employeeList)
      : super(ResponseState(DataLoadingStates.dataLoading, employeeList)) {
    getStateData();
  }


  Future<void> getStateData() async {
    try {
      employeeList = await dataProvider
          .getEmployeesList(EmployeesListScreen.searchEmployeeListEndpoint);
      currentListIndex = employeeList.length;
      if (currentListIndex != 0) {
      emit(ResponseState(DataLoadingStates.dataLoaded, employeeList));
      } else {
        emit(ResponseState(DataLoadingStates.loadingFailed, employeeList));
      }
    } catch (error) {
      emit(ResponseState(DataLoadingStates.loadingError, employeeList));
    }
  }

  bool _detectListUpdate() {
    if (currentListIndex != employeeList.length) {
      emit(ResponseState(DataLoadingStates.dataChanged, employeeList));
      getStateData();
      return true;
    } else {
      return false;
    }
  }

  void deleteEmployeeEntry(List<Employee> employeeList, int index) async {
    if (_detectListUpdate()) {
      await dataProvider.deleteEmployee(
          index.toString(), EmployeesListScreen.deleteEmployeeEndpoint);
      dataProvider.response.removeWhere((employee) {
        return employee.id == dataProvider.response[index].id;
      });
    }
  }
}
