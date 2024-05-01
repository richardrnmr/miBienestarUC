import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mi_bienestar_uc/models/hospital.dart';
import 'package:mi_bienestar_uc/models/user_patient.dart';
import 'package:mi_bienestar_uc/pages/home_page.dart';
import 'package:mi_bienestar_uc/pages/login_page.dart';

class FirebaseHelper {
  static Future<void> signInWithEmailAndPassword({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      // Navega a la pantalla HomePage si la autenticación es exitosa
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => HomePage(userId: userCredential.user!.uid),
        ),
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
    required String name,
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
        'name': name,
        'age': age,
        'gender': gender,
        'id': userCredential.user!.uid,
      });

      // Navegar a la pantalla HomePage si el registro es exitoso
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => HomePage(userId: userCredential.user!.uid),
        ),
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

  static Future<bool> checkAuth() async {
    FirebaseAuth _auth = FirebaseAuth.instance;
    User? user = _auth.currentUser;
    return user != null;
  }

  static Future<void> signOut(BuildContext context) async {
    try {
      await FirebaseAuth.instance.signOut();
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginPage()),
      );
    } catch (e) {
      print('Error al cerrar sesión: $e');
    }
  }

  static Future<UserPatient?> getUserData(String id) async {
    CollectionReference users = FirebaseFirestore.instance.collection('users');

    QuerySnapshot querySnapshot = await users.where('id', isEqualTo: id).get();

    // Si no se encuentra ningún documento, devuelve null
    if (querySnapshot.docs.isEmpty) {
      return null;
    }

    // Si se encuentra un documento, devuelve el primer documento encontrado
    var doc = querySnapshot.docs.first;

    return UserPatient(
      email: doc['email'],
      name: doc['name'],
      id: doc['id'],
      gender: doc['gender'],
      age: doc['age'],
    );
  }

  static Future<List<Hospital>> obtenerHospitales() async {
    try {
      // Obtener una referencia a la colección 'hospitals'
      CollectionReference hospitals =
          FirebaseFirestore.instance.collection('hospitals');

      // Obtener todos los documentos de la colección
      QuerySnapshot querySnapshot = await hospitals.get();

      // Convertir los documentos en objetos Hospital y almacenarlos en una lista
      List<Hospital> listaHospitales = querySnapshot.docs.map((doc) {
        return Hospital(
          name: doc['name'],
          address: doc['address'],
          phone: doc['phone'],
        );
      }).toList();

      return listaHospitales;
    } catch (e) {
      // Manejar errores
      print('Error al obtener los hospitales: $e');
      return []; // Devolver una lista vacía en caso de error
    }
  }
}
