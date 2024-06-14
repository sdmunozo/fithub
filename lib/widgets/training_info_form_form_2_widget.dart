import 'package:fithub_v1/models/training_info.dart';
import 'package:fithub_v1/providers/form_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TrainingInfoForm2 extends StatefulWidget {
  const TrainingInfoForm2({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _TrainingInfoForm2State createState() => _TrainingInfoForm2State();
}

class _TrainingInfoForm2State extends State<TrainingInfoForm2> {
  final _formKey = GlobalKey<FormState>();
  String? _selectedTrainingFrequency;
  String? _selectedTrainingIntensity;
  bool _isNextButtonEnabled = false;

  final formController = Get.find<FormController>();

  void _validateForm() {
    setState(() {
      _isNextButtonEnabled = _selectedTrainingFrequency != null &&
          _selectedTrainingIntensity != null;
    });
  }

  void _onNextPressed() {
    if (_formKey.currentState!.validate()) {
      final existingInfo = formController.trainingInfo.value!;
      final updatedInfo = TrainingInfo(
        activityDuration: existingInfo.activityDuration,
        trainingDuration: existingInfo.trainingDuration,
        trainingFrequency: _selectedTrainingFrequency!,
        trainingIntensity: _selectedTrainingIntensity!,
      );
      formController.updateTrainingInfo(updatedInfo);
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
              '¿Con qué frecuencia realizas tus sesiones de entrenamiento?',
              style: TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 20),
            DropdownButtonFormField<String>(
              decoration: const InputDecoration(
                labelText: 'Frecuencia de Entrenamiento',
                border: OutlineInputBorder(),
              ),
              items: const [
                DropdownMenuItem(
                    value: 'training_frequency_1perweek',
                    child: Text('1 día por semana')),
                DropdownMenuItem(
                    value: 'training_frequency_2perweek',
                    child: Text('2 días por semana')),
                DropdownMenuItem(
                    value: 'training_frequency_3perweek',
                    child: Text('3 días por semana')),
                DropdownMenuItem(
                    value: 'training_frequency_4perweek',
                    child: Text('4 días por semana')),
                DropdownMenuItem(
                    value: 'training_frequency_5perweek',
                    child: Text('5 días por semana')),
                DropdownMenuItem(
                    value: 'training_frequency_6perweek',
                    child: Text('6 días por semana')),
                DropdownMenuItem(
                    value: 'training_frequency_7perweek',
                    child: Text('7 días por semana')),
              ],
              onChanged: (value) {
                setState(() {
                  _selectedTrainingFrequency = value;
                });
                _validateForm();
              },
            ),
            const SizedBox(height: 20),
            const Text(
              '¿Con qué nivel de intensidad realizas tus sesiones de entrenamiento?',
              style: TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 20),
            DropdownButtonFormField<String>(
              decoration: const InputDecoration(
                labelText: 'Intensidad de Entrenamiento',
                border: OutlineInputBorder(),
              ),
              items: const [
                DropdownMenuItem(
                    value: 'training_intensity_low', child: Text('Baja')),
                DropdownMenuItem(
                    value: 'training_intensity_medium',
                    child: Text('Moderada')),
                DropdownMenuItem(
                    value: 'training_intensity_high', child: Text('Alta')),
              ],
              onChanged: (value) {
                setState(() {
                  _selectedTrainingIntensity = value;
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
