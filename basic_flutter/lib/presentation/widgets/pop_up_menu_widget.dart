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
      color: Colors.white,
      icon: const Icon(
        Icons.more_vert,
        color: Colors.white,
      ),
      onSelected: (value) {
        if (value == 0) {
          context.read<ResponseCubit>().toggleGridView();
        }
      },
      itemBuilder: (context) => [
        PopupMenuItem(
          value: 0,
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.all(8),
                child: Text(
                  'Grid View',
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
              ),
              Divider(height: 5),
              Container(
                margin: EdgeInsets.all(8),
                child: Text(
                  'Delete Items',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
