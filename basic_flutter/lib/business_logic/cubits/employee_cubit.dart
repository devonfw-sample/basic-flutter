import 'package:basic_flutter/data/endpoints.dart';
import 'package:bloc/bloc.dart';
import 'employee_state.dart';
import '../../data/employee.dart';
import '../../repository/data_provider.dart';

class EmployeeCubit extends Cubit<EmployeeState> {
  Employee employee;
  DataProvider dataProvider = DataProvider();
  EmployeeCubit(EmployeeState initialState, this.employee)
      : super(EmployeeState(employee));

  void updateEmployeeData(Employee newDataEmployee, Employee oldDataEmployee,
      List<Employee> stateEmployeeList) {
    if (stateEmployeeList.isNotEmpty) {
      for (Employee currentEmployee in stateEmployeeList) {
        if (currentEmployee.id == oldDataEmployee.id) {
          // currentEmployee = newDataEmployee;
          dataProvider.updateEmployeeData(
              Endpoints.updateEmployeeEndpoint, currentEmployee);
          emit(EmployeeState(currentEmployee));
          break;
        }
      }
    }
  }
}
