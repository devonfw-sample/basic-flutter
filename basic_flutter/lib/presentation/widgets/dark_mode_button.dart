import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../business_logic/cubits/response_cubit.dart';

class DarkModeButton extends StatelessWidget {
  const DarkModeButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.dark_mode_outlined, color: Colors.white),
      onPressed: () => context.read<ResponseCubit>().toggleDarkMode(),
    );
  }
}
