import 'package:flutter/material.dart';
import '../../data/employee.dart';

class NameTextField extends StatelessWidget {
  const NameTextField(
      {Key? key,
      required this.label,
      required this.controller,
      required this.submitData,
      required this.employeeUnderEdit})
      : super(key: key);

  final String label;
  final TextEditingController controller;
  final Function submitData;
  final Employee employeeUnderEdit;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        const SizedBox(height: 8),
        TextField(
          onSubmitted: (enteredText) =>
              submitData(context, enteredText, label, employeeUnderEdit),
          controller: controller,
          decoration: InputDecoration(
            hintText: label,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
      ],
    );
  }
}
