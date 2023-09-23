import 'package:flutter/material.dart';

class ReuseableTextField extends StatelessWidget {
  const ReuseableTextField({
    Key? key,
    required this.hintTextString,
    required this.textEditController,
    required this.inputType,
    this.enableBorder = true,
    this.themeColor,
    this.cornerRadius,
    this.maxLength,
    this.prefixIcon,
    this.textColor,
    this.errorMessage,
    this.labelText,
  }) : super(key: key);

  final String hintTextString;
  final TextEditingController textEditController;
  final TextInputType inputType;
  final bool enableBorder;
  final Color? themeColor;
  final double? cornerRadius;
  final int? maxLength;
  final Widget? prefixIcon;
  final Color? textColor;
  final String? errorMessage;
  final String? labelText;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: textEditController,
      keyboardType: inputType,
      maxLength: maxLength,
      style: TextStyle(color: textColor ?? Colors.black), // Default text color
      obscureText: inputType == TextInputType.visiblePassword,
      decoration: InputDecoration(
        hintText: hintTextString,
        labelText: labelText,
        prefixIcon: prefixIcon,
        counterText: '',
        errorText: errorMessage,
        enabledBorder: enableBorder
            ? OutlineInputBorder(
                borderRadius: BorderRadius.circular(cornerRadius ?? 8.0),
                borderSide: BorderSide(color: themeColor ?? Colors.grey),
              )
            : InputBorder.none,
        focusedBorder: enableBorder
            ? OutlineInputBorder(
                borderRadius: BorderRadius.circular(cornerRadius ?? 8.0),
                borderSide: BorderSide(color: themeColor ?? Colors.blue),
              )
            : InputBorder.none,
      ),
    );
  }
}
