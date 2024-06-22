import 'package:fithub_v1/models/training_info.dart';
import 'package:fithub_v1/providers/form_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TrainingAppFormWidget extends StatefulWidget {
  const TrainingAppFormWidget({super.key});

  @override
  _TrainingAppFormWidgetState createState() => _TrainingAppFormWidgetState();
}

class _TrainingAppFormWidgetState extends State<TrainingAppFormWidget> {
  final _formKey = GlobalKey<FormState>();
  bool? _hasReceivedTrainingFromApp;
  bool _isNextButtonEnabled = false;

  final formController = Get.find<FormController>();

  void _validateForm() {
    setState(() {
      _isNextButtonEnabled = _hasReceivedTrainingFromApp != null;
    });
  }

  void _onNextPressed() {
    if (_formKey.currentState!.validate()) {
      final appTrainingInfo = AppTrainingInfo(
        hasReceivedTrainingFromApp: _hasReceivedTrainingFromApp!,
        experienceDescription: '', // No se recopila aquí
      );
      formController.updateAppTrainingInfo(appTrainingInfo);
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
              '¿Alguna vez has adquirido o recibido una rutina de entrenamiento personalizada por medio de alguna app, página o empresa de entrenamiento deportivo?',
              style: TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 20),
            RadioListTile<bool>(
              title: const Text('Sí'),
              value: true,
              groupValue: _hasReceivedTrainingFromApp,
              onChanged: (value) {
                setState(() {
                  _hasReceivedTrainingFromApp = value;
                });
                _validateForm();
              },
            ),
            RadioListTile<bool>(
              title: const Text('No'),
              value: false,
              groupValue: _hasReceivedTrainingFromApp,
              onChanged: (value) {
                setState(() {
                  _hasReceivedTrainingFromApp = value;
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
class TrainingAppFormWidget extends StatefulWidget {
  const TrainingAppFormWidget({super.key});

  @override
  _TrainingAppFormWidgetState createState() => _TrainingAppFormWidgetState();
}

class _TrainingAppFormWidgetState extends State<TrainingAppFormWidget> {
  final _formKey = GlobalKey<FormState>();
  bool? _hasReceivedTrainingFromApp;
  bool _isNextButtonEnabled = false;

  final formController = Get.find<FormController>();

  void _validateForm() {
    setState(() {
      _isNextButtonEnabled = _hasReceivedTrainingFromApp != null;
    });
  }

  void _onNextPressed() {
    if (_formKey.currentState!.validate()) {
      final appTrainingInfo = AppTrainingInfo(
        hasReceivedTrainingFromApp: _hasReceivedTrainingFromApp!,
        experienceDescription: '', // No se recopila aquí
      );
      formController.updateAppTrainingInfo(appTrainingInfo);
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
              '¿Alguna vez has adquirido o recibido una rutina de entrenamiento personalizada por medio de alguna app, página o empresa de entrenamiento deportivo?',
              style: TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 20),
            RadioListTile<bool>(
              title: const Text('Sí'),
              value: true,
              groupValue: _hasReceivedTrainingFromApp,
              onChanged: (value) {
                setState(() {
                  _hasReceivedTrainingFromApp = value;
                });
                _validateForm();
              },
            ),
            RadioListTile<bool>(
              title: const Text('No'),
              value: false,
              groupValue: _hasReceivedTrainingFromApp,
              onChanged: (value) {
                setState(() {
                  _hasReceivedTrainingFromApp = value;
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

*/
/*import 'package:fithub_v1/models/app_training_info.dart';
import 'package:fithub_v1/providers/form_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TrainingAppFormWidget extends StatefulWidget {
  const TrainingAppFormWidget({super.key});

  @override
  _TrainingAppFormWidgetState createState() => _TrainingAppFormWidgetState();
}

class _TrainingAppFormWidgetState extends State<TrainingAppFormWidget> {
  final _formKey = GlobalKey<FormState>();
  bool? _hasReceivedTrainingFromApp;
  bool _isNextButtonEnabled = false;

  final formController = Get.find<FormController>();

  void _validateForm() {
    setState(() {
      _isNextButtonEnabled = _hasReceivedTrainingFromApp != null;
    });
  }

  void _onNextPressed() {
    if (_formKey.currentState!.validate()) {
      final trainingAppInfo = AppTrainingInfo(
        hasReceivedTrainingFromApp: _hasReceivedTrainingFromApp!,
        experienceDescription: '', // No se recopila aquí
      );
      formController.updateTrainingAppInfo(trainingAppInfo);
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
              '¿Alguna vez has adquirido o recibido una rutina de entrenamiento personalizada por medio de alguna app, página o empresa de entrenamiento deportivo?',
              style: TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 20),
            RadioListTile<bool>(
              title: const Text('Sí'),
              value: true,
              groupValue: _hasReceivedTrainingFromApp,
              onChanged: (value) {
                setState(() {
                  _hasReceivedTrainingFromApp = value;
                });
                _validateForm();
              },
            ),
            RadioListTile<bool>(
              title: const Text('No'),
              value: false,
              groupValue: _hasReceivedTrainingFromApp,
              onChanged: (value) {
                setState(() {
                  _hasReceivedTrainingFromApp = value;
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


*/