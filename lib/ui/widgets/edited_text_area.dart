import 'package:flutter/material.dart';

class EditedTextArea extends StatefulWidget {
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final String hintText;
  final TextInputType? textInputType;
  final bool enableText;

  const EditedTextArea({
    Key? key,
    required this.hintText,
    required this.enableText,
    this.controller,
    this.validator,
    this.textInputType = TextInputType.multiline,
  }) : super(key: key);

  @override
  State<EditedTextArea> createState() => _EditedTextAreaState();
}

class _EditedTextAreaState extends State<EditedTextArea> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: widget.textInputType,
      controller: widget.controller,
      validator: widget.validator,
      maxLines: null,
      enabled: widget.enableText,
      style: Theme.of(context)
          .textTheme
          .bodyLarge
          ?.copyWith(fontSize: 14),
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        hintText: widget.hintText,
        contentPadding: EdgeInsets.symmetric(
            horizontal: 16.0, vertical: 12.0), // Aumenté el relleno vertical
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
              color: Color(
                  0xFFD6C731)), // Cambia el color del borde al tener el foco
          borderRadius: BorderRadius.circular(16.0),
        ),
      ),
      autofillHints: [],
      enableSuggestions: false,
    );
  }
}
