import 'package:flutter_bloc/flutter_bloc.dart';
import 'dialog_state.dart';
import '../../data/employee.dart';

class DialogCubit extends Cubit<DialogState> {
  Employee employee;
  List<Employee> employeeList = [];

  DialogCubit(
    this.employee,
    this.employeeList,
  ) : super(DialogState(employee, employeeList));

  void changeEmployeeData(Employee employee) {
    this.employee = employee;
    employeeList.add(this.employee);
    emit(DialogState(this.employee, employeeList));
  }
}
