import 'package:fithub_v1/providers/form_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PersonalizedTrainingExperienceFormWidget extends StatefulWidget {
  const PersonalizedTrainingExperienceFormWidget({super.key});

  @override
  _PersonalizedTrainingExperienceFormState createState() =>
      _PersonalizedTrainingExperienceFormState();
}

class _PersonalizedTrainingExperienceFormState
    extends State<PersonalizedTrainingExperienceFormWidget> {
  final _formKey = GlobalKey<FormState>();
  String? _experienceDescription;
  bool _isNextButtonEnabled = false;

  final formController = Get.find<FormController>();

  void _validateForm() {
    setState(() {
      _isNextButtonEnabled =
          _experienceDescription != null && _experienceDescription!.isNotEmpty;
    });
  }

  void _onNextPressed() {
    if (_formKey.currentState!.validate()) {
      formController
          .updatePersonalizedTrainingExperience(_experienceDescription!);
      formController.nextQuestion();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Container(
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Compártenos tu experiencia pasada, ¿cómo te enteraste de esa opción, qué te gustó, qué no te gustó, cómo podríamos hacerlo mejor nosotros?',
              style: TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 20),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Tu experiencia',
                border: OutlineInputBorder(),
              ),
              maxLines: 4,
              onChanged: (value) {
                setState(() {
                  _experienceDescription = value;
                });
                _validateForm();
              },
            ),
            const SizedBox(height: 30),
            IconButton(
              icon: const Icon(Icons.arrow_forward),
              onPressed: _isNextButtonEnabled ? _onNextPressed : null,
              iconSize: 50,
              color: _isNextButtonEnabled ? Colors.blue : Colors.grey,
            ),
          ],
        ),
      ),
    );
  }
}
