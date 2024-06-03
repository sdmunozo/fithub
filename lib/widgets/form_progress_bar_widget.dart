import 'package:fithub_v1/providers/form_controller.dart';
import 'package:flutter/material.dart';

class FormProgressBarWidget extends StatelessWidget {
  const FormProgressBarWidget({
    super.key,
    required this.formController,
  });

  final FormController formController;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: double.infinity,
          height: 20,
          decoration: BoxDecoration(
            color: Colors.grey[300],
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        AnimatedContainer(
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
          width: (MediaQuery.of(context).size.width - 32) *
              (formController.currentQuestionIndex.value /
                  (formController.totalQuestions - 1)),
          height: 20,
          decoration: BoxDecoration(
            color: Colors.blue,
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ],
    );
  }
}
