import 'package:fithub_v1/models/training_info.dart';
import 'package:fithub_v1/providers/form_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PersonalizedTrainingFormWidget extends StatefulWidget {
  const PersonalizedTrainingFormWidget({super.key});

  @override
  _PersonalizedTrainingFormWidgetState createState() =>
      _PersonalizedTrainingFormWidgetState();
}

class _PersonalizedTrainingFormWidgetState
    extends State<PersonalizedTrainingFormWidget> {
  final _formKey = GlobalKey<FormState>();
  bool? _hasReceivedTraining;
  bool _isNextButtonEnabled = false;

  final formController = Get.find<FormController>();

  void _validateForm() {
    setState(() {
      _isNextButtonEnabled = _hasReceivedTraining != null;
    });
  }

  void _onNextPressed() {
    if (_formKey.currentState!.validate()) {
      final personalizedTrainingInfo = PersonalizedTrainingInfo(
        hasReceivedTraining: _hasReceivedTraining!,
        experienceDescription: '', // No se recopila aquí
      );
      formController.updatePersonalizedTrainingInfo(personalizedTrainingInfo);
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
              '¿Alguna vez has adquirido o recibido una rutina de entrenamiento personalizado en línea por un profesional o una persona certificada en área de la actividad física?',
              style: TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 20),
            RadioListTile<bool>(
              title: const Text('Sí'),
              value: true,
              groupValue: _hasReceivedTraining,
              onChanged: (value) {
                setState(() {
                  _hasReceivedTraining = value;
                });
                _validateForm();
              },
            ),
            RadioListTile<bool>(
              title: const Text('No'),
              value: false,
              groupValue: _hasReceivedTraining,
              onChanged: (value) {
                setState(() {
                  _hasReceivedTraining = value;
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




/*

import 'package:fithub_v1/models/training_info.dart';
import 'package:fithub_v1/providers/form_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class PersonalizedTrainingFormWidget extends StatefulWidget {
  const PersonalizedTrainingFormWidget({super.key});

  @override
  _PersonalizedTrainingFormState createState() =>
      _PersonalizedTrainingFormState();
}

class _PersonalizedTrainingFormState
    extends State<PersonalizedTrainingFormWidget> {
  final _formKey = GlobalKey<FormState>();
  bool? _hasReceivedTraining;
  String? _experienceDescription;
  bool _isNextButtonEnabled = false;

  final formController = Get.find<FormController>();

  void _validateForm() {
    setState(() {
      _isNextButtonEnabled = _hasReceivedTraining != null &&
          (_hasReceivedTraining == false ||
              (_hasReceivedTraining == true &&
                  _experienceDescription != null &&
                  _experienceDescription!.isNotEmpty));
    });
  }

  void _onNextPressed() {
    if (_formKey.currentState!.validate()) {
      final personalizedTrainingInfo = PersonalizedTrainingInfo(
        hasReceivedTraining: _hasReceivedTraining!,
        experienceDescription: _experienceDescription ?? '',
      );
      formController.updatePersonalizedTrainingInfo(personalizedTrainingInfo);
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
              '¿Alguna vez has adquirido o recibido una rutina de entrenamiento personalizado en línea por un profesional o una persona certificada en área de la actividad física?',
              style: TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 20),
            RadioListTile<bool>(
              title: const Text('Sí'),
              value: true,
              groupValue: _hasReceivedTraining,
              onChanged: (value) {
                setState(() {
                  _hasReceivedTraining = value;
                });
                _validateForm();
              },
            ),
            RadioListTile<bool>(
              title: const Text('No'),
              value: false,
              groupValue: _hasReceivedTraining,
              onChanged: (value) {
                setState(() {
                  _hasReceivedTraining = value;
                });
                _validateForm();
              },
            ),
            if (_hasReceivedTraining == true) ...[
              const SizedBox(height: 20),
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
            ],
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

*/