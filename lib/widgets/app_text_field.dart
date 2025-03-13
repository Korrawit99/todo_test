import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class AppTextField extends StatelessWidget {
  final String label;
  final TextEditingController controller;

  AppTextField({super.key, required this.label, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Column(
      // ทำให้ widget ข้างในเรียงชิดด้านซ้าย
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // label
        Text(label),
        SizedBox(height: 8),
        // input
        TextField(
          controller: controller,
        ),
        SizedBox(height: 16),
      ],
    );
  }
}