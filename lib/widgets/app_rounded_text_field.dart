import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppRoundedTextField extends StatelessWidget {
  final String label, hintText;
  final Function(String) onChanged;
  final TextInputType textInputType;
  final String? Function(String?)? validator;
  final bool? obsureText, readOnly;
  final Function()? onTap;
  final TextEditingController? controller;
  final List<TextInputFormatter> formatters;
  final int? maxLength, maxLines;
  final EdgeInsetsGeometry? contentPadding;
  final IconData? prefixIconData;
  final double? radius;
  final Function()? onTapShowPassVisibility;
  AppRoundedTextField(
      {required this.label,
      required this.onChanged,
      required this.hintText,
      this.textInputType = TextInputType.text,
      this.validator,
      this.onTap,
      this.controller,
      this.maxLines,
      this.onTapShowPassVisibility,
      this.contentPadding,
      this.prefixIconData,
      this.formatters = const [],
      this.obsureText = false,
      this.maxLength,
      this.radius,
      this.readOnly = false});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: onChanged,
      keyboardType: textInputType,
      validator: validator,
      controller: controller,
      obscureText: obsureText ?? false,
      readOnly: readOnly ?? false,
      onTap: onTap,
      maxLines: maxLines ?? 1,
      maxLength: maxLength,
      inputFormatters: formatters,
      //textCapitalization: TextCapitalization.characters,
      decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(radius ?? 10.0),
          ),
          prefixIcon: prefixIconData != null ? Icon(prefixIconData) : null,
          filled: true,
          label: Text(
            label,
          ),
          suffixIcon: onTapShowPassVisibility != null
              ? GestureDetector(
                  onTap: onTapShowPassVisibility,
                  child: Icon(
                      obsureText! ? Icons.visibility_off : Icons.visibility))
              : SizedBox(),
          alignLabelWithHint: true,
          contentPadding: contentPadding,
          hintStyle: TextStyle(color: Colors.grey[800]),
          hintText: hintText,
          fillColor: Colors.white70),
    );
  }
}
