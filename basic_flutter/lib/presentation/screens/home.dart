import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:basic_flutter/presentation/screens/new_profile_page.dart';
import 'package:flutter/material.dart';
import '../../themes.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../business_logic/cubits/dialog_cubit.dart';
import '../../business_logic/cubits/dialog_state.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DialogCubit, DialogState>(
      builder: (context, state) {
        return Scaffold(
          appBar: buildEditAppBar(context),
          body: Builder(
            builder: (BuildContext context) {
              return Center(
                child: ListView.builder(
                  itemBuilder: (context, index) {
                    return ListTile(
                        title: Text(state.employeeList[index].firstName));
                  },
                  itemCount: state.employeeList.isEmpty
                      ? 0
                      : state.employeeList.length,
                ),
              );
            },
          ),
          floatingActionButton: FloatingActionButton(
            tooltip: 'Add new employee',
            child: const Icon(
              Icons.add,
              size: 20,
            ),
            foregroundColor: Colors.white,
            backgroundColor: Colors.blue.shade900,
            onPressed: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => NewProfilePage()));
            },
          ),
        );
      },
    );
  }
}

AppBar buildEditAppBar(BuildContext context) {
  final isDarkMode = Theme.of(context).brightness == Brightness.dark;
  final icon = isDarkMode ? Icons.light_mode : Icons.dark_mode;

  return AppBar(
    backgroundColor: Colors.blue.shade900,
    title: const Text('Employee dialog'),
    centerTitle: true,
    leading: const BackButton(
      color: Colors.white,
    ),
    elevation: 0,
    actions: [
      ThemeSwitcher(
        builder: (context) => IconButton(
          icon: Icon(icon),
          onPressed: () {
            final theme = isDarkMode ? MyThemes.lightTheme : MyThemes.darkTheme;
            final switcher = ThemeSwitcher.of(context)!;
            switcher.changeTheme(theme: theme);
          },
        ),
      ),
    ],
  );
}
