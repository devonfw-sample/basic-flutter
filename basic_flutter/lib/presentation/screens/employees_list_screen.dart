import 'package:basic_flutter/presentation/widgets/dark_mode_button.dart';
import 'package:basic_flutter/presentation/widgets/pop_up_menu_widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

import '../../business_logic/cubits/response_cubit.dart';
import '../widgets/employee_bloc_builder.dart';
import '../../business_logic/cubits/response_state.dart';

class EmployeesListScreen extends StatelessWidget {
  const EmployeesListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ResponseCubit, ResponseState>(builder: (context, state) {
      return GestureDetector(
        onTap: () {
          if (context.read<ResponseCubit>().deleteMode) {
            context.read<ResponseCubit>().toggleDeleteMode();
          }
        },
        child: Scaffold(
          floatingActionButton: context.read<ResponseCubit>().deleteMode
              ? FloatingActionButton(
                  foregroundColor: Colors.white,
                  child: Icon(Icons.delete_forever),
                  backgroundColor: Theme.of(context).errorColor,
                  onPressed: () async =>
                      await context.read<ResponseCubit>().deleteEmployeeList(),
                )
              : null,
          appBar: AppBar(
            iconTheme: const IconThemeData(color: Colors.white),
            title: const Text('Employees List',
                style: TextStyle(color: Colors.white)),
            centerTitle: true,
            backgroundColor: Theme.of(context).primaryColor,
            actions: [
              const DarkModeButton(),
              Theme(
                  data: Theme.of(context).copyWith(
                      iconTheme: const IconThemeData(color: Colors.white)),
                  child: PopUpMenuWidget(
                      isDarkMode: state.isDarkMode,
                      isGridView: state.isGridView)),
            ],
          ),
          backgroundColor: Theme.of(context).canvasColor,
          body: const EmployeeBlocBuilder(),
        ),
      );
    });
  }
}
