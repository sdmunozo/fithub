import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:fithub_v1/providers/form_controller.dart';
import 'package:fithub_v1/widgets/number_selector_widget.dart';

class HeightWeightHeartRateForm extends StatefulWidget {
  const HeightWeightHeartRateForm({super.key});

  @override
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
      formController.addResponse({
        'height': _height,
        'weight': _weight,
        'heartRate': _heartRate,
      });
      formController.printResponses();
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
                  "Altura: ${_height != 'ingrese' ? double.parse(_height.split(' ')[0]).toStringAsFixed(2) + ' ' + _height.split(' ')[1] : _height}"),
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
                  "Peso: ${_weight != 'ingrese' ? double.parse(_weight.split(' ')[0]).toStringAsFixed(2) + ' ' + _weight.split(' ')[1] : _weight}"),
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
                  "Frecuencia Cardíaca: ${_heartRate != 'ingrese' ? double.parse(_heartRate).toStringAsFixed(2) + ' BPM' : _heartRate}"),
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


/*import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:fithub_v1/providers/form_controller.dart';
import 'package:fithub_v1/widgets/number_selector_widget.dart';
import 'package:fithub_v1/models/height.dart';
import 'package:fithub_v1/models/weight.dart';
import 'package:fithub_v1/models/heart_rate.dart';

class HeightWeightHeartRateForm extends StatefulWidget {
  const HeightWeightHeartRateForm({super.key});

  @override
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
      formController.addResponse({
        'height': _height,
        'weight': _weight,
        'heartRate': _heartRate,
      });
      formController.printResponses();
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
                title: Text("Altura: ${_height.toStringAsFixed(2)}"),
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
              title: Text("Peso: $_weight"),
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
              title: Text("Frecuencia Cardíaca:"),
              subtitle: Text("$_heartRate BPM"),
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

/*import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:fithub_v1/providers/form_controller.dart';
import 'package:fithub_v1/widgets/number_selector_widget.dart';

class HeightWeightHeartRateForm extends StatefulWidget {
  const HeightWeightHeartRateForm({super.key});

  @override
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
      String title, String type, Function(int, int) onValueChanged) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return NumberSelectorWidget(
          title: title,
          type: type,
          onValueChanged: (intPart, decimalPart) {
            onValueChanged(intPart, decimalPart);
            _validateForm();
          },
        );
      },
    );
  }

  void _onNextPressed() {
    if (_formKey.currentState!.validate()) {
      formController.addResponse(
          {'height': _height, 'weight': _weight, 'heartRate': _heartRate});
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
              title: Text("Altura: $_height"),
              trailing: IconButton(
                icon: const Icon(Icons.edit),
                onPressed: () {
                  _showNumberSelector(
                    "Seleccionar Altura",
                    'height',
                    (intPart, decimalPart) {
                      setState(() {
                        _height = '$intPart.$decimalPart';
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
              title: Text("Peso: $_weight"),
              trailing: IconButton(
                icon: const Icon(Icons.edit),
                onPressed: () {
                  _showNumberSelector(
                    "Seleccionar Peso",
                    'weight',
                    (intPart, decimalPart) {
                      setState(() {
                        _weight = '$intPart.$decimalPart';
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
              title: Text("Frecuencia Cardiaca: $_heartRate BPM"),
              trailing: IconButton(
                icon: const Icon(Icons.edit),
                onPressed: () {
                  _showNumberSelector(
                    "Seleccionar Frecuencia Cardiaca",
                    'heartRate',
                    (intPart, _) {
                      setState(() {
                        _heartRate = '$intPart';
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





/*import 'package:fithub_v1/providers/form_controller.dart';
import 'package:fithub_v1/widgets/number_selector_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HeightWeightHeartRateForm extends StatefulWidget {
  const HeightWeightHeartRateForm({super.key});

  @override
  _HeightWeightHeartRateFormState createState() =>
      _HeightWeightHeartRateFormState();
}

class _HeightWeightHeartRateFormState extends State<HeightWeightHeartRateForm> {
  final _formKey = GlobalKey<FormState>();
  int _heightIntPart = 160, _heightDecimalPart = 0;
  int _weightIntPart = 70, _weightDecimalPart = 0;
  int _heartRate = 50;
  bool _isNextButtonEnabled = false;

  final formController = Get.find<FormController>();

  void _validateForm() {
    setState(() {
      _isNextButtonEnabled =
          _heightIntPart > 0 && _weightIntPart > 0 && _heartRate > 0;
    });
  }

  void _showNumberSelector(
      String title, String type, Function(int, int) onValueChanged) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return NumberSelectorWidget(
          title: title,
          type: type,
          onValueChanged: (intPart, decimalPart) {
            onValueChanged(intPart, decimalPart);
            _validateForm();
          },
        );
      },
    );
  }

  void _onNextPressed() {
    if (_formKey.currentState!.validate()) {
      formController.nextQuestion();
      // Guardar los valores y proceder
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
              title: Text("Altura: $_heightIntPart.$_heightDecimalPart"),
              trailing: IconButton(
                icon: const Icon(Icons.edit),
                onPressed: () {
                  _showNumberSelector(
                    "Seleccionar Altura",
                    'height',
                    (intPart, decimalPart) {
                      setState(() {
                        _heightIntPart = intPart;
                        _heightDecimalPart = decimalPart;
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
              title: Text("Peso: $_weightIntPart.$_weightDecimalPart"),
              trailing: IconButton(
                icon: const Icon(Icons.edit),
                onPressed: () {
                  _showNumberSelector(
                    "Seleccionar Peso",
                    'weight',
                    (intPart, decimalPart) {
                      setState(() {
                        _weightIntPart = intPart;
                        _weightDecimalPart = decimalPart;
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
              title: Text("Frecuencia Cardiaca: $_heartRate BPM"),
              trailing: IconButton(
                icon: const Icon(Icons.edit),
                onPressed: () {
                  _showNumberSelector(
                    "Seleccionar Frecuencia Cardiaca",
                    'heartRate',
                    (intPart, _) {
                      setState(() {
                        _heartRate = intPart;
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
}*/


