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
      emit(ResponseState(DataLoadingStates.loadingFailed, employeeList));
    }
  }
}
