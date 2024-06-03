// ignore_for_file: library_private_types_in_public_api

import 'dart:convert';
import 'package:fithub_v1/screens/form_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart'
    show FilteringTextInputFormatter, rootBundle;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:fithub_v1/providers/global_config_provider.dart';
import 'package:intl/intl.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        GlobalConfigProvider.setMaxHeight(constraints.maxHeight);
        GlobalConfigProvider.setMaxWidth(constraints.maxWidth);

        return const MaterialApp(
          //home: SurveyScreen(),
          //home: FormScreen1(),
          home: FormScreen(),
          debugShowCheckedModeBanner: false,
        );
      },
    );
  }
}

class SurveyScreen extends StatefulWidget {
  const SurveyScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SurveyScreenState createState() => _SurveyScreenState();
}

class _SurveyScreenState extends State<SurveyScreen> {
  List<Map<String, dynamic>> questions = [];
  int currentIndex = 0;
  Map<int, dynamic> answers = {};
  TextEditingController textController = TextEditingController();

  @override
  void initState() {
    super.initState();
    loadQuestions();
  }

  Future<void> loadQuestions() async {
    String data = await rootBundle.loadString('assets/data/init_form.json');
    final jsonResult = json.decode(data);
    setState(() {
      questions = List<Map<String, dynamic>>.from(jsonResult['questions']);
    });
  }

  void nextQuestion(dynamic answer) {
    setState(() {
      answers[questions[currentIndex]['id']] = answer;
      textController.clear();
      if (currentIndex < questions.length - 1) {
        currentIndex++;
      } else {
        showSummary();
      }
    });
  }

  void showSummary() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Resumen"),
          content: SingleChildScrollView(
            child: ListBody(
              children: answers.entries.map((entry) {
                int questionId = entry.key;
                var answer = entry.value;
                String questionText = questions
                    .firstWhere((q) => q['id'] == questionId)['question'];
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Text("$questionText: $answer"),
                );
              }).toList(),
            ),
          ),
          actions: [
            TextButton(
              child: const Text("Cerrar"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    if (questions.isEmpty) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    Map<String, dynamic> currentQuestion = questions[currentIndex];
    double progress = (currentIndex + 1) / questions.length;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Cuestionario'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Center(
              child: Icon(
                FontAwesomeIcons.questionCircle,
                size: 60,
                color: Colors.blueAccent,
              ),
            ),
            const SizedBox(height: 20),
            LinearProgressIndicator(
              value: progress,
              backgroundColor: Colors.grey[300],
              color: Colors.blueAccent,
              minHeight: 8,
            ),
            const SizedBox(height: 20),
            Text(
              currentQuestion['question'],
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            Expanded(
                child: SingleChildScrollView(
                    child: Column(
                        children: _buildQuestionWidget(currentQuestion)))),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                nextQuestion(_getAnswer());
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blueAccent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              child: const Padding(
                padding: EdgeInsets.symmetric(vertical: 16.0),
                child: Text('Siguiente', style: TextStyle(fontSize: 18)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildQuestionWidget(Map<String, dynamic> question) {
    switch (question['type']) {
      case 'open':
        return [
          TextField(
            controller: textController,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Tu respuesta',
              prefixIcon: Icon(Icons.text_fields),
            ),
            onChanged: (value) {
              answers[question['id']] = value;
            },
          ),
        ];
      case 'email':
        return [
          TextField(
            controller: textController,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Tu correo electrónico',
              prefixIcon: Icon(Icons.email),
            ),
            keyboardType: TextInputType.emailAddress,
            onChanged: (value) {
              answers[question['id']] = value;
            },
          ),
        ];
      case 'date':
        return [
          ElevatedButton.icon(
            icon: const Icon(Icons.calendar_today),
            label: const Text('Seleccionar fecha'),
            onPressed: () async {
              DateTime? picked = await showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime(1900),
                lastDate: DateTime(2101),
              );
              if (picked != null) {
                setState(() {
                  answers[question['id']] = picked.toString();
                });
              }
            },
          ),
          if (answers[question['id']] != null)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Text("Fecha seleccionada: ${answers[question['id']]}"),
            ),
        ];
      case 'single_choice':
        return [
          for (var answer in question['answers'])
            ListTile(
              title: Text(answer['text']),
              leading: Radio(
                value: answer['key'],
                groupValue: answers[question['id']],
                onChanged: (value) {
                  setState(() {
                    answers[question['id']] = value;
                  });
                },
              ),
            ),
        ];
      case 'multiple_choice':
        return [
          for (var answer in question['answers'])
            CheckboxListTile(
              title: Text(answer['text']),
              value: answers[question['id']]?.contains(answer['key']) ?? false,
              onChanged: (bool? value) {
                setState(() {
                  if (value == true) {
                    answers[question['id']] = (answers[question['id']] ?? [])
                      ..add(answer['key']);
                  } else {
                    answers[question['id']] = (answers[question['id']] ?? [])
                      ..remove(answer['key']);
                  }
                });
              },
            ),
        ];
      default:
        return [];
    }
  }

  dynamic _getAnswer() {
    var currentQuestion = questions[currentIndex];
    if (currentQuestion['type'] == 'multiple_choice') {
      return answers[currentQuestion['id']] ?? [];
    } else {
      return answers[currentQuestion['id']];
    }
  }
}

class FormScreen1 extends StatefulWidget {
  const FormScreen1({super.key});

  @override
  _FormScreenState createState() => _FormScreenState();
}

class _FormScreenState extends State<FormScreen1> {
  Map<String, dynamic>? formData;
  Map<int, dynamic> answersMap = {};
  final _formKey = GlobalKey<FormState>();
  final Map<int, TextEditingController> _controllers = {};
  bool _submitted = false;

  @override
  void initState() {
    super.initState();
    loadJsonData();
  }

  Future<void> loadJsonData() async {
    String jsonString =
        await rootBundle.loadString('assets/data/init_form.json');
    setState(() {
      formData = json.decode(jsonString);
    });
  }

