import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mvvm/core/utils/styles.dart';

import 'app_text_form_field.dart';

enum InputType {
  email,
  password,
  text,
}

// ignore: must_be_immutable
class AppInput extends StatefulWidget {
  final EdgeInsetsGeometry? contentPadding;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  InputDecoration? inputDecoration;
  TextStyle? style;
  final TextInputType? keyboardType;
  final bool? obscureText;
  final Color? borderColor;
  final Function(String)? onChanged;
  final String? Function(String?)? validator;
  final GlobalKey<FormState>? formKey;
  AutovalidateMode? autovalidateMode;
  InputType inputType = InputType.text;
  final double? height;

  AppInput({
    super.key,
    this.contentPadding,
    this.controller,
    this.focusNode,
    this.keyboardType = TextInputType.text,
    this.obscureText,
    this.borderColor,
    this.onChanged,
    this.validator,
    TextStyle? style,
    this.formKey,
    this.height,
  })  : inputDecoration = const InputDecoration(),
        style = style ?? const TextStyle(),
        inputType = InputType.text;

  AppInput.email({
    super.key,
    this.contentPadding = const EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
    this.controller,
    this.focusNode,
    this.keyboardType = TextInputType.emailAddress,
    this.obscureText,
    this.borderColor,
    this.onChanged,
    this.validator,
    this.formKey,
    TextStyle? style,
    this.autovalidateMode,
    this.height,
  })  : inputType = InputType.email,
        inputDecoration = InputDecoration(
          hintText: "example@gmail.com",
          hintStyle: AppTextStyle.normal.copyWith(
            fontSize: 16,
            color: AppColors.grey,
          ),
          border: InputBorder.none,
          contentPadding: contentPadding ?? const EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide(
              color: borderColor ?? Colors.transparent,
              width: 1.0,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide(
              color: borderColor ?? Colors.transparent,
              width: 1.0,
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: const BorderSide(
              color: Colors.red,
              width: 1.0,
            ),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: const BorderSide(
              color: Colors.red,
              width: 1.0,
            ),
          ),
          errorStyle: AppTextStyle.normal.copyWith(
            fontSize: 12,
            color: Colors.red,
          ),
        ),
        style = style ??
            AppTextStyle.normal.copyWith(
              fontSize: 16,
              color: Colors.black,
            );

  AppInput.password({
    super.key,
    this.contentPadding = const EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
    this.controller,
    this.focusNode,
    this.keyboardType = TextInputType.text,
    this.obscureText = true,
    this.borderColor,
    this.onChanged,
    this.validator,
    this.formKey,
    TextStyle? style,
    this.autovalidateMode,
    this.height,
  })  : inputType = InputType.password,
        inputDecoration = InputDecoration(
          hintText: "Password",
          contentPadding: contentPadding,
          hintStyle: AppTextStyle.normal.copyWith(
            fontSize: 16,
            color: AppColors.grey,
          ),
          border: InputBorder.none,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide(
              color: borderColor ?? Colors.transparent,
              width: 1.0,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide(
              color: borderColor ?? Colors.transparent,
              width: 1.0,
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: const BorderSide(
              color: Colors.red,
              width: 1.0,
            ),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: const BorderSide(
              color: Colors.red,
              width: 1.0,
            ),
          ),
        ),
        style = style ??
            AppTextStyle.normal.copyWith(
              fontSize: 16,
              color: Colors.black,
            );

  AppInput.text({
    super.key,
    required String hintText,
    this.contentPadding = const EdgeInsets.symmetric(vertical: 0, horizontal: 20.0),
    this.controller,
    this.focusNode,
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
    this.borderColor,
    this.onChanged,
    this.validator,
    this.formKey,
    TextStyle? style,
    TextStyle? hintStyle,
    this.autovalidateMode,
    this.height,
  })  : inputDecoration = InputDecoration(
          hintText: hintText,
          hintStyle: hintStyle,
          border: InputBorder.none,
          contentPadding: contentPadding,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide(
              color: borderColor ?? Colors.transparent,
              width: 1.0,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide(
              color: borderColor ?? Colors.transparent,
              width: 1.0,
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: const BorderSide(
              color: Colors.red,
              width: 1.0,
            ),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: const BorderSide(
              color: Colors.red,
              width: 1.0,
            ),
          ),
        ),
        style = style ??
            AppTextStyle.normal.copyWith(
              fontSize: 15,
              color: Colors.black,
            );

  @override
  State<AppInput> createState() => _AppInputState();
}

class _AppInputState extends State<AppInput> {
  late final ValueNotifier<bool> obscureNotifier;
  late Widget child;

  @override
  void initState() {
    super.initState();
    obscureNotifier = ValueNotifier(widget.obscureText ?? false);
  }

  @override
  void dispose() {
    obscureNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    switch (widget.inputType) {
      case InputType.email:
        return _buildFormValidator();
      case InputType.password:
        if (widget.obscureText != null && widget.obscureText!) {
          if (widget.validator != null) {
            return _buildObscureValidator();
          } else {
            return _buildObscureNotifier();
          }
        } else {
          return _buildTextField();
        }
      case InputType.text:
        if(widget.validator != null){
          return _buildFormValidator();
        }
        return _buildTextField();
      default:
        return _buildTextField();
    }
  }

  Widget _buildTextField() {
    return SizedBox(
      height: widget.height,
      child: AppTextFormField(
        controller: widget.controller,
        focusNode: widget.focusNode,
        decoration: widget.inputDecoration,
        style: widget.style,
        validator: widget.validator,
        keyboardType: widget.keyboardType,
        obscureText: widget.obscureText ?? false,
        onChanged: widget.onChanged,
        contentPadding: widget.contentPadding,
      ),
    );
  }

  Widget _buildFormValidator() {
    return Form(
      key: widget.formKey,
      child: SizedBox(
        height: widget.height,
        child: AppTextFormField(
          controller: widget.controller,
          focusNode: widget.focusNode,
          decoration: widget.inputDecoration,
          style: widget.style,
          autovalidateMode: widget.autovalidateMode,
          validator: widget.validator,
          keyboardType: widget.keyboardType,
          obscureText: widget.obscureText ?? false,
          onChanged: widget.onChanged,
          contentPadding: widget.contentPadding,
        ),
      ),
    );
  }

  Widget _buildObscureValidator() {
    return Form(
      key: widget.formKey,
      child: ValueListenableBuilder<bool>(
          valueListenable: obscureNotifier,
          builder: (_, obscure, __) {
            return SizedBox(
              height: widget.height,
              child: AppTextFormField(
                controller: widget.controller,
                focusNode: widget.focusNode,
                decoration: widget.inputDecoration?.copyWith(
                  suffixIcon: IconButton(
                    onPressed: () => obscureNotifier.value = !obscure,
                    icon: Icon(
                      obscure ? CupertinoIcons.eye_slash : CupertinoIcons.eye,
                      color: Colors.black,
                    ),
                  ),
                ),
                style: AppTextStyle.normal.copyWith(
                  fontSize: 16,
                  color: Colors.black,
                ),
                validator: widget.validator,
                autovalidateMode: widget.autovalidateMode,
                keyboardType: widget.keyboardType,
                obscureText: obscure,
                onChanged: widget.onChanged,
                contentPadding: widget.contentPadding,
              ),
            );
          },
      ),
    );
  }

  Widget _buildObscureNotifier() {
    return ValueListenableBuilder<bool>(
      valueListenable: obscureNotifier,
      builder: (_, obscure, __) {
        return SizedBox(
          height: widget.height,
          child: AppTextFormField(
            controller: widget.controller,
            focusNode: widget.focusNode,
            decoration: widget.inputDecoration?.copyWith(
              suffixIcon: IconButton(
                onPressed: () => obscureNotifier.value = !obscure,
                icon: Icon(
                  obscure ? CupertinoIcons.eye_slash : CupertinoIcons.eye,
                  color: Colors.black,
                ),
              ),
            ),
            style: AppTextStyle.normal.copyWith(
              fontSize: 16,
              color: Colors.black,
            ),
            keyboardType: widget.keyboardType,
            obscureText: obscure,
            onChanged: widget.onChanged,
            contentPadding: widget.contentPadding,
          ),
        );
      },
    );
  }
}
