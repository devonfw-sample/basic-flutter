import 'package:bloc/bloc.dart';

import '/../repository/data_provider.dart';
import '/business_logic/cubits/response_state.dart';
import '../../data/employee.dart';
import '../../data/endpoints.dart';


class ResponseCubit extends Cubit<ResponseState> {
  List<Employee> employeeList = [];
  final DataProvider dataProvider;
  int currentListIndex = 0;
  bool isDeleted = false;
  bool isDarkMode;
  bool isGridView;
  ResponseCubit(
      this.dataProvider, this.employeeList, this.isDarkMode, this.isGridView)
      : super(ResponseState(DataLoadingStates.dataLoading, employeeList,
            isDarkMode, isGridView)) {

    getStateData();
  }

  Future<void> getStateData() async {
    try {
      employeeList = await dataProvider.getEmployeesList(Endpoints.searchEmployeeListEndpoint);
      currentListIndex = employeeList.length;
      if (currentListIndex != 0) {
        emit(ResponseState(DataLoadingStates.dataLoaded, employeeList,
            isDarkMode, isGridView));
      } else {
        emit(ResponseState(DataLoadingStates.loadingFailed, employeeList,
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

      getStateData();
      isDeleted = await dataProvider.deleteEmployee(
          index.toString(), Endpoints.deleteEmployeeEndpoint, index);
      emit(ResponseState(DataLoadingStates.dataChanged, employeeList));
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