  String _determineLevel() {
    final activityDuration =
        answersMap[7]; // tiempo_actividad_fisica_ininterrumpida_actual
    final trainingFrequency =
        answersMap[9]; // frecuencia_actividad_fisica_actual
    final trainingDuration =
        answersMap[8]; // duracion_sesiones_entrenamiento_actual
    final trainingIntensity = answersMap[10]; // intensidad_entrenamiento_actual

    if (activityDuration == "activity_duration_1to3") {
      return "Principiante";
    }

    if (activityDuration == "activity_duration_3to6") {
      bool condition1 = (trainingFrequency == "training_frequency_1perweek" ||
          trainingFrequency == "training_frequency_2perweek" ||
          trainingFrequency == "training_frequency_3perweek" ||
          trainingFrequency == "training_frequency_4perweek");

      bool condition2 = (trainingFrequency == "training_frequency_4perweek" &&
          (trainingDuration == "training_duration_less30" ||
              trainingDuration == "training_duration_30to45" ||
              trainingDuration == "training_duration_45to60"));

      bool condition3 = ((trainingFrequency == "training_frequency_5perweek" ||
              trainingFrequency == "training_frequency_6perweek" ||
              trainingFrequency == "training_frequency_7perweek") &&
          (trainingDuration == "training_duration_less30" ||
              trainingDuration == "training_duration_30to45"));

      if (condition1 || condition2 || condition3) {
        return "Principiante";
      }

      bool condition4 = (trainingFrequency == "training_frequency_5perweek" ||
              trainingFrequency == "training_frequency_6perweek" ||
              trainingFrequency == "training_frequency_7perweek") &&
          (trainingDuration == "training_duration_60to90");
      if (condition4) {
        return "Intermedio";
      }
    }

    if (activityDuration == "activity_duration_6to9") {
      bool condition1 = (trainingFrequency == "training_frequency_1perweek" ||
          trainingFrequency == "training_frequency_2perweek");

      bool condition2 = (trainingFrequency == "training_frequency_3perweek" &&
          (trainingDuration == "training_duration_less30" ||
              trainingDuration == "training_duration_30to45") &&
          (trainingIntensity == "training_intensity_low" ||
              trainingIntensity == "training_intensity_medium"));

      if (condition1 || condition2) {
        return "Principiante";
      }
    }

    if (activityDuration == "activity_duration_9to12") {
      bool condition0 = (trainingFrequency == "training_frequency_1perweek" ||
          trainingFrequency == "training_frequency_2perweek");

      bool condition1 = (trainingFrequency == "training_frequency_3perweek" &&
          trainingDuration == "training_duration_less30");

      bool condition2 = ((trainingFrequency == "training_frequency_5perweek" ||
              trainingFrequency == "training_frequency_6perweek" ||
              trainingFrequency == "training_frequency_7perweek") &&
          (trainingDuration == "training_duration_less30" ||
              trainingDuration == "training_duration_30to45") &&
          (trainingIntensity == "training_intensity_low" ||
              trainingIntensity == "training_intensity_medium"));

      bool condition3 = (trainingFrequency == "training_frequency_5perweek" &&
          (trainingDuration == "training_duration_60to90" ||
              trainingDuration == "training_duration_90plus") &&
          trainingIntensity == "training_intensity_medium");

      bool condition4 = ((trainingFrequency == "training_frequency_6perweek" ||
              trainingFrequency == "training_frequency_7perweek") &&
          (trainingDuration == "training_duration_60to90" ||
              trainingDuration == "training_duration_90plus") &&
          (trainingIntensity == "training_intensity_medium" ||
              trainingIntensity == "training_intensity_high"));

      if (condition0 || condition1 || condition2) {
        return "Principiante";
      } else if (condition3) {
        return "Intermedio";
      } else if (condition4) {
        return "Avanzado";
      }
    }

    if (activityDuration == "activity_duration_12to18") {
      if (trainingIntensity == "training_intensity_low") {
        return "Principiante";
      }

      bool condition1 = ((trainingFrequency == "training_frequency_6perweek" ||
              trainingFrequency == "training_frequency_7perweek") ||
          trainingFrequency == "training_frequency_3perweek" &&
              trainingDuration == "training_duration_30to45");

      if (condition1) {
        return "Principiante";
      }
    }

    if (activityDuration == "activity_duration_18to24" ||
        activityDuration == "activity_duration_24plus") {
      if (trainingIntensity == "training_intensity_low") {
        return "Principiante";
      }

      bool condition1 = (trainingFrequency == "training_frequency_1perweek" ||
          trainingFrequency == "training_frequency_2perweek" ||
          trainingFrequency == "training_frequency_3perweek" &&
              trainingDuration == "training_duration_less30");

      if (condition1) {
        return "Principiante";
      }

      if (trainingIntensity == "training_intensity_low") {
        return "Avanzado";
      }
    }

    return "Nivel desconocido";
  }

  void _submitForm() {
    setState(() {
      _submitted = true;
    });

    if (_formKey.currentState!.validate() && _checkRequiredFields()) {
      String level = _determineLevel();
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Resumen de Respuestas'),
            content: SingleChildScrollView(
              child: ListBody(
                children: [
                  ...answersMap.entries.map((entry) {
                    final questionId = entry.key;
                    final answer = entry.value;
                    final question = formData!['questions']
                        .firstWhere((q) => q['id'] == questionId);

                    if (question['type'] == 'multiple_choice') {
                      final answerKeys = (answer as List)
                          .map((a) => formData!['answers'][question['answers']]
                              .firstWhere((item) => item['text'] == a)['key'])
                          .join(', ');
                      return Text(
                        '${question['question']}: $answerKeys',
                      );
                    } else if (question['type'] == 'single_choice') {
                      final answerKey = formData!['answers']
                              [question['answers']]
                          .firstWhere((item) => item['text'] == answer)['key'];
                      return Text(
                        '${question['question']}: $answerKey',
                      );
                    } else {
                      return Text(
                        '${question['question']}: $answer',
                      );
                    }
                  }),
                  const SizedBox(height: 20),
                  Text('Nivel Determinado: $level'),
                ],
              ),
            ),
            actions: [
              TextButton(
                child: const Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Error'),
            content: const Text(
                'Asegúrate de responder todas las preguntas requeridas'),
            actions: [
              TextButton(
                child: const Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
  }

  bool _checkRequiredFields() {
    for (var question in formData!['questions']) {
      final questionId = question['id'];
      final isRequired = question['required'] ?? false;

      if (isRequired &&
          (answersMap[questionId] == null || answersMap[questionId].isEmpty)) {
        return false;
      }
    }
    return true;
  }

  @override
  void dispose() {
    for (var controller in _controllers.values) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (formData == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Formulario de Rutinas')),
        body: const Center(child: CircularProgressIndicator()),
      );
    }

    final questions = formData!['questions'];
    final answers = formData!['answers'];

    return Scaffold(
      appBar: AppBar(title: const Text('Formulario de Rutinas')),
      body: Form(
        key: _formKey,
        child: ListView.builder(
          itemCount: questions.length,
          itemBuilder: (context, index) {
            final question = questions[index];
            final format = question['format'];
            final questionId = question['id'];
            final isRequired = question['required'] ?? false;

            if (!_controllers.containsKey(questionId)) {
              _controllers[questionId] = TextEditingController(
                text: answersMap[questionId]?.toString() ?? '',
              );
            }

            Widget buildValidationMessage() {
              return (_submitted &&
                      isRequired &&
                      (answersMap[questionId] == null ||
                          answersMap[questionId].isEmpty))
                  ? const Padding(
                      padding: EdgeInsets.symmetric(vertical: 5.0),
                      child: Text(
                        'Este campo es obligatorio',
                        style: TextStyle(color: Colors.red),
                      ),
                    )
                  : Container();
            }

            if (question['type'] == 'open' ||
                question['type'] == 'email' ||
                question['type'] == 'date') {
              return ListTile(
                title: Text(question['question']),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (question['type'] == 'open' ||
                        question['type'] == 'email')
                      TextFormField(
                        controller: _controllers[questionId],
                        keyboardType: format == 'integer'
                            ? TextInputType.number
                            : format == 'double'
                                ? const TextInputType.numberWithOptions(
                                    decimal: true)
                                : TextInputType.text,
                        inputFormatters: format == 'integer'
                            ? [FilteringTextInputFormatter.digitsOnly]
                            : format == 'double'
                                ? [
                                    FilteringTextInputFormatter.allow(
                                        RegExp(r'^\d*\.?\d*$'))
                                  ]
                                : [],
                        onChanged: (value) {
                          setState(() {
                            answersMap[questionId] = value;
                          });
                        },
                      ),
                    if (question['type'] == 'date')
                      TextButton(
                        onPressed: () async {
                          DateTime? pickedDate = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(1900),
                            lastDate: DateTime(2100),
                          );
                          if (pickedDate != null) {
                            setState(() {
                              answersMap[questionId] =
                                  DateFormat('yyyy-MM-dd').format(pickedDate);
                            });
                          }
                        },
                        child: Text(
                          answersMap[questionId] ?? 'Seleccionar fecha',
                        ),
                      ),
                    buildValidationMessage(),
                  ],
                ),
              );
            } else if (question['type'] == 'height') {
              return ListTile(
                title: Text(question['question']),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    HeightPicker(
                      initialValue: answersMap[questionId]?.toString() ?? '',
                      onHeightChanged: (value) {
                        setState(() {
                          answersMap[questionId] = value;
                          _controllers[questionId]?.text = value;
                        });
                      },
                    ),
                    buildValidationMessage(),
                  ],
                ),
              );
            } else if (question['type'] == 'weight') {
              return ListTile(
                title: Text(question['question']),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    WeightPicker(
                      initialValue: answersMap[questionId]?.toString() ?? '',
                      onWeightChanged: (value) {
                        setState(() {
                          answersMap[questionId] = value;
                          _controllers[questionId]?.text = value;
                        });
                      },
                    ),
                    buildValidationMessage(),
                  ],
                ),
              );
            } else if (question['type'] == 'single_choice') {
              return ListTile(
                title: Text(question['question']),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    buildValidationMessage(),
                    Column(
                      children: (answers[question['answers']] as List<dynamic>)
                          .map((answer) => RadioListTile(
                                title: Text(answer['text']),
                                value: answer['text'],
                                groupValue: answersMap[questionId],
                                onChanged: (value) {
                                  setState(() {
                                    answersMap[questionId] = value;
                                  });
                                },
                              ))
                          .toList(),
                    ),
                  ],
                ),
              );
            } else if (question['type'] == 'multiple_choice') {
              return ListTile(
                title: Text(question['question']),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    buildValidationMessage(),
                    Column(
                      children: (answers[question['answers']] as List<dynamic>)
                          .map((answer) => CheckboxListTile(
                                title: Text(answer['text']),
                                value: answersMap[questionId] != null &&
                                    (answersMap[questionId] as List)
                                        .contains(answer['text']),
                                onChanged: (value) {
                                  setState(() {
                                    if (value == true) {
                                      if (answersMap[questionId] == null) {
                                        answersMap[questionId] = [
                                          answer['text']
                                        ];
                                      } else {
                                        (answersMap[questionId] as List)
                                            .add(answer['text']);
                                      }
                                    } else {
                                      (answersMap[questionId] as List)
                                          .remove(answer['text']);
                                    }
                                  });
                                },
                              ))
                          .toList(),
                    ),
                  ],
                ),
              );
            }
            return Container();
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _submitForm,
        child: const Icon(Icons.send),
      ),
    );
  }
}

