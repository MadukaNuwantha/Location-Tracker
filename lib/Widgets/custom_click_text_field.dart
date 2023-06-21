import 'package:flutter/material.dart';

class CustomClickTextField extends StatelessWidget {
  final TextEditingController controller;
  final String? hintText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final bool obscureText;
  final bool validateText;
  final ValueChanged<String>? onChanged;
  final VoidCallback voidCallback;

  const CustomClickTextField({
    Key? key,
    required this.controller,
    this.hintText,
    this.prefixIcon,
    this.suffixIcon,
    this.obscureText = false,
    this.validateText = true,
    this.onChanged,
    required this.voidCallback,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black54.withOpacity(0.1), width: 1),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 1,
            offset: const Offset(0, 2), // changes position of shadow
          ),
        ],
      ),
      child: TextFormField(
        controller: controller,
        readOnly: true,
        decoration: InputDecoration(
          hintText: hintText,
          prefixIcon: prefixIcon,
          suffixIcon: suffixIcon,
          fillColor: Colors.white,
          filled: true,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(
              color: Colors.white54,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(
              color: Colors.white54,
              width: 1,
            ),
          ),
          label: validateText
              ? Row(
                  children: <Widget>[
                    Text(hintText!),
                    const Text(
                      '*',
                      style: TextStyle(
                        color: Colors.red,
                      ),
                    ),
                  ],
                )
              : Row(
                  children: <Widget>[
                    Text(hintText!),
                  ],
                ),
          labelStyle: TextStyle(
            color: Colors.black54.withOpacity(0.5), // original label color
          ),
        ),
        validator: (value) {
          if (validateText && value!.trim().isEmpty) {
            return 'Please fill this field to continue';
          }
          return null;
        },
        obscureText: obscureText,
        onChanged: onChanged,
        onTap: voidCallback,
      ),
    );
  }
}
