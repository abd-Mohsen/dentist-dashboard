import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomField extends StatelessWidget {
  const CustomField({
    super.key,
    required this.title,
    this.enabled,
    this.onChanged,
    this.validator,
    required this.controller,
  });

  final String title;
  final bool? enabled;
  final void Function(String)? onChanged;
  final String? Function(String?)? validator;
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
            enabled: enabled ?? true,
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
            onChanged: onChanged ?? (s) {},
            validator: validator ??
                (s) {
                  return null;
                },
          ),
        ],
      ),
    );
  }
}

String? validateInput(String val, int min, int max, String type, {String pass = "", String rePass = ""}) {
  //todo: localize
  if (val.trim().isEmpty) return "cant be empty";

  if (type == "username") {
    if (!GetUtils.isUsername(val)) return "not a valid user name";
  }
  if (type == "email") {
    if (!GetUtils.isEmail(val)) return "not a valid email";
  }
  if (type == "phone") {
    if (!GetUtils.isPhoneNumber(val)) return "not a valid phone";
  }
  if (val.length < min) return "value cant be smaller than $min characters";

  if (val.length > max) return "value cant be greater than $max characters";

  if (pass != rePass) return "passwords don't match".tr;

  return null;
}
