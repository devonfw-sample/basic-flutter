import 'package:bloc/bloc.dart';

import '/../repository/data_provider.dart';
import '/business_logic/cubits/response_state.dart';
import '../../data/employee.dart';
import '../../data/endpoints.dart';

class ResponseCubit extends Cubit<ResponseState> {
  List<Employee> employeeList = [];
  List<Employee> employeeListToDelete = [];
  final DataProvider dataProvider = DataProvider();
  int currentListIndex = 0;
  bool isDarkMode;
  bool isGridView;
  bool isDeleted = false;
  bool deleteMode = false;
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

  void addEmployeeToDelete(Employee employee) {
    employeeListToDelete.add(employee);
  }

  Future<void> deleteEmployeeList() async {
    employeeListToDelete.map(
      (employee) async {
        int index = 0;
        for (var currentEmployee in employeeList) {
          if (currentEmployee.id == employee.id) {
            index = employeeList.indexOf(currentEmployee);
            break;
          }
        }
        await dataProvider.deleteEmployee(
            employee.id.toString(), Endpoints.deleteEmployeeEndpoint);
      },
    );
    await getNewStateData();
  }

  void deleteEmployeeEntry(int id) async {
    isDeleted = await dataProvider.deleteEmployee(
        id.toString(), Endpoints.deleteEmployeeEndpoint);
    if (isDeleted) {
      getNewStateData();
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

  void toggleDeleteMode() {
    deleteMode = !deleteMode;
  }
}
