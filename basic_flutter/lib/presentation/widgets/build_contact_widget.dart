import 'package:flutter/material.dart';
import '../../data/employee.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../business_logic/cubits/response_cubit.dart';

class BuildContactWidget extends StatelessWidget {
  const BuildContactWidget({Key? key, required this.employee})
      : super(key: key);
  final Employee employee;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width * 0.1),
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.3,
        child: ListView(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Text('Contact',
                  style: Theme.of(context).textTheme.headline5,
                  textAlign: TextAlign.left),
            ),
            ListTile(
                leading: Icon(Icons.email,
                    color: BlocProvider.of<ResponseCubit>(context).isDarkMode
                        ? Colors.white
                        : Colors.black),
                title: Text(
                  employee.email.toString(),
                  style: Theme.of(context).textTheme.headline5,
                )),
            ListTile(
              leading: Icon(Icons.account_circle,
                  color: BlocProvider.of<ResponseCubit>(context).isDarkMode
                      ? Colors.white
                      : Colors.black),
              title: Text(employee.employeeId.toString(),
                  style: Theme.of(context).textTheme.headline5),
            ),
          ],
        ),
      ),
    );
  }
}
