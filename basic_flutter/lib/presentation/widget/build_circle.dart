import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'build_circle_widget.dart';
import '../../../../data/employee.dart';

class BuildCircle extends StatelessWidget {
  BuildCircle({Key? key}) : super(key: key);
  Employee employee = const Employee(
    imagePath: 'assets/image.png',
    id: '',
    firstName: '',
    lastName: '',
    profession: '',
    country: '',
    email: '',
    phone: '',
    location: '',
    isDarkMode: false,
  );

  @override
  Widget build(BuildContext context) {
    return BuildCircleWidget(
      color: Colors.white,
      all: 3,
      child: BuildCircleWidget(
        color: Colors.blue.shade900,
        all: 10,
        child: GestureDetector(
          onTap: () async {
            final image =
                await ImagePicker().getImage(source: ImageSource.gallery);

            if (image == null) return;

            final directory = await getApplicationDocumentsDirectory();
            final name = basename(image.path);
            final imageFile = File('${directory.path}/$name');
            final newImage = await File(image.path).copy(imageFile.path);
            employee = employee.copy(imagePath: newImage.path);
          },
          child: const Icon(
            Icons.add_a_photo,
            color: Colors.white,
            size: 20,
          ),
        ),
      ),
    );
  }
}
