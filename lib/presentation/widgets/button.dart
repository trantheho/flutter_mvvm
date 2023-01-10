import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  final Color? buttonColor;
  final String? buttonText;
  final TextStyle? style;
  final Function()? onPressed;
  final Color? borderColor;

  const AppButton({Key? key, this.buttonColor, this.buttonText, this.style, this.onPressed, this.borderColor,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(30)),
        color: buttonColor ?? Colors.blueAccent,
        border: Border.all(color: borderColor ?? Colors.transparent,),
      ),
      child: RawMaterialButton(
        onPressed: onPressed,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(30)),
        ),
        child: Center(
          child: Text(
            buttonText ?? "button",
            style: style ?? const TextStyle(
              fontSize: 16,
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}