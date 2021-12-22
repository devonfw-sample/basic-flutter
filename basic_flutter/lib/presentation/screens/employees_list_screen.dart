import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

import '../../business_logic/cubits/response_cubit.dart';
import '../widgets/employee_bloc_builder.dart';

class EmployeesListScreen extends StatefulWidget {
  const EmployeesListScreen({Key? key}) : super(key: key);

  @override
  State<EmployeesListScreen> createState() => _EmployeesListScreenState();
}

class _EmployeesListScreenState extends State<EmployeesListScreen> {
  @override
  Widget build(BuildContext context) {
    final currentCubitInstance = context.read<ResponseCubit>();
    bool isGrid = false;
    return Scaffold(
      appBar: AppBar(
        title:
            const Text('Employees List', style: TextStyle(color: Colors.white)),
        centerTitle: true,
        backgroundColor: Theme.of(context).primaryColor,
        actions: [
          Theme(
            data: Theme.of(context)
                .copyWith(iconTheme: const IconThemeData(color: Colors.white)),
            child: PopupMenuButton(
              color: Colors.white,
              icon: const Icon(
                Icons.more_vert,
                color: Colors.white,
              ),
              itemBuilder: (context) => [
                PopupMenuItem(
                  value: 0,
                  child: Row(
                    children: [
                      Switch(
                        onChanged: (value) {
                          setState(() {
                            currentCubitInstance.toggleDarkMode(value);
                          });
                        },
                        value: currentCubitInstance.isDarkMode,
                      ),
                      const Text(
                        'Dark Mode',
                        style: TextStyle(
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
                PopupMenuItem(
                  onTap: () => isGrid = !isGrid,
                  value: 1,
                  child: Row(
                    children: [
                      Switch(
                        onChanged: (value) {
                          setState(() {
                            isGrid = value;
                          });
                        },
                        value: isGrid,
                      ),
                      const Text(
                        'Grid View',
                        style: TextStyle(
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      body: EmployeeBlocBuilder(
        isGrid: isGrid,
      ),
    );
  }
}