class HeightPicker extends StatefulWidget {
  final String initialValue;
  final Function(String) onHeightChanged;

  const HeightPicker(
      {super.key, required this.initialValue, required this.onHeightChanged});

  @override
  // ignore: library_private_types_in_public_api
  _HeightPickerState createState() => _HeightPickerState();
}

class _HeightPickerState extends State<HeightPicker> {
  bool isMetric = true;
  late TextEditingController heightController;

  @override
  void initState() {
    super.initState();
    heightController = TextEditingController(text: widget.initialValue);
  }

  @override
  void dispose() {
    heightController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextFormField(
            controller: heightController,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            inputFormatters: [
              FilteringTextInputFormatter.allow(
                RegExp(r'^\d*\.?\d*$'),
              ),
            ],
            decoration: InputDecoration(
              hintText: isMetric ? 'cm' : 'ft',
            ),
            onChanged: (value) {
              widget.onHeightChanged(value + (isMetric ? ' cm' : ' ft'));
            },
          ),
        ),
        Switch(
          value: isMetric,
          onChanged: (value) {
            setState(() {
              isMetric = value;
              heightController.clear();
            });
          },
        ),
        Text(isMetric ? 'cm' : 'ft'),
      ],
    );
  }
}

class WeightPicker extends StatefulWidget {
  final String initialValue;
  final Function(String) onWeightChanged;

  const WeightPicker(
      {super.key, required this.initialValue, required this.onWeightChanged});

  @override
  _WeightPickerState createState() => _WeightPickerState();
}

class _WeightPickerState extends State<WeightPicker> {
  bool isMetric = true;
  late TextEditingController weightController;

  @override
  void initState() {
    super.initState();
    weightController = TextEditingController(text: widget.initialValue);
  }

  @override
  void dispose() {
    weightController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextFormField(
            controller: weightController,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            inputFormatters: [
              FilteringTextInputFormatter.allow(
                RegExp(r'^\d*\.?\d*$'),
              ),
            ],
            decoration: InputDecoration(
              hintText: isMetric ? 'kg' : 'lbs',
            ),
            onChanged: (value) {
              widget.onWeightChanged(value + (isMetric ? ' kg' : ' lbs'));
            },
          ),
        ),
        Switch(
          value: isMetric,
          onChanged: (value) {
            setState(() {
              isMetric = value;
              weightController.clear();
            });
          },
        ),
        Text(isMetric ? 'kg' : 'lbs'),
      ],
    );
  }
}



