import 'package:flutter/material.dart';

class EditedTextFormField extends StatefulWidget {
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final String hintText;
  final TextInputType? textInputType;
  final bool? isPassword;

  const EditedTextFormField({
    super.key,
    required this.hintText,
    this.controller,
    this.validator,
    this.textInputType = TextInputType.text,
    this.isPassword = false,
  });

  @override
  State<EditedTextFormField> createState() => _EditedTextFormFieldState();
}

class _EditedTextFormFieldState extends State<EditedTextFormField> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: widget.textInputType,
      controller: widget.controller,
      validator: widget.validator,
      style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontSize: 14),
      obscureText:widget.isPassword! ? _obscureText : !_obscureText,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        hintText: widget.hintText,
        contentPadding: EdgeInsets.symmetric(horizontal: 16.0),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16.0),
        ),
        suffixIcon: widget.isPassword!
            ? IconButton(
                icon: Icon(
                  _obscureText ? Icons.visibility : Icons.visibility_off,
                  color: Colors.grey,
                ),
                onPressed: () {
                  setState(() {
                    _obscureText = !_obscureText;
                  });
                },
              )
            : null,
      ),
    );
  }
}
