import 'package:flutter/material.dart';

class LoginRegBackground extends StatelessWidget {
  const LoginRegBackground({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color.fromARGB(255, 128, 128, 255),
            Color.fromARGB(255, 230, 0, 172),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          stops: [0, 1],
        ),
      ),
    );
  }
}
