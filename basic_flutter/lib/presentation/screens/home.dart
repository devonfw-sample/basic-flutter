
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:basic_flutter/presentation/screens/new_profile_page.dart';
import '../widgets/build_edit_appbar.dart';
import '../../business_logic/cubits/dialog_cubit.dart';
import '../../business_logic/cubits/dialog_state.dart';
import '../../themes.dart';
import 'package:animated_theme_switcher/animated_theme_switcher.dart';


class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return BlocBuilder<DialogCubit, DialogState>(
      builder: (context, state) {
        return Scaffold(
          appBar: const PreferredSize(
            preferredSize: Size.fromHeight(50.0),
            child: BuildEditAppbar(),
          ),
          body: Builder(
            builder: (BuildContext context) {
              return Center(
                child: ListView.builder(
                  itemBuilder: (context, index) {
                    return ListTile(
                        title: Text(state.employeeList[index].name));
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
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => NewProfilePage().build(context)));
            },
          ),
        );
      },
    );
  }
}
