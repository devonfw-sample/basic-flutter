import '../../data/employee.dart';

enum DataLoadingStates {
  dataLoading,
  dataLoaded,
  dataChanged,
  loadingFailed,
  loadingError
}

class ResponseState {
  DataLoadingStates dataState;
  List<Employee> employeeList;

  ResponseState(this.dataState, this.employeeList);
}
