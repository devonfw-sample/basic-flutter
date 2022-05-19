import 'package:flutter_bloc/flutter_bloc.dart';
import '/business_logic/cubits/response_cubit.dart';
import 'package:flutter/material.dart';

class PopUpMenuWidget extends StatelessWidget {
  const PopUpMenuWidget(
      {Key? key, required this.isDarkMode, required this.isGridView})
      : super(key: key);
  final bool isDarkMode;
  final bool isGridView;

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      elevation: 10,
      enableFeedback: true,
      color: Colors.white,
      icon: const Icon(
        Icons.more_vert,
        color: Colors.white,
      ),
      onSelected: (value) {
        if (value == 0) {
          context.read<ResponseCubit>().toggleGridView();
        } else if (value == 1) {
          context.read<ResponseCubit>().toggleDeleteMode();
        } else if (value == 2) {
          context.read<ResponseCubit>().getNewStateData();
        }
      },
      itemBuilder: (context) => const [
        PopupMenuItem(
          value: 0,
          child: Text('Grid View'),
        ),
        PopupMenuItem(
          value: 1,
          child: Text('Delete Multiple Items'),
        ),
        PopupMenuItem(
          value: 2,
          child: Text('Reload List'),
        )
      ],
    );
  }
}
