import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:path/path.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'build_circle.dart';
import '../../business_logic/cubits/employee_cubit.dart';
import '../../business_logic/cubits/employee_state.dart';

class EditIcon extends StatelessWidget {
  const EditIcon({Key? key, required this.color}) : super(key: key);

  final Color color;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EmployeeCubit, EmployeeState>(
      builder: (context, state) {
        return BuildCircle(
          color: Colors.white,
          all: 3,
          child: BuildCircle(
            color: color,
            all: 10,
            child: GestureDetector(
              onTap: () async {
                final image =
                    await ImagePicker().getImage(source: ImageSource.gallery);

                if (image == null) return;

                final directory = await getApplicationDocumentsDirectory();
                final name = basename(image.path);
                final imageFile = File('${directory.path}/');
                final newImage = await File(image.path).copy(imageFile.path);
              },
              child: const Icon(
                Icons.add_a_photo,
                color: Colors.white,
                size: 20,
              ),
            ),
          ),
        );
      },
    );
  }
}
