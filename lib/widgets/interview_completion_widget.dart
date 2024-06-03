import 'package:fithub_v1/providers/form_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class InterviewCompletionWidget extends StatelessWidget {
  const InterviewCompletionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final FormController formController = Get.find<FormController>();

    return Container(
      color: Colors.white,
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
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
              formController.printResponses();
              formController.nextQuestion();
            },
            child: const Text('Enviar'),
          ),
        ],
      ),
    );
  }
}



/* Primera version
class InterviewCompletionWidget extends StatelessWidget {
  const InterviewCompletionWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final FormController formController = Get.find<FormController>();

    return Container(
      color: Colors.white,
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
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
              formController.printResponses();
              formController.nextQuestion(); // Navigate to the ThankYouWidget
            },
            child: const Text('Enviar'),
          ),
        ],
      ),
    );
  }
}

*/