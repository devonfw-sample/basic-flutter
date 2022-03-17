import 'package:bloc/bloc.dart';

import '/../repository/data_provider.dart';
import '/business_logic/cubits/response_state.dart';
import '../../data/employee.dart';
import '../../data/endpoints.dart';
import '../../data/routes.dart';

class ResponseCubit extends Cubit<ResponseState> {
  List<Employee> employeeList = [];
  final DataProvider dataProvider = DataProvider();
  int currentListIndex = 0;
  bool isDarkMode;
  bool isGridView;
  bool isDeleted = false;
  ResponseCubit(this.employeeList, this.isDarkMode, this.isGridView)
      : super(ResponseState(DataLoadingStates.dataLoading, employeeList,
            isDarkMode, isGridView));

  Future<void> getNewStateData() async {
    try {
      employeeList = await dataProvider
          .getEmployeesList(Endpoints.searchEmployeeListEndpoint);

      if (employeeList.isNotEmpty) {
        emit(ResponseState(DataLoadingStates.dataLoaded, employeeList,
            isDarkMode, isGridView));
      } else if (dataProvider.noData) {
        emit(ResponseState(DataLoadingStates.noDataAvailable, employeeList,
            isDarkMode, isGridView));
      }
    } catch (error) {
      emit(ResponseState(DataLoadingStates.loadingError, employeeList,
          isDarkMode, isGridView));
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
      getNewStateData();
      isDeleted = await dataProvider.deleteEmployee(
          index.toString(), Endpoints.deleteEmployeeEndpoint, index);
      emit(ResponseState(
          DataLoadingStates.dataChanged, employeeList, isDarkMode, isGridView));
    }
  }

  void toggleDarkMode() {
    isDarkMode = !isDarkMode;
    emit(ResponseState(
        state.dataState, state.employeeList, isDarkMode, state.isGridView));
  }

  void toggleGridView() {
    isGridView = !isGridView;
    emit(ResponseState(
        state.dataState, state.employeeList, state.isDarkMode, isGridView));
  }

  void toggleIsDeleted() {
    isDeleted = !isDeleted;
  }
}