/*import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart'
    show FilteringTextInputFormatter, TextInputFormatter, rootBundle;
import 'package:intl/intl.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: FormScreen(),
    );
  }
}

class FormScreen extends StatefulWidget {
  @override
  _FormScreenState createState() => _FormScreenState();
}

class _FormScreenState extends State<FormScreen> {
  Map<String, dynamic>? formData;
  Map<int, dynamic> answersMap = {};
  final _formKey = GlobalKey<FormState>();
  final Map<int, TextEditingController> _controllers = {};
  bool _submitted = false;

  @override
  void initState() {
    super.initState();
    loadJsonData();
  }

  Future<void> loadJsonData() async {
    String jsonString =
        await rootBundle.loadString('assets/data/init_form.json');
    setState(() {
      formData = json.decode(jsonString);
    });
  }

  String? _validateInput(String? value, String format, bool isRequired) {
    if (_submitted && isRequired && (value == null || value.isEmpty)) {
      return 'Este campo es obligatorio';
    }

    if (value != null && value.isNotEmpty) {
      switch (format) {
        case 'email':
          final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
          if (!emailRegex.hasMatch(value)) {
            return 'Ingrese un correo electrónico válido';
          }
          break;
        case 'integer':
          if (int.tryParse(value) == null) {
            return 'Ingrese un número entero válido';
          }
          break;
        case 'double':
          if (double.tryParse(value) == null) {
            return 'Ingrese un número válido';
          }
          break;
      }
    }

    return null;
  }

  void _submitForm() {
    setState(() {
      _submitted = true;
    });

    if (_formKey.currentState!.validate() && _checkRequiredFields()) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Resumen de Respuestas'),
            content: SingleChildScrollView(
              child: ListBody(
                children: answersMap.entries.map((entry) {
                  final questionId = entry.key;
                  final answer = entry.value;
                  final question = formData!['questions']
                      .firstWhere((q) => q['id'] == questionId);

                  if (question['type'] == 'multiple_choice') {
                    final answerKeys = (answer as List)
                        .map((a) => formData!['answers'][question['answers']]
                            .firstWhere((item) => item['text'] == a)['key'])
                        .join(', ');
                    return Text(
                      '${question['question']}: $answerKeys',
                    );
                  } else if (question['type'] == 'single_choice') {
                    final answerKey = formData!['answers'][question['answers']]
                        .firstWhere((item) => item['text'] == answer)['key'];
                    return Text(
                      '${question['question']}: $answerKey',
                    );
                  } else {
                    return Text(
                      '${question['question']}: $answer',
                    );
                  }
                }).toList(),
              ),
            ),
            actions: [
              TextButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Error'),
            content:
                Text('Asegúrate de responder todas las preguntas requeridas'),
            actions: [
              TextButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
  }

  bool _checkRequiredFields() {
    for (var question in formData!['questions']) {
      final questionId = question['id'];
      final isRequired = question['required'] ?? false;

      if (isRequired &&
          (answersMap[questionId] == null || answersMap[questionId].isEmpty)) {
        return false;
      }
    }
    return true;
  }

  @override
  void dispose() {
    _controllers.values.forEach((controller) => controller.dispose());
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (formData == null) {
      return Scaffold(
        appBar: AppBar(title: Text('Formulario de Rutinas')),
        body: Center(child: CircularProgressIndicator()),
      );
    }

    final questions = formData!['questions'];
    final answers = formData!['answers'];

    return Scaffold(
      appBar: AppBar(title: Text('Formulario de Rutinas')),
      body: Form(
        key: _formKey,
        child: ListView.builder(
          itemCount: questions.length,
          itemBuilder: (context, index) {
            final question = questions[index];
            final format = question['format'];
            final questionId = question['id'];
            final isRequired = question['required'] ?? false;

            if (!_controllers.containsKey(questionId)) {
              _controllers[questionId] = TextEditingController(
                text: answersMap[questionId]?.toString() ?? '',
              );
            }

            Widget buildValidationMessage() {
              return (_submitted &&
                      isRequired &&
                      (answersMap[questionId] == null ||
                          answersMap[questionId].isEmpty))
                  ? Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5.0),
                      child: Text(
                        'Este campo es obligatorio',
                        style: TextStyle(color: Colors.red),
                      ),
                    )
                  : Container();
            }

            if (question['type'] == 'open' ||
                question['type'] == 'email' ||
                question['type'] == 'date') {
              return ListTile(
                title: Text(question['question']),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (question['type'] == 'open' ||
                        question['type'] == 'email')
                      TextFormField(
                        controller: _controllers[questionId],
                        onChanged: (value) {
                          setState(() {
                            answersMap[questionId] = value;
                          });
                        },
                      ),
                    if (question['type'] == 'date')
                      TextButton(
                        onPressed: () async {
                          DateTime? pickedDate = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(1900),
                            lastDate: DateTime(2100),
                          );
                          if (pickedDate != null) {
                            setState(() {
                              answersMap[questionId] =
                                  DateFormat('yyyy-MM-dd').format(pickedDate);
                            });
                          }
                        },
                        child: Text(
                          answersMap[questionId] != null
                              ? answersMap[questionId]
                              : 'Seleccionar fecha',
                        ),
                      ),
                    buildValidationMessage(),
                  ],
                ),
              );
            } else if (question['type'] == 'height') {
              return ListTile(
                title: Text(question['question']),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    HeightPicker(
                      initialValue: answersMap[questionId]?.toString() ?? '',
                      onHeightChanged: (value) {
                        setState(() {
                          answersMap[questionId] = value;
                          _controllers[questionId]?.text = value;
                        });
                      },
                    ),
                    buildValidationMessage(),
                  ],
                ),
              );
            } else if (question['type'] == 'weight') {
              return ListTile(
                title: Text(question['question']),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    WeightPicker(
                      initialValue: answersMap[questionId]?.toString() ?? '',
                      onWeightChanged: (value) {
                        setState(() {
                          answersMap[questionId] = value;
                          _controllers[questionId]?.text = value;
                        });
                      },
                    ),
                    buildValidationMessage(),
                  ],
                ),
              );
            } else if (question['type'] == 'single_choice') {
              return ListTile(
                title: Text(question['question']),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    buildValidationMessage(),
                    Column(
                      children: (answers[question['answers']] as List<dynamic>)
                          .map((answer) => RadioListTile(
                                title: Text(answer['text']),
                                value: answer['text'],
                                groupValue: answersMap[questionId],
                                onChanged: (value) {
                                  setState(() {
                                    answersMap[questionId] = value;
                                  });
                                },
                              ))
                          .toList(),
                    ),
                  ],
                ),
              );
            } else if (question['type'] == 'multiple_choice') {
              return ListTile(
                title: Text(question['question']),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    buildValidationMessage(),
                    Column(
                      children: (answers[question['answers']] as List<dynamic>)
                          .map((answer) => CheckboxListTile(
                                title: Text(answer['text']),
                                value: answersMap[questionId] != null &&
                                    (answersMap[questionId] as List)
                                        .contains(answer['text']),
                                onChanged: (value) {
                                  setState(() {
                                    if (value == true) {
                                      if (answersMap[questionId] == null) {
                                        answersMap[questionId] = [
                                          answer['text']
                                        ];
                                      } else {
                                        (answersMap[questionId] as List)
                                            .add(answer['text']);
                                      }
                                    } else {
                                      (answersMap[questionId] as List)
                                          .remove(answer['text']);
                                    }
                                  });
                                },
                              ))
                          .toList(),
                    ),
                  ],
                ),
              );
            }
            return Container();
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _submitForm,
        child: Icon(Icons.send),
      ),
    );
  }
}

class HeightPicker extends StatefulWidget {
  final String initialValue;
  final Function(String) onHeightChanged;

  HeightPicker({required this.initialValue, required this.onHeightChanged});

  @override
  _HeightPickerState createState() => _HeightPickerState();
}

class _HeightPickerState extends State<HeightPicker> {
  bool isMetric = true;
  late TextEditingController heightController;

  @override
  void initState() {
    super.initState();
    heightController = TextEditingController(text: widget.initialValue);
  }

  @override
  void dispose() {
    heightController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextFormField(
            controller: heightController,
            keyboardType: TextInputType.numberWithOptions(decimal: true),
            inputFormatters: [
              FilteringTextInputFormatter.allow(
                RegExp(r'^\d*\.?\d*$'),
              ),
            ],
            decoration: InputDecoration(
              hintText: isMetric ? 'cm' : 'ft',
            ),
            onChanged: (value) {
              widget.onHeightChanged(value + (isMetric ? ' cm' : ' ft'));
            },
          ),
        ),
        Switch(
          value: isMetric,
          onChanged: (value) {
            setState(() {
              isMetric = value;
              heightController.clear();
            });
          },
        ),
        Text(isMetric ? 'cm' : 'ft'),
      ],
    );
  }
}

class WeightPicker extends StatefulWidget {
  final String initialValue;
  final Function(String) onWeightChanged;

  WeightPicker({required this.initialValue, required this.onWeightChanged});

  @override
  _WeightPickerState createState() => _WeightPickerState();
}

class _WeightPickerState extends State<WeightPicker> {
  bool isMetric = true;
  late TextEditingController weightController;

  @override
  void initState() {
    super.initState();
    weightController = TextEditingController(text: widget.initialValue);
  }

  @override
  void dispose() {
    weightController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextFormField(
            controller: weightController,
            keyboardType: TextInputType.numberWithOptions(decimal: true),
            inputFormatters: [
              FilteringTextInputFormatter.allow(
                RegExp(r'^\d*\.?\d*$'),
              ),
            ],
            decoration: InputDecoration(
              hintText: isMetric ? 'kg' : 'lbs',
            ),
            onChanged: (value) {
              widget.onWeightChanged(value + (isMetric ? ' kg' : ' lbs'));
            },
          ),
        ),
        Switch(
          value: isMetric,
          onChanged: (value) {
            setState(() {
              isMetric = value;
              weightController.clear();
            });
          },
        ),
        Text(isMetric ? 'kg' : 'lbs'),
      ],
    );
  }
}

*/


