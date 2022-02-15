import '../../data/employee.dart';

enum DataLoadingStates {
  dataLoading,
  dataLoaded,
  dataChanged,
  loadingFailed,
  loadingError,
  noDataAvailable,
}

class ResponseState {
  DataLoadingStates dataState;
  List<Employee> employeeList;
  bool isDarkMode;
  bool isGridView;

  ResponseState(
      this.dataState, this.employeeList, this.isDarkMode, this.isGridView);
}
