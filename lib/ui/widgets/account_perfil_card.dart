// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:mi_bienestar_uc/core/helpers/firebase_helper.dart';
import 'package:mi_bienestar_uc/models/user_patient.dart';
import 'package:mi_bienestar_uc/pages/perfil_page.dart';

class AccountPerfilCard extends StatefulWidget {
  final String userId;

  const AccountPerfilCard({
    required this.userId,
    super.key,
  });

  @override
  _AccountPerfilCardState createState() => _AccountPerfilCardState();
}

class _AccountPerfilCardState extends State<AccountPerfilCard> {
  UserPatient? userPatient;
  String gender = 'Masculino';

  @override
  void initState() {
    super.initState();
    // Llamada a la función para obtener los datos del usuario
    _getUserData();
  }

  Future<void> _getUserData() async {
    // Espera a que el Future se complete y luego asigna el resultado a userPatient
    userPatient = await FirebaseHelper.getUserData(widget.userId);
    gender = userPatient!.gender;
    // Actualiza el estado para reflejar los cambios
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    // Widget con los datos del usuario
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PerfilPage(
              userPatient: userPatient!,
            ),
          ),
        );
      },
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        color: Colors.white,
        elevation: 2,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              getProfileIcon(gender),
              const SizedBox(width: 16),
              Text(
                // Utiliza los datos del usuario para mostrar el saludo
                userPatient != null
                    ? 'Hola ${getFirstName(userPatient!.name)}! 👋' // Utiliza el nombre si está disponible, de lo contrario, utiliza el correo electrónico
                    : '...', // Muestra "Cargando..." mientras se obtienen los datos del usuario
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge!
                    .copyWith(fontSize: 14),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String getFirstName(String nombreCompleto) {
    List<String> partesNombre = nombreCompleto.split(" ");
    return partesNombre.first;
  }

  Widget getProfileIcon(String gender) {
    switch (gender) {
      case 'Masculino':
        return const CircleAvatar(
          radius: 16,
          backgroundImage: AssetImage('assets/man_perfil.png'),
        );
      case 'Femenino':
        return const CircleAvatar(
          radius: 16,
          backgroundImage: AssetImage('assets/woman_perfil.png'),
        );
      case 'Otro':
        return const CircleAvatar(
          backgroundColor: Colors.blue,
          radius: 16,
        );
      default:
        return const CircleAvatar(
          backgroundColor: Colors.blue,
          radius: 16,
        );
    }
  }
}
