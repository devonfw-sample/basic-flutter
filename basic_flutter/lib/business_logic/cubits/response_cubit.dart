import 'package:bloc/bloc.dart';

import '../../presentation/screens/employees_list_screen.dart';
import '/../repository/data_provider.dart';
import '/business_logic/cubits/response_state.dart';

class ResponseCubit extends Cubit<ResponseState> {
  final DataProvider dataProvider;
  late int currentListIndex;
  ResponseCubit(this.dataProvider)
      : super(ResponseState(DataLoadingStates.dataLoading, dataProvider)) {
    getStateData();
  }

  void getStateData() async {
    try {
      final employeeList = await dataProvider
          .getEmployeesList(EmployeesListScreen.searchEmployeeListEndpoint);
      currentListIndex = employeeList.length;
      if (currentListIndex != 0) {
        emit(ResponseState(DataLoadingStates.dataLoaded, dataProvider));
      } else {
        emit(ResponseState(DataLoadingStates.loadingFailed, dataProvider));
      }
    } catch (error) {
      emit(ResponseState(DataLoadingStates.loadingFailed, dataProvider));
    }
  }

  void detectListUpdate() async {
    if (currentListIndex != dataProvider.response.length) {
      emit(ResponseState(DataLoadingStates.dataChanged, dataProvider));
      getStateData();
    }
  }
}
