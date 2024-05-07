import 'package:flutter/material.dart';

class CustomShowDialog extends StatelessWidget {
  final String message;
  final String title;
  final Function? onAccept;
  final Function? onCancel;

  const CustomShowDialog({
    super.key,
    required this.message,
    required this.title,
    this.onAccept,
    this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      backgroundColor: Colors.white,
      elevation: 400,
      surfaceTintColor: Colors.white,
      shadowColor: Colors.green,
      content: Text(message),
      actions: <Widget>[
        if (onCancel != null)
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              if (onCancel != null) onCancel!();
            },
            child: const Text('Cancelar'),
          ),
        if (onAccept != null)
          TextButton(
            onPressed: () {
              if (onAccept != null) onAccept!();
            },
            child: const Text('Aceptar'),
          ),
      ],
    );
  }
}

// Función para mostrar el diálogo
void showCustomDialog({
  required BuildContext context,
  required String message,
  required String title,
  Function? onAccept,
  Function? onCancel,
}) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return CustomShowDialog(
        title: title,
        message: message,
        onAccept: onAccept,
        onCancel: onCancel,
      );
    },
  );
}
