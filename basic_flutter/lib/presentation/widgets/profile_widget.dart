import 'package:flutter/material.dart';
import '../../presentation/screens/edit_profile_page.dart';
import 'build_circle.dart';

class ProfileWidget extends StatelessWidget {
  final bool isEdit;
  final VoidCallback onClicked;
  final Widget sentWidget;

  const ProfileWidget(
      {Key? key,
      this.isEdit = false,
      required this.onClicked,
      required this.sentWidget})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        children: [
          sentWidget,
        ],
      ),
    );
  }
}
