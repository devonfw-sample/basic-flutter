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
//elmafrood ely ye7sal hena eny ha5od elemployee ely gayeely
//hadawar 3la nafs elemployee be nafs el ID
//ha2oom b3d keda 25osh 3la eny 28ayar eldata
//8ayart eldata 2a2oom 23ml emit we 5elset 3la kda
//tayeb eh elarguments ely e7na me7tagenha, bos ya m3alem
//2wl 7aga ana me7tag elemployee elgdeed ely ana ba8ayar eldata bta3to
//tany 7aga ana me7tag el list ely ana hashta8al 3aleha

  void updateEmployeeData(Employee newDataEmployee, Employee oldDataEmployee,
      List<Employee> stateEmployeeList) {
    employee = newDataEmployee;
    if (stateEmployeeList.isNotEmpty) {
      for (Employee currentEmployee in stateEmployeeList) {
        if (currentEmployee.id == oldDataEmployee.id) {
          currentEmployee = newDataEmployee;
          dataProvider.updateEmployeeData(Endpoints.deleteEmployeeEndpoint,
              Endpoints.insertEmployeeEndpoint, currentEmployee);
          emit(EmployeeState(currentEmployee));
        }
      }
    }
  }
}
