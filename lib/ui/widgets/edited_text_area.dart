import 'package:flutter/material.dart';

class EditedTextArea extends StatefulWidget {
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final String hintText;
  final TextInputType? textInputType;
  final Color colorbside;
  final bool enableText;
  final FocusNode? focusNode;
  final int? minLines;

  EditedTextArea({
    Key? key,
    required this.hintText,
    required this.enableText,
    this.controller,
    this.validator,
    this.focusNode,
    this.minLines = 1,
    required this.colorbside,
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
      minLines: widget.minLines,
      focusNode: widget.focusNode,
      maxLines: null,
      enabled: widget.enableText,
      style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontSize: 14),
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
              color: widget
                  .colorbside), // Cambia el color del borde al tener el foco
          borderRadius: BorderRadius.circular(16.0),
        ),
      ),
      autofillHints: [],
      enableSuggestions: false,
    );
  }
}
