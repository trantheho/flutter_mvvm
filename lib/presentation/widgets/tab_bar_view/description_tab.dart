import 'package:flutter/material.dart';
import 'package:flutter_mvvm/core/utils/styles.dart';

class DescriptionTab extends StatelessWidget {
  const DescriptionTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam ",
      style: AppTextStyle.normal,
      textAlign: TextAlign.start,
    );
  }
}
