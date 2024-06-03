import 'package:fithub_v1/models/heart_rate.dart';
import 'package:fithub_v1/models/height.dart';
import 'package:fithub_v1/models/weight.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:fithub_v1/providers/form_controller.dart';
import 'package:fithub_v1/widgets/number_selector_widget.dart';

class HeightWeightHeartRateForm extends StatefulWidget {
  const HeightWeightHeartRateForm({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _HeightWeightHeartRateFormState createState() =>
      _HeightWeightHeartRateFormState();
}

class _HeightWeightHeartRateFormState extends State<HeightWeightHeartRateForm> {
  final _formKey = GlobalKey<FormState>();
  String _height = "ingrese";
  String _weight = "ingrese";
  String _heartRate = "ingrese";
  bool _isNextButtonEnabled = false;

  final formController = Get.find<FormController>();

  void _validateForm() {
    setState(() {
      _isNextButtonEnabled = _height != "ingrese" &&
          _weight != "ingrese" &&
          _heartRate != "ingrese";
    });
  }

  void _showNumberSelector(
      String title, String type, Function(double, String) onValueChanged) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return NumberSelectorWidget(
          title: title,
          type: type,
          onValueChanged: (value, unit) {
            onValueChanged(value, unit);
            _validateForm();
          },
        );
      },
    );
  }

  void _onNextPressed() {
    if (_formKey.currentState!.validate()) {
      final height =
          Height(double.parse(_height.split(' ')[0]), _height.split(' ')[1]);
      final weight =
          Weight(double.parse(_weight.split(' ')[0]), _weight.split(' ')[1]);
      final heartRate = HeartRate(int.parse(_heartRate), 'BPM');

      formController.updateHeight(height);
      formController.updateWeight(weight);
      formController.updateHeartRate(heartRate);
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
            const SizedBox(height: 30),
            ListTile(
              leading:
                  Image.asset('assets/images/form/icons/limite-de-altura.png'),
              title: Text(
                  "Altura: ${_height != 'ingrese' ? '${double.parse(_height.split(' ')[0]).toStringAsFixed(2)} ${_height.split(' ')[1]}' : _height}"),
              trailing: IconButton(
                icon: const Icon(Icons.edit),
                onPressed: () {
                  _showNumberSelector(
                    "Seleccionar Altura",
                    'height',
                    (value, unit) {
                      setState(() {
                        _height = '$value $unit';
                      });
                    },
                  );
                },
              ),
            ),
            const SizedBox(height: 30),
            ListTile(
              leading:
                  Image.asset('assets/images/form/icons/escala-de-peso.png'),
              title: Text(
                  "Peso: ${_weight != 'ingrese' ? '${double.parse(_weight.split(' ')[0]).toStringAsFixed(2)} ${_weight.split(' ')[1]}' : _weight}"),
              trailing: IconButton(
                icon: const Icon(Icons.edit),
                onPressed: () {
                  _showNumberSelector(
                    "Seleccionar Peso",
                    'weight',
                    (value, unit) {
                      setState(() {
                        _weight = '$value $unit';
                      });
                    },
                  );
                },
              ),
            ),
            const SizedBox(height: 30),
            ListTile(
              leading:
                  Image.asset('assets/images/form/icons/ritmo-cardiaco.png'),
              title: Text(
                  "Frecuencia Cardíaca: ${_heartRate != 'ingrese' ? '${double.parse(_heartRate).toStringAsFixed(2)} BPM' : _heartRate}"),
              trailing: IconButton(
                icon: const Icon(Icons.edit),
                onPressed: () {
                  _showNumberSelector(
                    "Frecuencia Cardiaca",
                    'heartRate',
                    (value, unit) {
                      setState(() {
                        _heartRate = '$value';
                      });
                    },
                  );
                },
              ),
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




/* Primera version: Antes de estandarizacion

class HeightWeightHeartRateForm extends StatefulWidget {
  const HeightWeightHeartRateForm({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _HeightWeightHeartRateFormState createState() =>
      _HeightWeightHeartRateFormState();
}

class _HeightWeightHeartRateFormState extends State<HeightWeightHeartRateForm> {
  final _formKey = GlobalKey<FormState>();
  String _height = "ingrese";
  String _weight = "ingrese";
  String _heartRate = "ingrese";
  bool _isNextButtonEnabled = false;

  final formController = Get.find<FormController>();

  void _validateForm() {
    setState(() {
      _isNextButtonEnabled = _height != "ingrese" &&
          _weight != "ingrese" &&
          _heartRate != "ingrese";
    });
  }

  void _showNumberSelector(
      String title, String type, Function(double, String) onValueChanged) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return NumberSelectorWidget(
          title: title,
          type: type,
          onValueChanged: (value, unit) {
            onValueChanged(value, unit);
            _validateForm();
          },
        );
      },
    );
  }

  void _onNextPressed() {
    if (_formKey.currentState!.validate()) {
      final height =
          Height(double.parse(_height.split(' ')[0]), _height.split(' ')[1]);
      final weight =
          Weight(double.parse(_weight.split(' ')[0]), _weight.split(' ')[1]);
      final heartRate = HeartRate(int.parse(_heartRate), 'BPM');

      formController.updateHeight(height);
      formController.updateWeight(weight);
      formController.updateHeartRate(heartRate);
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
            const SizedBox(height: 30),
            ListTile(
              leading:
                  Image.asset('assets/images/form/icons/limite-de-altura.png'),
              title: Text(
                  "Altura: ${_height != 'ingrese' ? '${double.parse(_height.split(' ')[0]).toStringAsFixed(2)} ${_height.split(' ')[1]}' : _height}"),
              trailing: IconButton(
                icon: const Icon(Icons.edit),
                onPressed: () {
                  _showNumberSelector(
                    "Seleccionar Altura",
                    'height',
                    (value, unit) {
                      setState(() {
                        _height = '$value $unit';
                      });
                    },
                  );
                },
              ),
            ),
            const SizedBox(height: 30),
            ListTile(
              leading:
                  Image.asset('assets/images/form/icons/escala-de-peso.png'),
              title: Text(
                  "Peso: ${_weight != 'ingrese' ? '${double.parse(_weight.split(' ')[0]).toStringAsFixed(2)} ${_weight.split(' ')[1]}' : _weight}"),
              trailing: IconButton(
                icon: const Icon(Icons.edit),
                onPressed: () {
                  _showNumberSelector(
                    "Seleccionar Peso",
                    'weight',
                    (value, unit) {
                      setState(() {
                        _weight = '$value $unit';
                      });
                    },
                  );
                },
              ),
            ),
            const SizedBox(height: 30),
            ListTile(
              leading:
                  Image.asset('assets/images/form/icons/ritmo-cardiaco.png'),
              title: Text(
                  "Frecuencia Cardíaca: ${_heartRate != 'ingrese' ? '${double.parse(_heartRate).toStringAsFixed(2)} BPM' : _heartRate}"),
              trailing: IconButton(
                icon: const Icon(Icons.edit),
                onPressed: () {
                  _showNumberSelector(
                    "Frecuencia Cardiaca",
                    'heartRate',
                    (value, unit) {
                      setState(() {
                        _heartRate = '$value';
                      });
                    },
                  );
                },
              ),
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