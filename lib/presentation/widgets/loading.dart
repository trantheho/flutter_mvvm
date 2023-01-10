import 'package:flutter/material.dart';

class AppLoading extends StatelessWidget {
  const AppLoading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      //padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: const Color.fromRGBO(40, 42, 62, 1).withAlpha(100),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: const Center(
        child: CircularProgressIndicator.adaptive(
          backgroundColor: Colors.white,
        ),
      ),
    );
  }
}
