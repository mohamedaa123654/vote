import 'package:flutter/material.dart';

class Custom_Button extends StatelessWidget {
  Custom_Button({Key? key, this.onTap, required this.text}) : super(key: key);
  final VoidCallback? onTap;
  final String? text;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: 60,
        child: Center(
          child: Text(text!),
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }
}
