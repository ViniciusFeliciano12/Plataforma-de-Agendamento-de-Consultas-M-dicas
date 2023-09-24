import 'package:flutter/material.dart';
import 'package:hospital_gamificacao/view/HomePage.dart';
import 'package:hospital_gamificacao/view/especialidade_page.dart';
import 'package:hospital_gamificacao/view/recepcionista_page.dart';

class TopNavigationBar extends StatelessWidget {
  final int selectedIndex;

  const TopNavigationBar({super.key, required this.selectedIndex});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blue, // Cor de fundo azul da Row
      padding: const EdgeInsets.all(16.0), // Espaçamento interno
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          ElevatedButton(
            onPressed: () {
              if (selectedIndex == 1) {
                return;
              }
              Navigator.pushReplacement(
                context,
                PageRouteBuilder(
                  pageBuilder: (context, animation, secondaryAnimation) =>
                      const MyHomePage(),
                  transitionsBuilder:
                      (context, animation, secondaryAnimation, child) {
                    var begin = const Offset(1.0, 0.0);
                    var end = Offset.zero;
                    var curve = Curves.ease;

                    var tween = Tween(begin: begin, end: end)
                        .chain(CurveTween(curve: curve));

                    return SlideTransition(
                      position: animation.drive(tween),
                      child: child,
                    );
                  },
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white, // Cor de fundo do botão
              foregroundColor: Colors.blue, // Cor do texto do botão
              shape: RoundedRectangleBorder(
                borderRadius:
                    BorderRadius.circular(12.0), // Corner radius de 12
              ),
            ),
            child: const Text("Home Page"),
          ),
          ElevatedButton(
            onPressed: () {
              if (selectedIndex == 2) {
                return;
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white, // Cor de fundo do botão
              foregroundColor: Colors.blue, // Cor do texto do botão
              shape: RoundedRectangleBorder(
                borderRadius:
                    BorderRadius.circular(12.0), // Corner radius de 12
              ),
            ),
            child: const Text("Medicos Page"),
          ),
          ElevatedButton(
            onPressed: () {
              if (selectedIndex == 3) {
                return;
              }
              Navigator.pushReplacement(
                context,
                PageRouteBuilder(
                  pageBuilder: (context, animation, secondaryAnimation) =>
                      const RecepcionistaPage(),
                  transitionsBuilder:
                      (context, animation, secondaryAnimation, child) {
                    var begin = const Offset(1.0, 0.0);
                    var end = Offset.zero;
                    var curve = Curves.ease;

                    var tween = Tween(begin: begin, end: end)
                        .chain(CurveTween(curve: curve));

                    return SlideTransition(
                      position: animation.drive(tween),
                      child: child,
                    );
                  },
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              foregroundColor: Colors.blue,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
            ),
            child: const Text("Recepcionistas Page"),
          ),
          ElevatedButton(
            onPressed: () {
              if (selectedIndex == 4) {
                return;
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              foregroundColor: Colors.blue,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
            ),
            child: const Text("Paciente Page"),
          ),
          ElevatedButton(
            onPressed: () {
              if (selectedIndex == 5) {
                return;
              }
              Navigator.pushReplacement(
                context,
                PageRouteBuilder(
                  pageBuilder: (context, animation, secondaryAnimation) =>
                      const EspecialidadePage(),
                  transitionsBuilder:
                      (context, animation, secondaryAnimation, child) {
                    var begin = const Offset(1.0, 0.0);
                    var end = Offset.zero;
                    var curve = Curves.ease;

                    var tween = Tween(begin: begin, end: end)
                        .chain(CurveTween(curve: curve));

                    return SlideTransition(
                      position: animation.drive(tween),
                      child: child,
                    );
                  },
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              foregroundColor: Colors.blue,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
            ),
            child: const Text("Especialidade Page"),
          ),
          ElevatedButton(
            onPressed: () {
              if (selectedIndex == 6) {
                return;
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              foregroundColor: Colors.blue,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
            ),
            child: const Text("Consulta Page"),
          ),
        ],
      ),
    );
  }
}
