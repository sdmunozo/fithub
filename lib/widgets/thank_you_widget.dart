import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class ThankYouWidget extends StatelessWidget {
  const ThankYouWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 20),
          Text(
            '¡Gracias por completar la encuesta, te contactaremos en 24hrs por WhatsApp!',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.blue,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}

/*
class ThankYouWidget extends StatelessWidget {
  const ThankYouWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/images/form/undraw_Timeline_re_aw6g.png'),
            const SizedBox(height: 20),
            Text(
              '¡Gracias por completar la entrevista!',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            //Lottie.asset('assets/animations/thank_you_animation.json'),
          ],
        ),
      ),
    );
  }
}
*/