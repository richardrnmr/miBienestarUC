import 'package:email_validator/email_validator.dart';

class PersonalizedValidators {
  
  static String? email(String? value) {
    if (value == null || value.isEmpty) {
      return 'Este campo es requerido';
    }
    if (!EmailValidator.validate(value)) {
      return 'Ingrese un correo electrónico válido';
    }
    return null;
  }

  static String? text(String? value) {
    if (value == null || value.isEmpty) {
      return 'Este campo es requerido';
    }
    return null;
  }

  static String? number(String? value) {
    if (value == null || value.isEmpty) {
      return 'Este campo es requerido';
    }

    // Verificar si el valor contiene algún carácter que no sea un dígito
    if (value.contains(RegExp(r'[^\d]'))) {
      return 'Ingrese solo enteros';
    }

    return null;
  }

  static String? age(String? value) {
  if (value == null || value.isEmpty) {
    return 'Edad requerida';
  }
  final age = int.tryParse(value);
  if (age == null || age < 10 || age > 99) {
    return 'Edad entre 10 y 99 años';
  }
  return null; // No hay errores de validación
}

  static String? password(String? value) {
    if (value == null || value.isEmpty) {
      return 'Este campo es requerido';
    }
    if (value.length < 6) {
      return 'La contraseña debe tener al menos 6 caracteres';
    }
    return null;
  }

  static String? passwordsMatch(String? password, String? confirmPassword) {
    if (password == null || password.isEmpty) {
      return 'Este campo es requerido';
    }
    if (password != confirmPassword) {
      return 'Las contraseñas no coinciden';
    }
    return null;
  }

  static String? dropdownValue(dynamic value) {
    if (value == 'Genero') {
      return 'Elija una opción';
    }
    return null;
  }
}
