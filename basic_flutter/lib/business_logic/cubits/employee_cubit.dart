import 'package:bloc/bloc.dart';
import 'employee_state.dart';
import '../../data/employee.dart';

class EmployeeCubit extends Cubit<EmployeeState> {
  Employee employee;
  EmployeeCubit(EmployeeState initialState, this.employee)
      : super(EmployeeState(employee));

  void updateEmployeeData(
      Employee newEmployee, List<Employee> stateEmployeeList) {
    employee = newEmployee;
    if (stateEmployeeList.isNotEmpty) {
      for (Employee currentEmployee in stateEmployeeList) {
        if (currentEmployee.id == employee.id) {
          currentEmployee = employee;
          emit(EmployeeState(employee));
        }
      }
    }
  }
}
