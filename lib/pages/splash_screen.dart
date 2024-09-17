import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_app/widgets/bottom_nav_bar.dart';

class CustomSplashScreen extends StatefulWidget {
  @override
  _CustomSplashScreenState createState() => _CustomSplashScreenState();
}

class _CustomSplashScreenState extends State<CustomSplashScreen> {
  bool _showFullName = false;

  @override
  void initState() {
    super.initState();

    // Exibe a letra F por 3 segundos
    Future.delayed(const Duration(seconds: 3), () {
      setState(() {
        _showFullName = true;
      });

      // Após mais 3 segundos, navega para a próxima tela
      Future.delayed(const Duration(seconds: 3), () {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const BottomNavBar()),
        );
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: AnimatedSwitcher(
          duration: const Duration(seconds: 1), // Controla a duração da transição
          child: _showFullName
              ? Text(
                  'FBFLIX',  // Exibe o nome completo
                  key: const ValueKey('fullName'),
                  style: GoogleFonts.anton(
                    color: Colors.yellowAccent,
                    fontSize: 100,
                    fontWeight: FontWeight.bold,
                  ),
                )
              : Text(
                  'F', // Exibe a letra inicial por 3 segundos
                  key: const ValueKey('initialLetter'),
                  style: GoogleFonts.anton(
                    color: Colors.yellowAccent,
                    fontSize: 100,
                    fontWeight: FontWeight.bold,
                  ),
                ),
        ),
      ),
    );
  }
}

