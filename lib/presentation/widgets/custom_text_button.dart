import 'package:flutter/material.dart';

class Custom_Text_Button extends StatelessWidget {
  const Custom_Text_Button({Key? key, required this.onTap, required this.text})
      : super(key: key);
  final VoidCallback? onTap;
  final String? text;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: onTap,
        child: Text(
          text!,
          style: TextStyle(color: Colors.blue[300]),
        ));
  }
}
