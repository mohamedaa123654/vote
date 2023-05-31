import 'package:flutter/material.dart';
import 'package:vote/componants/constant.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white,
      body: Center(child:CircularProgressIndicator(color: kPrimaryColor,strokeWidth: 20,)),
    );
  }
}