/*import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart'
    show FilteringTextInputFormatter, TextInputFormatter, rootBundle;
import 'package:intl/intl.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: FormScreen(),
    );
  }
}

class FormScreen extends StatefulWidget {
  @override
  _FormScreenState createState() => _FormScreenState();
}

class _FormScreenState extends State<FormScreen> {
  Map<String, dynamic>? formData;
  Map<int, dynamic> answersMap = {};
  final _formKey = GlobalKey<FormState>();
  final Map<int, TextEditingController> _controllers = {};
  bool _submitted = false;

  @override
  void initState() {
    super.initState();
    loadJsonData();
  }

  Future<void> loadJsonData() async {
    String jsonString =
        await rootBundle.loadString('assets/data/init_form.json');
    setState(() {
      formData = json.decode(jsonString);
    });
  }

  String? _validateInput(String? value, String format, bool isRequired) {
    if (_submitted && isRequired && (value == null || value.isEmpty)) {
      return 'Este campo es obligatorio';
    }

    if (value != null && value.isNotEmpty) {
      switch (format) {
        case 'email':
          final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
          if (!emailRegex.hasMatch(value)) {
            return 'Ingrese un correo electrónico válido';
          }
          break;
        case 'integer':
          if (int.tryParse(value) == null) {
            return 'Ingrese un número entero válido';
          }
          break;
        case 'double':
          if (double.tryParse(value) == null) {
            return 'Ingrese un número válido';
          }
          break;
      }
    }

    return null;
  }

  void _submitForm() {
    setState(() {
      _submitted = true;
    });

    if (_formKey.currentState!.validate()) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Resumen de Respuestas'),
            content: SingleChildScrollView(
              child: ListBody(
                children: answersMap.entries.map((entry) {
                  final questionId = entry.key;
                  final answer = entry.value;
                  final question = formData!['questions']
                      .firstWhere((q) => q['id'] == questionId);

                  if (question['type'] == 'multiple_choice') {
                    final answerKeys = (answer as List)
                        .map((a) => formData!['answers'][question['answers']]
                            .firstWhere((item) => item['text'] == a)['key'])
                        .join(', ');
                    return Text(
                      '${question['question']}: $answerKeys',
                    );
                  } else if (question['type'] == 'single_choice') {
                    final answerKey = formData!['answers'][question['answers']]
                        .firstWhere((item) => item['text'] == answer)['key'];
                    return Text(
                      '${question['question']}: $answerKey',
                    );
                  } else {
                    return Text(
                      '${question['question']}: $answer',
                    );
                  }
                }).toList(),
              ),
            ),
            actions: [
              TextButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
  }

  @override
  void dispose() {
    _controllers.values.forEach((controller) => controller.dispose());
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (formData == null) {
      return Scaffold(
        appBar: AppBar(title: Text('Formulario de Rutinas')),
        body: Center(child: CircularProgressIndicator()),
      );
    }

    final questions = formData!['questions'];
    final answers = formData!['answers'];

    return Scaffold(
      appBar: AppBar(title: Text('Formulario de Rutinas')),
      body: Form(
        key: _formKey,
        child: ListView.builder(
          itemCount: questions.length,
          itemBuilder: (context, index) {
            final question = questions[index];
            final format = question['format'];
            final questionId = question['id'];
            final isRequired = question['required'] ?? false;

            if (!_controllers.containsKey(questionId)) {
              _controllers[questionId] = TextEditingController(
                text: answersMap[questionId]?.toString() ?? '',
              );
            }

            Widget buildValidationMessage() {
              return (_submitted &&
                      isRequired &&
                      (answersMap[questionId] == null ||
                          answersMap[questionId].isEmpty))
                  ? Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5.0),
                      child: Text(
                        'Este campo es obligatorio',
                        style: TextStyle(color: Colors.red),
                      ),
                    )
                  : Container();
            }

            if (question['type'] == 'open' ||
                question['type'] == 'email' ||
                question['type'] == 'date') {
              return ListTile(
                title: Text(question['question']),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (question['type'] == 'open' ||
                        question['type'] == 'email')
                      TextFormField(
                        controller: _controllers[questionId],
                        onChanged: (value) {
                          setState(() {
                            answersMap[questionId] = value;
                          });
                        },
                      ),
                    if (question['type'] == 'date')
                      TextButton(
                        onPressed: () async {
                          DateTime? pickedDate = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(1900),
                            lastDate: DateTime(2100),
                          );
                          if (pickedDate != null) {
                            setState(() {
                              answersMap[questionId] =
                                  DateFormat('yyyy-MM-dd').format(pickedDate);
                            });
                          }
                        },
                        child: Text(
                          answersMap[questionId] != null
                              ? answersMap[questionId]
                              : 'Seleccionar fecha',
                        ),
                      ),
                    buildValidationMessage(),
                  ],
                ),
              );
            } else if (question['type'] == 'height') {
              return ListTile(
                title: Text(question['question']),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    HeightPicker(
                      initialValue: answersMap[questionId]?.toString() ?? '',
                      onHeightChanged: (value) {
                        setState(() {
                          answersMap[questionId] = value;
                          _controllers[questionId]?.text = value;
                        });
                      },
                    ),
                    buildValidationMessage(),
                  ],
                ),
              );
            } else if (question['type'] == 'weight') {
              return ListTile(
                title: Text(question['question']),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    WeightPicker(
                      initialValue: answersMap[questionId]?.toString() ?? '',
                      onWeightChanged: (value) {
                        setState(() {
                          answersMap[questionId] = value;
                          _controllers[questionId]?.text = value;
                        });
                      },
                    ),
                    buildValidationMessage(),
                  ],
                ),
              );
            } else if (question['type'] == 'single_choice') {
              return ListTile(
                title: Text(question['question']),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    buildValidationMessage(),
                    Column(
                      children: (answers[question['answers']] as List<dynamic>)
                          .map((answer) => RadioListTile(
                                title: Text(answer['text']),
                                value: answer['text'],
                                groupValue: answersMap[questionId],
                                onChanged: (value) {
                                  setState(() {
                                    answersMap[questionId] = value;
                                  });
                                },
                              ))
                          .toList(),
                    ),
                  ],
                ),
              );
            } else if (question['type'] == 'multiple_choice') {
              return ListTile(
                title: Text(question['question']),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    buildValidationMessage(),
                    Column(
                      children: (answers[question['answers']] as List<dynamic>)
                          .map((answer) => CheckboxListTile(
                                title: Text(answer['text']),
                                value: answersMap[questionId] != null &&
                                    (answersMap[questionId] as List)
                                        .contains(answer['text']),
                                onChanged: (value) {
                                  setState(() {
                                    if (value == true) {
                                      if (answersMap[questionId] == null) {
                                        answersMap[questionId] = [
                                          answer['text']
                                        ];
                                      } else {
                                        (answersMap[questionId] as List)
                                            .add(answer['text']);
                                      }
                                    } else {
                                      (answersMap[questionId] as List)
                                          .remove(answer['text']);
                                    }
                                  });
                                },
                              ))
                          .toList(),
                    ),
                  ],
                ),
              );
            }
            return Container();
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _submitForm,
        child: Icon(Icons.send),
      ),
    );
  }
}

class HeightPicker extends StatefulWidget {
  final String initialValue;
  final Function(String) onHeightChanged;

  HeightPicker({required this.initialValue, required this.onHeightChanged});

  @override
  _HeightPickerState createState() => _HeightPickerState();
}

class _HeightPickerState extends State<HeightPicker> {
  bool isMetric = true;
  late TextEditingController heightController;

  @override
  void initState() {
    super.initState();
    heightController = TextEditingController(text: widget.initialValue);
  }

  @override
  void dispose() {
    heightController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextFormField(
            controller: heightController,
            keyboardType: TextInputType.numberWithOptions(decimal: true),
            inputFormatters: [
              FilteringTextInputFormatter.allow(
                RegExp(r'^\d*\.?\d*$'),
              ),
            ],
            decoration: InputDecoration(
              hintText: isMetric ? 'cm' : 'ft',
            ),
            onChanged: (value) {
              widget.onHeightChanged(value + (isMetric ? ' cm' : ' ft'));
            },
          ),
        ),
        Switch(
          value: isMetric,
          onChanged: (value) {
            setState(() {
              isMetric = value;
              heightController.clear();
            });
          },
        ),
        Text(isMetric ? 'cm' : 'ft'),
      ],
    );
  }
}

class WeightPicker extends StatefulWidget {
  final String initialValue;
  final Function(String) onWeightChanged;

  WeightPicker({required this.initialValue, required this.onWeightChanged});

  @override
  _WeightPickerState createState() => _WeightPickerState();
}

class _WeightPickerState extends State<WeightPicker> {
  bool isMetric = true;
  late TextEditingController weightController;

  @override
  void initState() {
    super.initState();
    weightController = TextEditingController(text: widget.initialValue);
  }

  @override
  void dispose() {
    weightController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextFormField(
            controller: weightController,
            keyboardType: TextInputType.numberWithOptions(decimal: true),
            inputFormatters: [
              FilteringTextInputFormatter.allow(
                RegExp(r'^\d*\.?\d*$'),
              ),
            ],
            decoration: InputDecoration(
              hintText: isMetric ? 'kg' : 'lbs',
            ),
            onChanged: (value) {
              widget.onWeightChanged(value + (isMetric ? ' kg' : ' lbs'));
            },
          ),
        ),
        Switch(
          value: isMetric,
          onChanged: (value) {
            setState(() {
              isMetric = value;
              weightController.clear();
            });
          },
        ),
        Text(isMetric ? 'kg' : 'lbs'),
      ],
    );
  }
}


*/

