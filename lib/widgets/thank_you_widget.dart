import 'package:fithub_v1/widgets/responses_modal_widget.dart';
import 'package:flutter/material.dart';

class ThankYouWidget extends StatelessWidget {
  const ThankYouWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 20),
          const Text(
            '¡Gracias por completar la encuesta, te contactaremos en 24hrs por WhatsApp!',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.blue,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.white,
              backgroundColor: Colors.blue,
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
              textStyle: const TextStyle(fontSize: 18),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => const ResponsesModal(),
              );
            },
            child: const Text('Ver Respuestas'),
          ),
        ],
      ),
    );
  }
}







/* Primera version: Antes de estandarizacion

class ThankYouWidget extends StatelessWidget {
  const ThankYouWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 20),
          const Text(
            '¡Gracias por completar la encuesta, te contactaremos en 24hrs por WhatsApp!',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.blue,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => const ResponsesModalWidget(),
              );
            },
            child: const Text('Ver Respuestas'),
          ),
        ],
      ),
    );
  }
}

*/