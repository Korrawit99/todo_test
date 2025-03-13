import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
 
class AppTextField extends StatelessWidget {
  final String label;
  const AppTextField({super.key,
  required this.label});
 
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [Text(label),TextField()],
    );
  }
}