\
import 'package:flutter/material.dart';

class BsiSearchBar extends StatelessWidget {
  final String hint;
  final TextEditingController controller;
  final void Function(String) onChanged;
  const BsiSearchBar({super.key, required this.hint, required this.controller, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        hintText: hint,
        prefixIcon: const Icon(Icons.search),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      ),
      onChanged: onChanged,
    );
  }
}