/*
PRIMERA VERSION FUNCIONAL CON CLAVES


import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart'
    show FilteringTextInputFormatter, TextInputFormatter, rootBundle;
import 'package:intl/intl.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: FormScreen(),
    );
  }
}

class FormScreen extends StatefulWidget {
  @override
  _FormScreenState createState() => _FormScreenState();
}

class _FormScreenState extends State<FormScreen> {
  Map<String, dynamic>? formData;
  Map<int, dynamic> answersMap = {};
  final _formKey = GlobalKey<FormState>();
  final Map<int, TextEditingController> _controllers = {};

  @override
  void initState() {
    super.initState();
    loadJsonData();
  }

  Future<void> loadJsonData() async {
    String jsonString =
        await rootBundle.loadString('assets/data/init_form.json');
    setState(() {
      formData = json.decode(jsonString);
    });
  }

  String? _validateInput(String? value, String format) {
    if (value == null || value.isEmpty) {
      return 'Este campo es obligatorio';
    }

    switch (format) {
      case 'email':
        final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
        if (!emailRegex.hasMatch(value)) {
          return 'Ingrese un correo electrónico válido';
        }
        break;
      case 'integer':
        if (int.tryParse(value) == null) {
          return 'Ingrese un número entero válido';
        }
        break;
      case 'double':
        if (double.tryParse(value) == null) {
          return 'Ingrese un número válido';
        }
        break;
    }

    return null;
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Resumen de Respuestas'),
            content: SingleChildScrollView(
              child: ListBody(
                children: answersMap.entries.map((entry) {
                  final questionId = entry.key;
                  final answer = entry.value;
                  final question = formData!['questions']
                      .firstWhere((q) => q['id'] == questionId);

                  if (question['type'] == 'multiple_choice') {
                    final answerKeys = (answer as List)
                        .map((a) => formData!['answers'][question['answers']]
                            .firstWhere((item) => item['text'] == a)['key'])
                        .join(', ');
                    return Text(
                      '${question['question']}: $answerKeys',
                    );
                  } else if (question['type'] == 'single_choice') {
                    final answerKey = formData!['answers'][question['answers']]
                        .firstWhere((item) => item['text'] == answer)['key'];
                    return Text(
                      '${question['question']}: $answerKey',
                    );
                  } else {
                    return Text(
                      '${question['question']}: $answer',
                    );
                  }
                }).toList(),
              ),
            ),
            actions: [
              TextButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
  }

  @override
  void dispose() {
    _controllers.values.forEach((controller) => controller.dispose());
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (formData == null) {
      return Scaffold(
        appBar: AppBar(title: Text('Formulario de Rutinas')),
        body: Center(child: CircularProgressIndicator()),
      );
    }

    final questions = formData!['questions'];
    final answers = formData!['answers'];

    return Scaffold(
      appBar: AppBar(title: Text('Formulario de Rutinas')),
      body: Form(
        key: _formKey,
        child: ListView.builder(
          itemCount: questions.length,
          itemBuilder: (context, index) {
            final question = questions[index];
            final format = question['format'];
            final questionId = question['id'];

            if (!_controllers.containsKey(questionId)) {
              _controllers[questionId] = TextEditingController(
                text: answersMap[questionId]?.toString() ?? '',
              );
            }

            if (question['type'] == 'open') {
              return ListTile(
                title: Text(question['question']),
                subtitle: TextFormField(
                  controller: _controllers[questionId],
                  validator: (value) => _validateInput(value, format),
                  inputFormatters: format == 'integer'
                      ? [FilteringTextInputFormatter.digitsOnly]
                      : format == 'double'
                          ? [
                              FilteringTextInputFormatter.allow(
                                  RegExp(r'^\d*\.?\d*'))
                            ]
                          : [],
                  onChanged: (value) {
                    setState(() {
                      answersMap[questionId] = value;
                    });
                  },
                ),
              );
            } else if (question['type'] == 'email') {
              return ListTile(
                title: Text(question['question']),
                subtitle: TextFormField(
                  controller: _controllers[questionId],
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) => _validateInput(value, format),
                  onChanged: (value) {
                    setState(() {
                      answersMap[questionId] = value;
                    });
                  },
                ),
              );
            } else if (question['type'] == 'date') {
              return ListTile(
                title: Text(question['question']),
                subtitle: TextButton(
                  onPressed: () async {
                    DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(1900),
                      lastDate: DateTime(2100),
                    );
                    if (pickedDate != null) {
                      setState(() {
                        answersMap[questionId] =
                            DateFormat('yyyy-MM-dd').format(pickedDate);
                      });
                    }
                  },
                  child: Text(
                    answersMap[questionId] != null
                        ? answersMap[questionId]
                        : 'Seleccionar fecha',
                  ),
                ),
              );
            } else if (question['type'] == 'height') {
              return ListTile(
                title: Text(question['question']),
                subtitle: HeightPicker(
                  initialValue: answersMap[questionId]?.toString() ?? '',
                  onHeightChanged: (value) {
                    setState(() {
                      answersMap[questionId] = value;
                      _controllers[questionId]?.text = value;
                    });
                  },
                ),
              );
            } else if (question['type'] == 'weight') {
              return ListTile(
                title: Text(question['question']),
                subtitle: WeightPicker(
                  initialValue: answersMap[questionId]?.toString() ?? '',
                  onWeightChanged: (value) {
                    setState(() {
                      answersMap[questionId] = value;
                      _controllers[questionId]?.text = value;
                    });
                  },
                ),
              );
            } else if (question['type'] == 'single_choice') {
              return ListTile(
                title: Text(question['question']),
                subtitle: Column(
                  children: (answers[question['answers']] as List<dynamic>)
                      .map((answer) => RadioListTile(
                            title: Text(answer['text']),
                            value: answer['text'],
                            groupValue: answersMap[questionId],
                            onChanged: (value) {
                              setState(() {
                                answersMap[questionId] = value;
                              });
                            },
                          ))
                      .toList(),
                ),
              );
            } else if (question['type'] == 'multiple_choice') {
              return ListTile(
                title: Text(question['question']),
                subtitle: Column(
                  children: (answers[question['answers']] as List<dynamic>)
                      .map((answer) => CheckboxListTile(
                            title: Text(answer['text']),
                            value: answersMap[questionId] != null &&
                                (answersMap[questionId] as List)
                                    .contains(answer['text']),
                            onChanged: (value) {
                              setState(() {
                                if (value == true) {
                                  if (answersMap[questionId] == null) {
                                    answersMap[questionId] = [answer['text']];
                                  } else {
                                    (answersMap[questionId] as List)
                                        .add(answer['text']);
                                  }
                                } else {
                                  (answersMap[questionId] as List)
                                      .remove(answer['text']);
                                }
                              });
                            },
                          ))
                      .toList(),
                ),
              );
            }
            return Container();
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _submitForm,
        child: Icon(Icons.send),
      ),
    );
  }
}

class HeightPicker extends StatefulWidget {
  final String initialValue;
  final Function(String) onHeightChanged;

  HeightPicker({required this.initialValue, required this.onHeightChanged});

  @override
  _HeightPickerState createState() => _HeightPickerState();
}

class _HeightPickerState extends State<HeightPicker> {
  bool isMetric = true;
  late TextEditingController heightController;

  @override
  void initState() {
    super.initState();
    heightController = TextEditingController(text: widget.initialValue);
  }

  @override
  void dispose() {
    heightController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextFormField(
            controller: heightController,
            keyboardType: TextInputType.numberWithOptions(decimal: true),
            inputFormatters: [
              FilteringTextInputFormatter.allow(
                RegExp(r'^\d*\.?\d*$'),
              ),
            ],
            decoration: InputDecoration(
              hintText: isMetric ? 'cm' : 'ft',
            ),
            onChanged: (value) {
              widget.onHeightChanged(value + (isMetric ? ' cm' : ' ft'));
            },
          ),
        ),
        Switch(
          value: isMetric,
          onChanged: (value) {
            setState(() {
              isMetric = value;
              heightController.clear();
            });
          },
        ),
        Text(isMetric ? 'cm' : 'ft'),
      ],
    );
  }
}

class WeightPicker extends StatefulWidget {
  final String initialValue;
  final Function(String) onWeightChanged;

  WeightPicker({required this.initialValue, required this.onWeightChanged});

  @override
  _WeightPickerState createState() => _WeightPickerState();
}

class _WeightPickerState extends State<WeightPicker> {
  bool isMetric = true;
  late TextEditingController weightController;

  @override
  void initState() {
    super.initState();
    weightController = TextEditingController(text: widget.initialValue);
  }

  @override
  void dispose() {
    weightController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextFormField(
            controller: weightController,
            keyboardType: TextInputType.numberWithOptions(decimal: true),
            inputFormatters: [
              FilteringTextInputFormatter.allow(
                RegExp(r'^\d*\.?\d*$'),
              ),
            ],
            decoration: InputDecoration(
              hintText: isMetric ? 'kg' : 'lbs',
            ),
            onChanged: (value) {
              widget.onWeightChanged(value + (isMetric ? ' kg' : ' lbs'));
            },
          ),
        ),
        Switch(
          value: isMetric,
          onChanged: (value) {
            setState(() {
              isMetric = value;
              weightController.clear();
            });
          },
        ),
        Text(isMetric ? 'kg' : 'lbs'),
      ],
    );
  }
}

*/

