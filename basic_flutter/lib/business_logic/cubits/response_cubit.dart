import 'package:basic_flutter/presentation/screens/employees_list_screen.dart';
import 'package:bloc/bloc.dart';

import '/../repository/data_provider.dart';
import '/business_logic/cubits/response_state.dart';

class ResponseCubit extends Cubit<ResponseState> {
  final DataProvider dataProvider;

  ResponseCubit(this.dataProvider)
      : super(ResponseState(DataLoadingStates.dataLoading)) {
    getStateData();
  }

  void getStateData() async {
    try {
      final employeeList =
          await dataProvider.getEmployeesList(EmployeesListScreen.url);
      if (employeeList.length != 0) {
        emit(ResponseState(DataLoadingStates.dataLoaded));
      }
    } catch (error) {
      emit(ResponseState(DataLoadingStates.loadingFailed));
    }
  }
}