/*import 'package:fithub_v1/providers/form_controller.dart';
import 'package:fithub_v1/widgets/number_selector_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HeightWeightHeartRateForm extends StatefulWidget {
  const HeightWeightHeartRateForm({super.key});

  @override
  _HeightWeightHeartRateFormState createState() =>
      _HeightWeightHeartRateFormState();
}

class _HeightWeightHeartRateFormState extends State<HeightWeightHeartRateForm> {
  final _formKey = GlobalKey<FormState>();
  int _heightIntPart = 0, _heightDecimalPart = 0;
  int _weightIntPart = 0, _weightDecimalPart = 0;
  int _heartRate = 0;
  bool _isNextButtonEnabled = false;

  final formController = Get.find<FormController>();

  void _validateForm() {
    setState(() {
      _isNextButtonEnabled =
          _heightIntPart > 0 && _weightIntPart > 0 && _heartRate > 0;
    });
  }

  void _showNumberSelector(String title, Function(int, int) onValueChanged) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return NumberSelectorWidget(
          title: title,
          onValueChanged: (intPart, decimalPart) {
            onValueChanged(intPart, decimalPart);
            _validateForm();
          },
        );
      },
    );
  }

  void _onNextPressed() {
    if (_formKey.currentState!.validate()) {
      formController.nextQuestion();
      // Guardar los valores y proceder
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
              title: Text("Altura: $_heightIntPart.$_heightDecimalPart cm"),
              trailing: IconButton(
                icon: const Icon(Icons.edit),
                onPressed: () {
                  _showNumberSelector(
                    "Seleccionar Altura",
                    (intPart, decimalPart) {
                      setState(() {
                        _heightIntPart = intPart;
                        _heightDecimalPart = decimalPart;
                      });
                    },
                  );
                },
              ),
            ),
            const SizedBox(height: 30),
            ListTile(
              title: Text("Peso: $_weightIntPart.$_weightDecimalPart kg"),
              trailing: IconButton(
                icon: const Icon(Icons.edit),
                onPressed: () {
                  _showNumberSelector(
                    "Seleccionar Peso",
                    (intPart, decimalPart) {
                      setState(() {
                        _weightIntPart = intPart;
                        _weightDecimalPart = decimalPart;
                      });
                    },
                  );
                },
              ),
            ),
            const SizedBox(height: 30),
            ListTile(
              title: Text("Frecuencia Cardiaca: $_heartRate BPM"),
              trailing: IconButton(
                icon: const Icon(Icons.edit),
                onPressed: () {
                  _showNumberSelector(
                    "Seleccionar Frecuencia Cardiaca",
                    (intPart, _) {
                      setState(() {
                        _heartRate = intPart;
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

/*import 'package:fithub_v1/widgets/number_selector_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HeightWeightHeartRateForm extends StatefulWidget {
  const HeightWeightHeartRateForm({super.key});

  @override
  _HeightWeightHeartRateFormState createState() =>
      _HeightWeightHeartRateFormState();
}

class _HeightWeightHeartRateFormState extends State<HeightWeightHeartRateForm> {
  final _formKey = GlobalKey<FormState>();
  int _heightIntPart = 0, _heightDecimalPart = 0;
  int _weightIntPart = 0, _weightDecimalPart = 0;
  int _heartRate = 0;

  void _showNumberSelector(String title, Function(int, int) onValueChanged) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return NumberSelectorWidget(
          title: title,
          onValueChanged: onValueChanged,
        );
      },
    );
  }

  void _onNextPressed() {
    if (_formKey.currentState!.validate()) {
      // Guardar los valores y proceder
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
              title: Text("Altura: $_heightIntPart.$_heightDecimalPart cm"),
              trailing: IconButton(
                icon: const Icon(Icons.edit),
                onPressed: () {
                  _showNumberSelector(
                    "Seleccionar Altura",
                    (intPart, decimalPart) {
                      setState(() {
                        _heightIntPart =
                            intPart != 0 ? intPart : _heightIntPart;
                        _heightDecimalPart =
                            decimalPart != 0 ? decimalPart : _heightDecimalPart;
                      });
                    },
                  );
                },
              ),
            ),
            const SizedBox(height: 30),
            ListTile(
              title: Text("Peso: $_weightIntPart.$_weightDecimalPart kg"),
              trailing: IconButton(
                icon: const Icon(Icons.edit),
                onPressed: () {
                  _showNumberSelector(
                    "Seleccionar Peso",
                    (intPart, decimalPart) {
                      setState(() {
                        _weightIntPart =
                            intPart != 0 ? intPart : _weightIntPart;
                        _weightDecimalPart =
                            decimalPart != 0 ? decimalPart : _weightDecimalPart;
                      });
                    },
                  );
                },
              ),
            ),
            const SizedBox(height: 30),
            ListTile(
              title: Text("Frecuencia Cardiaca: $_heartRate BPM"),
              trailing: IconButton(
                icon: const Icon(Icons.edit),
                onPressed: () {
                  _showNumberSelector(
                    "Seleccionar Frecuencia Cardiaca",
                    (intPart, _) {
                      setState(() {
                        _heartRate = intPart != 0 ? intPart : _heartRate;
                      });
                    },
                  );
                },
              ),
            ),
            const SizedBox(height: 30),
            IconButton(
              icon: const Icon(Icons.arrow_forward),
              onPressed: _onNextPressed,
              iconSize: 50,
              color: Colors.blue,
            ),
          ],
        ),
      ),
    );
  }
}
*/