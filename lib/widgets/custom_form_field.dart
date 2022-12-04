import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomFormField extends StatelessWidget {
  const CustomFormField({
    Key? key,
    required this.hintText,
    required this.labelText,
    required this.controller,
    this.obscureText,
    this.inputFormatters,
    this.validator,
  }) : super(key: key);
  final TextEditingController controller;
  final String hintText;
  final String labelText;
  final bool? obscureText;
  final List<TextInputFormatter>? inputFormatters;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
          autovalidateMode: AutovalidateMode.onUserInteraction,
        inputFormatters: inputFormatters,
        validator: validator,
        obscureText: (obscureText ?? false),
        controller: controller,
        decoration: InputDecoration(
            hintText: hintText,
            border: const OutlineInputBorder(),
            labelText: labelText),
      ),
    );
  }
}