/*
PRIMERA VERSION FUNCIONAL SIN CLAVES

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart'
    show FilteringTextInputFormatter, TextInputFormatter, rootBundle;
import 'package:intl/intl.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: FormScreen(),
    );
  }
}

class FormScreen extends StatefulWidget {
  @override
  _FormScreenState createState() => _FormScreenState();
}

class _FormScreenState extends State<FormScreen> {
  late Map<String, dynamic> formData;
  Map<int, dynamic> answersMap = {};
  final _formKey = GlobalKey<FormState>();
  final Map<int, TextEditingController> _controllers = {};

  @override
  void initState() {
    super.initState();
    loadJsonData();
  }

  Future<void> loadJsonData() async {
    String jsonString =
        await rootBundle.loadString('assets/data/init_form.json');
    setState(() {
      formData = json.decode(jsonString);
    });
  }

  String? _validateInput(String? value, String format) {
    if (value == null || value.isEmpty) {
      return 'Este campo es obligatorio';
    }

    switch (format) {
      case 'email':
        final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
        if (!emailRegex.hasMatch(value)) {
          return 'Ingrese un correo electrónico válido';
        }
        break;
      case 'integer':
        if (int.tryParse(value) == null) {
          return 'Ingrese un número entero válido';
        }
        break;
      case 'double':
        if (double.tryParse(value) == null) {
          return 'Ingrese un número válido';
        }
        break;
    }

    return null;
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Resumen de Respuestas'),
            content: SingleChildScrollView(
              child: ListBody(
                children: answersMap.entries.map((entry) {
                  final questionId = entry.key;
                  final answer = entry.value;
                  final question = formData['questions']
                      .firstWhere((q) => q['id'] == questionId);
                  return Text(
                    '${question['question']}: ${answer.toString()}',
                  );
                }).toList(),
              ),
            ),
            actions: [
              TextButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
  }

  @override
  void dispose() {
    _controllers.values.forEach((controller) => controller.dispose());
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (formData == null) {
      return Scaffold(
        appBar: AppBar(title: Text('Formulario de Rutinas')),
        body: Center(child: CircularProgressIndicator()),
      );
    }

    final questions = formData['questions'];
    final answers = formData['answers'];

    return Scaffold(
      appBar: AppBar(title: Text('Formulario de Rutinas')),
      body: Form(
        key: _formKey,
        child: ListView.builder(
          itemCount: questions.length,
          itemBuilder: (context, index) {
            final question = questions[index];
            final format = question['format'];
            final questionId = question['id'];

            if (!_controllers.containsKey(questionId)) {
              _controllers[questionId] = TextEditingController(
                text: answersMap[questionId]?.toString() ?? '',
              );
            }

            if (question['type'] == 'open') {
              return ListTile(
                title: Text(question['question']),
                subtitle: TextFormField(
                  controller: _controllers[questionId],
                  validator: (value) => _validateInput(value, format),
                  inputFormatters: format == 'integer'
                      ? [FilteringTextInputFormatter.digitsOnly]
                      : format == 'double'
                          ? [
                              FilteringTextInputFormatter.allow(
                                  RegExp(r'^\d*\.?\d*'))
                            ]
                          : [],
                  onChanged: (value) {
                    setState(() {
                      answersMap[questionId] = value;
                    });
                  },
                ),
              );
            } else if (question['type'] == 'email') {
              return ListTile(
                title: Text(question['question']),
                subtitle: TextFormField(
                  controller: _controllers[questionId],
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) => _validateInput(value, format),
                  onChanged: (value) {
                    setState(() {
                      answersMap[questionId] = value;
                    });
                  },
                ),
              );
            } else if (question['type'] == 'date') {
              return ListTile(
                title: Text(question['question']),
                subtitle: TextButton(
                  onPressed: () async {
                    DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(1900),
                      lastDate: DateTime(2100),
                    );
                    if (pickedDate != null) {
                      setState(() {
                        answersMap[questionId] =
                            DateFormat('yyyy-MM-dd').format(pickedDate);
                      });
                    }
                  },
                  child: Text(
                    answersMap[questionId] != null
                        ? answersMap[questionId]
                        : 'Seleccionar fecha',
                  ),
                ),
              );
            } else if (question['type'] == 'height') {
              return ListTile(
                title: Text(question['question']),
                subtitle: HeightPicker(
                  initialValue: answersMap[questionId]?.toString() ?? '',
                  onHeightChanged: (value) {
                    setState(() {
                      answersMap[questionId] = value;
                      _controllers[questionId]?.text = value;
                    });
                  },
                ),
              );
            } else if (question['type'] == 'weight') {
              return ListTile(
                title: Text(question['question']),
                subtitle: WeightPicker(
                  initialValue: answersMap[questionId]?.toString() ?? '',
                  onWeightChanged: (value) {
                    setState(() {
                      answersMap[questionId] = value;
                      _controllers[questionId]?.text = value;
                    });
                  },
                ),
              );
            } else if (question['type'] == 'single_choice') {
              return ListTile(
                title: Text(question['question']),
                subtitle: Column(
                  children: (answers[question['answers']] as List<dynamic>)
                      .map((answer) => RadioListTile(
                            title: Text(answer),
                            value: answer,
                            groupValue: answersMap[questionId],
                            onChanged: (value) {
                              setState(() {
                                answersMap[questionId] = value;
                              });
                            },
                          ))
                      .toList(),
                ),
              );
            } else if (question['type'] == 'multiple_choice') {
              return ListTile(
                title: Text(question['question']),
                subtitle: Column(
                  children: (answers[question['answers']] as List<dynamic>)
                      .map((answer) => CheckboxListTile(
                            title: Text(answer),
                            value: answersMap[questionId] != null &&
                                (answersMap[questionId] as List)
                                    .contains(answer),
                            onChanged: (value) {
                              setState(() {
                                if (value == true) {
                                  if (answersMap[questionId] == null) {
                                    answersMap[questionId] = [answer];
                                  } else {
                                    (answersMap[questionId] as List)
                                        .add(answer);
                                  }
                                } else {
                                  (answersMap[questionId] as List)
                                      .remove(answer);
                                }
                              });
                            },
                          ))
                      .toList(),
                ),
              );
            }
            return Container();
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _submitForm,
        child: Icon(Icons.send),
      ),
    );
  }
}

class HeightPicker extends StatefulWidget {
  final String initialValue;
  final Function(String) onHeightChanged;

  HeightPicker({required this.initialValue, required this.onHeightChanged});

  @override
  _HeightPickerState createState() => _HeightPickerState();
}

class _HeightPickerState extends State<HeightPicker> {
  bool isMetric = true;
  late TextEditingController heightController;

  @override
  void initState() {
    super.initState();
    heightController = TextEditingController(text: widget.initialValue);
  }

  @override
  void dispose() {
    heightController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextFormField(
            controller: heightController,
            keyboardType: TextInputType.numberWithOptions(decimal: true),
            inputFormatters: [
              FilteringTextInputFormatter.allow(
                RegExp(r'^\d*\.?\d*$'),
              ),
            ],
            decoration: InputDecoration(
              hintText: isMetric ? 'cm' : 'ft',
            ),
            onChanged: (value) {
              widget.onHeightChanged(value + (isMetric ? ' cm' : ' ft'));
            },
          ),
        ),
        Switch(
          value: isMetric,
          onChanged: (value) {
            setState(() {
              isMetric = value;
              heightController.clear();
            });
          },
        ),
        Text(isMetric ? 'cm' : 'ft'),
      ],
    );
  }
}

class WeightPicker extends StatefulWidget {
  final String initialValue;
  final Function(String) onWeightChanged;

  WeightPicker({required this.initialValue, required this.onWeightChanged});

  @override
  _WeightPickerState createState() => _WeightPickerState();
}

class _WeightPickerState extends State<WeightPicker> {
  bool isMetric = true;
  late TextEditingController weightController;

  @override
  void initState() {
    super.initState();
    weightController = TextEditingController(text: widget.initialValue);
  }

  @override
  void dispose() {
    weightController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextFormField(
            controller: weightController,
            keyboardType: TextInputType.numberWithOptions(decimal: true),
            inputFormatters: [
              FilteringTextInputFormatter.allow(
                RegExp(r'^\d*\.?\d*$'),
              ),
            ],
            decoration: InputDecoration(
              hintText: isMetric ? 'kg' : 'lbs',
            ),
            onChanged: (value) {
              widget.onWeightChanged(value + (isMetric ? ' kg' : ' lbs'));
            },
          ),
        ),
        Switch(
          value: isMetric,
          onChanged: (value) {
            setState(() {
              isMetric = value;
              weightController.clear();
            });
          },
        ),
        Text(isMetric ? 'kg' : 'lbs'),
      ],
    );
  }
}

*/