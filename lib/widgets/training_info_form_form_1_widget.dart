import 'package:fithub_v1/models/training_info.dart';
import 'package:fithub_v1/providers/form_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TrainingInfoForm1 extends StatefulWidget {
  const TrainingInfoForm1({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _TrainingInfoForm1State createState() => _TrainingInfoForm1State();
}

class _TrainingInfoForm1State extends State<TrainingInfoForm1> {
  final _formKey = GlobalKey<FormState>();
  String? _selectedActivityDuration;
  String? _selectedTrainingDuration;
  bool _isNextButtonEnabled = false;

  final formController = Get.find<FormController>();

  void _validateForm() {
    setState(() {
      _isNextButtonEnabled = _selectedActivityDuration != null &&
          _selectedTrainingDuration != null;
    });
  }

  void _onNextPressed() {
    if (_formKey.currentState!.validate()) {
      final trainingInfo = TrainingInfo(
        activityDuration: _selectedActivityDuration!,
        trainingDuration: _selectedTrainingDuration!,
        trainingFrequency: '',
        trainingIntensity: '',
      );
      formController.updateTrainingInfo(trainingInfo);
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
              '¿Cuánto tiempo llevas realizando actividad física de forma continua?',
              style: TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 20),
            DropdownButtonFormField<String>(
              decoration: const InputDecoration(
                labelText: 'Duración de Actividad',
                border: OutlineInputBorder(),
              ),
              items: const [
                DropdownMenuItem(
                    value: 'activity_duration_1to3',
                    child: Text('De 1 - 3 meses')),
                DropdownMenuItem(
                    value: 'activity_duration_3to6',
                    child: Text('De 3 - 6 meses')),
                DropdownMenuItem(
                    value: 'activity_duration_6to9',
                    child: Text('De 6 - 9 meses')),
                DropdownMenuItem(
                    value: 'activity_duration_9to12',
                    child: Text('De 9 - 12 meses')),
                DropdownMenuItem(
                    value: 'activity_duration_12to18',
                    child: Text('De 12 - 18 meses')),
                DropdownMenuItem(
                    value: 'activity_duration_18to24',
                    child: Text('De 18 - 24 meses')),
                DropdownMenuItem(
                    value: 'activity_duration_24plus',
                    child: Text('Más de 2 años')),
              ],
              onChanged: (value) {
                setState(() {
                  _selectedActivityDuration = value;
                });
                _validateForm();
              },
            ),
            const SizedBox(height: 20),
            const Text(
              '¿Cuánto tiempo le dedicas actualmente a tus sesiones de entrenamiento?',
              style: TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 20),
            DropdownButtonFormField<String>(
              decoration: const InputDecoration(
                labelText: 'Tiempo de Entrenamiento',
                border: OutlineInputBorder(),
              ),
              items: const [
                DropdownMenuItem(
                    value: 'training_duration_less30',
                    child: Text('Menos de 30 minutos')),
                DropdownMenuItem(
                    value: 'training_duration_30to45',
                    child: Text('30 - 45 minutos')),
                DropdownMenuItem(
                    value: 'training_duration_45to60',
                    child: Text('45 - 60 minutos')),
                DropdownMenuItem(
                    value: 'training_duration_60to90',
                    child: Text('60 - 90 minutos')),
                DropdownMenuItem(
                    value: 'training_duration_90plus',
                    child: Text('Más de 90 minutos')),
              ],
              onChanged: (value) {
                setState(() {
                  _selectedTrainingDuration = value;
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
