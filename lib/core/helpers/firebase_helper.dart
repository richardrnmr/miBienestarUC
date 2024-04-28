import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mi_bienestar_uc/pages/home_page.dart';

class FirebaseHelper {
  static Future<void> signInWithEmailAndPassword({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      // Navega a la pantalla HomePage si la autenticación es exitosa
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),
        (route) => false,
      );
    } catch (e) {
      // Muestra un cuadro de diálogo con el mensaje de error
      print('Error de autenticación: $e');
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Error de autenticación'),
            content: Text('Usuario o contraseña incorrectos.'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('Cerrar'),
              ),
            ],
          );
        },
      );
    }
  }

  static Future<void> registerWithEmailAndPassword({
    required String email,
    required String password,
    required int id,
    required int age,
    required String gender,
    required BuildContext context,
  }) async {
    try {
      // Registro en Firebase Authentication
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);

      // Guardar datos adicionales en Firestore
      FirebaseFirestore firestore = FirebaseFirestore.instance;
      await firestore.collection('users').doc(userCredential.user!.uid).set({
        'email': email,
        'id': id,
        'age': age,
        'gender': gender,
      });

      // Navegar a la pantalla HomePage si el registro es exitoso
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),
        (route) => false,
      );
    } catch (e) {
      print('Error de registro: $e');
      if (e is FirebaseAuthException) {
        if (e.code == 'email-already-in-use') {
          // Mostrar un mensaje indicando que el usuario ya está registrado
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('Error de registro'),
                content: Text(
                    'El correo electrónico ya ha sido registrado anteriormente.'),
                actions: <Widget>[
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text('Cerrar'),
                  ),
                ],
              );
            },
          );
          return; // Salir del método después de mostrar el diálogo
        }
      }

      // Mostrar un mensaje de error genérico si no se puede determinar la causa exacta del error
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Error de registro'),
            content: Text(
                'Hubo un error durante el registro. Por favor, inténtalo de nuevo más tarde.'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('Cerrar'),
              ),
            ],
          );
        },
      );
    }
  }
}
