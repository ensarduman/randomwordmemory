import 'package:flutter/material.dart';

class CustomTextField extends StatefulWidget {
  final String placeHolder;
  final bool obscureText;
  final String initialText;
  final Function(String value) onChanged;
  final TextEditingController controller;

  const CustomTextField({this.placeHolder, this.obscureText = false, this.onChanged, this.initialText, this.controller});

  @override
  _CustomTextFieldState createState() => _CustomTextFieldState(this.onChanged);
}

class _CustomTextFieldState extends State<CustomTextField> {
  final Function(String value) onChanged;

  _CustomTextFieldState(this.onChanged);

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: (value) {
        if (onChanged != null) {
          this.onChanged(value);
        }
      },
      controller: widget.controller,
      obscureText: widget.obscureText,
      enableSuggestions: !widget.obscureText,
      autocorrect: !widget.obscureText,
      decoration: InputDecoration(
        hintText: widget.placeHolder != null ? widget.placeHolder : '',
      ),
    );
  }
}
