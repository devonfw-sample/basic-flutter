import 'package:bloc/bloc.dart';

import '../../presentation/screens/employees_list_screen.dart';
import '/../repository/data_provider.dart';
import '/business_logic/cubits/response_state.dart';
import '../../data/employee.dart';
import '../../data/endpoints.dart';

class ResponseCubit extends Cubit<ResponseState> {
  List<Employee> employeeList = [];
  final DataProvider dataProvider;
  int currentListIndex = 0;
  bool isDeleted = false;
  ResponseCubit(this.dataProvider, this.employeeList)
      : super(ResponseState(DataLoadingStates.dataLoading, employeeList)) {
    getStateData();
  }

  Future<void> getStateData() async {
    try {
      employeeList =
          await dataProvider.getEmployeesList(Endpoints.searchEndpoint);
      currentListIndex = employeeList.length;
      if (currentListIndex != 0) {
        emit(ResponseState(DataLoadingStates.dataLoaded, employeeList));
      } else {
        emit(ResponseState(DataLoadingStates.loadingFailed, employeeList));
      }
    } catch (error) {
      emit(ResponseState(DataLoadingStates.loadingFailed, employeeList));
    }
  }

  bool _detectListUpdate() {
    if (currentListIndex != state.employeeList.length) {
      return true;
    } else {
      return false;
    }
  }

  void deleteEmployeeEntry(List<Employee> employeeList, int index) async {
    if (_detectListUpdate()) {
      getStateData();
      isDeleted = await dataProvider.deleteEmployee(
          index.toString(), Endpoints.deleteEmployeeEndpoint, index);
      emit(ResponseState(DataLoadingStates.dataChanged, employeeList));
    }
  }

  void toggleIsDeleted() {
    isDeleted = !isDeleted;
  }
}
