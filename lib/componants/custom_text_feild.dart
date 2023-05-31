import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField(
      {Key? key,
      this.hint,
      required this.label,
      this.suffix,
      this.prefix,
      this.initialValue,
      this.isPassword = false,
      this.enabled = true,
      this.onChanged,
      this.controller,
      this.keyboardType})
      : super(key: key);
  final String? hint;
  final String label;
  final String? initialValue;
  final TextInputType? keyboardType;
  final IconData? suffix;
  final IconData? prefix;
  final bool? isPassword;
  final bool? enabled;
  final Function(String)? onChanged;
  final TextEditingController? controller;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      initialValue: initialValue,
      obscureText: isPassword!,
      onChanged: onChanged,
      enabled: enabled,
      keyboardType: keyboardType,
      validator: (data) {
        if (data!.length<4) {
          return 'field is required';
        }
      },
      style: const TextStyle(
        color: Colors.white,
      ),
      
      decoration: InputDecoration(
          label: Text(label),

          labelStyle: TextStyle(color: Colors.white),
          suffix: Icon(suffix),
          border: OutlineInputBorder(),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(4),
            borderSide: const BorderSide(
              color: Colors.white,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(4),
            borderSide: const BorderSide(
              color: Colors.white,
            ),
          ),
          prefixIcon: Icon(prefix),
          prefixIconColor: Colors.white,
          hintText: hint,
          hintStyle: TextStyle(color: Colors.white)),
    );
  }
}
