import 'package:bloc/bloc.dart';

import '/../repository/data_provider.dart';
import '/business_logic/cubits/response_state.dart';
import '../../data/employee.dart';
import '../../data/endpoints.dart';
import '../../data/routes.dart';

class ResponseCubit extends Cubit<ResponseState> {
  List<Employee> employeeList = []; //remove late and create an empty list
  final DataProvider dataProvider = DataProvider();
  int currentListIndex = 0; //remove late and create a zero start value
  bool isDarkMode;
  bool isGridView;
  bool isDeleted = false; //remove late and set to true or false as start value
  ResponseCubit(this.employeeList, this.isDarkMode, this.isGridView)
      : super(ResponseState(DataLoadingStates.dataLoading, employeeList,
            isDarkMode, isGridView));

  Future<void> getNewStateData() async {
    try {
      final Employee employee = await dataProvider.getEmployeeWithId(
          Endpoints.getEmployeeWithIdEndpoint, (Routes.index + 1).toString());

      employeeList.add(employee);

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

  //emit in deleteEmployeeEntry and update _detectListUpdate by removing all the logic
  bool _detectListUpdate() {
    getNewStateData();
    if (currentListIndex !=
        state.employeeList.length) //write employeeList.length
    {
      emit(ResponseState(
          DataLoadingStates.dataChanged, employeeList, isDarkMode, isGridView));

      return true;
    } else {
      return false;
    }
  }

  void deleteEmployeeEntry(List<Employee> employeeList, int index) async {
    if (_detectListUpdate()) {
      await dataProvider.deleteEmployee(
          index.toString(), Endpoints.deleteEmployeeEndpoint);
      isDeleted = true;
      dataProvider.response.removeWhere(
        (employee) {
          return employee.id ==
              dataProvider.response[index]
                  .id; // put the logic in the dataProvider class and just update the employeeList that you have here in cubit
        },
      );
    }
  }

  //use the boolean isDeleted in the dataProvider properly and change the future<void> deleteEmployee in DataProvider to Future<bool> in order to use in cubit
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
