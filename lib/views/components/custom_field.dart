import 'package:flutter/material.dart';

class CustomField extends StatelessWidget {
  const CustomField({
    super.key,
    required this.title,
    required this.enabled,
    required this.controller,
  });

  final String title;
  final bool enabled;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    ColorScheme cs = Theme.of(context).colorScheme;
    TextTheme tt = Theme.of(context).textTheme;
    return Padding(
      padding: const EdgeInsets.only(right: 16, bottom: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(" $title ", style: tt.titleLarge!.copyWith(color: cs.onSurface)),
          TextFormField(
            controller: controller,
            enabled: enabled,
            //initialValue: initVal,
            decoration: InputDecoration(
              prefixIcon: const Padding(
                padding: EdgeInsets.only(right: 12, left: 8),
                child: Icon(Icons.title, size: 30),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),

              // labelText: "title",
              // labelStyle: tt.bodyLarge,
              // label: Text(
              //   "title",
              //   style: tt.bodyLarge,
              // ),
              // floatingLabelBehavior: FloatingLabelBehavior.always,
              //disabledBorder: null,
            ),
            style: tt.bodyLarge!.copyWith(color: cs.onSurface),
          ),
        ],
      ),
    );
  }
}
