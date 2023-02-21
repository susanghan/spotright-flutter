import 'package:flutter/material.dart';
import 'package:spotright/presentation/common/colors.dart';

class AppbarTitle extends StatelessWidget {
  const AppbarTitle({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: const TextStyle(color: SrColors.black, fontSize: 20, fontWeight: FontWeight.w500),
    );
  }
}
