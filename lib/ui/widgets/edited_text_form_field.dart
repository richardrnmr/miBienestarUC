import 'package:flutter/material.dart';
import 'package:mi_bienestar_uc/ui/general/colors.dart';

class EditedTextFormField extends StatefulWidget {
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final String hintText;
  final TextInputType? textInputType;
  final bool? isPassword;
  final FocusNode? focusNode;

  const EditedTextFormField({
    super.key,
    required this.hintText,
    this.controller,
    this.validator,
    this.focusNode,
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
      focusNode: widget.focusNode,
      keyboardType: widget.textInputType,
      controller: widget.controller,
      validator: widget.validator,
      style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontSize: 14),
      obscureText: widget.isPassword! ? _obscureText : !_obscureText,
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
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
              color: AppColor
                  .skyblueColor), // Cambia el color del borde al tener el foco
          borderRadius: BorderRadius.circular(16.0),
        ),
      ),
    );
  }
}
