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

  Widget buildEditIcon(Color color, BuildContext context) => BuildCircle(
        color: Colors.white,
        all: 3,
        child: BuildCircle(
          color: color,
          all: 10,
          child: GestureDetector(
            onTap: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => EditProfilePage()));
            },
            child: Icon(
              isEdit ? Icons.add_a_photo : Icons.edit,
              color: Colors.white,
              size: 20,
            ),
          ),
        ),
      );
}
