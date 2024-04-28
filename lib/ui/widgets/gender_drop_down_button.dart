import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class GenderDropDown extends StatelessWidget {
  final String? Function(String?)? validator;
  final String genderController;

  const GenderDropDown({
    Key? key,
    required this.genderController,
    required this.validator,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16.0),
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 16.0),
      ),
      value: genderController,
      validator: validator,
      icon: const Icon(Icons.arrow_drop_down),
      style: Theme.of(context).textTheme.bodyText1?.copyWith(fontSize: 14),
      items: [
        DropdownMenuItem(
          child: Text('Genero'),
          value: 'Genero',
        ),
        DropdownMenuItem(
          child: Text('Masculino'),
          value: 'Masculino',
        ),
        DropdownMenuItem(
          child: Text('Femenino'),
          value: 'Femenino',
        ),
        DropdownMenuItem(
          child: Text('Otro'),
          value: 'Otro',
        ),
      ],
      onChanged: (value) {
        // No puedes actualizar genderController directamente en un widget Stateless
        // Deberías manejar esta lógica fuera del widget
      },
    );
  }
}
