import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:mi_bienestar_uc/ui/general/colors.dart';

class InstructionsPage extends StatelessWidget {
  InstructionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Text(
                'INSTRUCCIONES',
                style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                      fontSize: 46,
                    ),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                  color: AppColor.yellowPastelColor,
                  borderRadius:
                      BorderRadius.only(bottomRight: Radius.circular(124))),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('PARA DESCRIBIR TUS SÍNTOMAS',
                        style: Theme.of(context)
                            .textTheme
                            .headlineLarge
                            ?.copyWith(fontSize: 24)),
                    SizedBox(height: 16),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 36),
                      child: Text(
                          'Escribe el síntoma que deseas describir en el campo de texto proporcionado.\nHaz tap en el botón "Buscar Resultados" una vez que hayas agregado todos tus síntomas.\nRevisa los resultados encontrados que se muestran en la pantalla.\nSi es necesario, puedes seguir editando tu lista de síntomas antes de realizar otra búsqueda.',
                          textAlign: TextAlign.justify,
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge
                              ?.copyWith(fontSize: 16)),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                  color: AppColor.skyPastelColor,
                  borderRadius:
                      BorderRadius.only(topLeft: Radius.circular(124))),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text('PARA BUSCAR RECETAS\nY TRATAMIENTOS',
                        textAlign: TextAlign.right,
                        style: Theme.of(context)
                            .textTheme
                            .headlineLarge
                            ?.copyWith(fontSize: 24)),
                    SizedBox(height: 16),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 36),
                      child: Text(
                          'Simplemente escribe en el buscador la receta o tratamiento que deseas buscar y... ¡listo!.',
                          textAlign: TextAlign.right,
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge
                              ?.copyWith(fontSize: 16)),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                  color: AppColor.greenPastelColor,
                  borderRadius:
                      BorderRadius.only(bottomRight: Radius.circular(124))),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('¡RECUERDA!',
                        style: Theme.of(context)
                            .textTheme
                            .headlineLarge
                            ?.copyWith(fontSize: 24)),
                    SizedBox(height: 16),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 36),
                      child: Text(
                          'Tu salud es invaluable. Si los síntomas que experimentas persisten, o son de gravedad, no dudes en buscar atención médica de inmediato en el centro de salud más cercano.\nCuida de ti mismo y no subestimes la importancia de tu bienestar :) .',
                          textAlign: TextAlign.justify,
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge
                              ?.copyWith(fontSize: 16)),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Lottie.asset('assets/robotAnimation.json', width: 200),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          style: ElevatedButton.styleFrom(
                            shape: CircleBorder(), // Botón circular
                            padding:
                                EdgeInsets.all(16), // Padding para el botón
                            backgroundColor: AppColor
                                .blackparcialColor, // Color de fondo negro
                          ),
                          child: Icon(
                            Icons.arrow_back, // Icono de flecha hacia abajo
                            color: Colors.white, // Color del icono blanco
                            size: 24, // Tamaño del icono
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      )),
    );
  }
}
