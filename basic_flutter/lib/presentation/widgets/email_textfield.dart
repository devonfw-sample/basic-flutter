import 'package:flutter/material.dart';
import '../../data/employee.dart';

class EmailTextField extends StatelessWidget {
  final int maxLines;
  final String label;
  final String text;
  final Employee employeeUnderEdit;
  final controller = TextEditingController();
  EmailTextField({
    Key? key,
    this.maxLines = 1,
    required this.label,
    required this.text,
    required this.employeeUnderEdit,
  }) : super(key: key);

  void _submitData(BuildContext context, String enteredText) {
    bool emailValid = RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(enteredText);
    if (!emailValid) {
      ScaffoldMessenger.of(context).showSnackBar(_snackBarContent());
    }
  }

  SnackBar _snackBarContent() {
    return const SnackBar(content: Text("Please enter a valid email"));
  }

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
          onSubmitted: (enteredText) => _submitData(context, enteredText),
          controller: controller,
          decoration: InputDecoration(
            hintText: label,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          maxLines: maxLines,
        ),
      ],
    );
  }
}
