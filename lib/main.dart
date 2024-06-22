// ignore_for_file: library_private_types_in_public_api

import 'package:fithub_v1/screens/form_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: FormScreen(),
    );
  }
}

/*
class TrainingInfo {
  final String activityDuration;
  final String trainingDuration;
  final String trainingFrequency;
  final String trainingIntensity;
  String trainingLevel;

  TrainingInfo({
    required this.activityDuration,
    required this.trainingDuration,
    required this.trainingFrequency,
    required this.trainingIntensity,
    this.trainingLevel = '',
  });

  Map<String, dynamic> toJson() => {
        'activityDuration': activityDuration,
        'trainingDuration': trainingDuration,
        'trainingFrequency': trainingFrequency,
        'trainingIntensity': trainingIntensity,
        'trainingLevel': trainingLevel,
      };

  static TrainingInfo fromJson(Map<String, dynamic> json) {
    return TrainingInfo(
      activityDuration: json['activityDuration'],
      trainingDuration: json['trainingDuration'],
      trainingFrequency: json['trainingFrequency'],
      trainingIntensity: json['trainingIntensity'],
      trainingLevel: json['trainingLevel'],
    );
  }
}


int convertDuration(String duration) {
  switch (duration) {
    case 'activity_duration_1to3':
      return 3;
    case 'activity_duration_3to6':
      return 6;
    case 'activity_duration_6to9':
      return 9;
    case 'activity_duration_9to12':
      return 12;
    case 'activity_duration_12to18':
      return 18;
    case 'activity_duration_18to24':
      return 24;
    case 'activity_duration_24plus':
      return 25; // Más de 2 años
    default:
      return 0;
  }
}

int convertFrequency(String frequency) {
  switch (frequency) {
    case 'training_frequency_1perweek':
      return 1;
    case 'training_frequency_2perweek':
      return 2;
    case 'training_frequency_3perweek':
      return 3;
    case 'training_frequency_4perweek':
      return 4;
    case 'training_frequency_5perweek':
      return 5;
    case 'training_frequency_6perweek':
      return 6;
    case 'training_frequency_7perweek':
      return 7;
    default:
      return 0;
  }
}

int convertDurationMinutes(String duration) {
  switch (duration) {
    case 'training_duration_less30':
      return 30;
    case 'training_duration_30to45':
      return 45;
    case 'training_duration_45to60':
      return 60;
    case 'training_duration_60to90':
      return 90;
    case 'training_duration_90plus':
      return 91; // Más de 90 minutos
    default:
      return 0;
  }
}

int convertIntensity(String intensity) {
  switch (intensity) {
    case 'training_intensity_low':
      return 1;
    case 'training_intensity_medium':
      return 2;
    case 'training_intensity_high':
      return 3;
    default:
      return 0;
  }
}


*/
/*

class UsuarioActividadFisica {
  final double tiempoActividadMeses;
  final int frecuenciaSemanal;
  final double duracionSesiones;
  final String intensidad;

  UsuarioActividadFisica(this.tiempoActividadMeses, this.frecuenciaSemanal,
      this.duracionSesiones, this.intensidad);
}

void main() {
  var formController = FormController();

  List<UsuarioActividadFisica> NVP = [
    UsuarioActividadFisica(10, 5, 70, 'Alta'), // Ejemplo NVP #1
    UsuarioActividadFisica(4, 5, 30, 'Media'), // Ejemplo NVP #1
    UsuarioActividadFisica(7, 3, 37.5, 'Media'), // Ejemplo NVP #2
    UsuarioActividadFisica(19, 2, 52.5, 'Media'), // Ejemplo NVP #3
    UsuarioActividadFisica(2, 6, 75, 'Alta'), // Ejemplo NVP #4
    UsuarioActividadFisica(10.5, 2, 91, 'Alta'), // Ejemplo NVP #5
    UsuarioActividadFisica(15, 5, 30, 'Alta'), // Ejemplo NVP #6
    UsuarioActividadFisica(4.5, 4, 52.5, 'Alta'), // Ejemplo NVP #7
    UsuarioActividadFisica(2, 7, 91, 'Alta'), // Ejemplo NVP #8
    UsuarioActividadFisica(20, 4, 25, 'Alta'), // Ejemplo NVP #9
    UsuarioActividadFisica(4.5, 4, 52.5, 'Alta'), // Ejemplo NVI #10
  ];

  List<UsuarioActividadFisica> NVI = [
    UsuarioActividadFisica(4.5, 5, 52.5, 'Media'), // Ejemplo NVI #1
    UsuarioActividadFisica(15, 3, 52.5, 'Media'), // Ejemplo NVI #2
    UsuarioActividadFisica(19, 3, 91, 'Alta'), // Ejemplo NVI #3
    UsuarioActividadFisica(7.5, 3, 52.5, 'Media'), // Ejemplo NVI #4
    UsuarioActividadFisica(10.5, 5, 75, 'Media'), // Ejemplo NVI #5
    UsuarioActividadFisica(
        10.5, 7, 52.5, 'Media'), // Ejemplo NVI #6 - s s s s s s s s s
    UsuarioActividadFisica(10.5, 5, 52.5, 'Alta'), // Ejemplo NVI #7
    UsuarioActividadFisica(7.5, 3, 52.5, 'Media'), // Ejemplo NVI #8
    UsuarioActividadFisica(15, 4, 52.5, 'Alta'), // Ejemplo NVI #9
    UsuarioActividadFisica(19, 3, 52.5, 'Alta'), // Ejemplo NVI #10
    UsuarioActividadFisica(19, 3, 91, 'Media'), // Ejemplo NVI #11
    UsuarioActividadFisica(7.5, 3, 37.5, 'Alta'), // Ejemplo NVP #12
  ];

  List<UsuarioActividadFisica> NVA = [
    UsuarioActividadFisica(19, 6, 52.5, 'Alta'), // Ejemplo NVA #1
    UsuarioActividadFisica(10.5, 6, 75, 'Media'), // Ejemplo NVA #2
    UsuarioActividadFisica(15, 5, 52.5, 'Alta'), // Ejemplo NVA #3
    UsuarioActividadFisica(10.5, 7, 91, 'Media'), // Ejemplo NVA #4
    UsuarioActividadFisica(19, 4, 75, 'Alta'), // Ejemplo NVA #5
    UsuarioActividadFisica(15, 6, 75, 'Media'), // Ejemplo NVA #6
    UsuarioActividadFisica(10.5, 5, 75, 'Alta'), // Ejemplo NVA #7
    UsuarioActividadFisica(19, 5, 52.5, 'Alta'), // Ejemplo NVA #8
    UsuarioActividadFisica(15, 4, 75, 'Alta'), // Ejemplo NVA #9
  ];

  List<UsuarioActividadFisica> EXTRAS = [
    UsuarioActividadFisica(15, 5, 75, 'Alta'), // Ejemplo NVA
    UsuarioActividadFisica(19, 4, 75, 'Media'), // Ejemplo NVI
    UsuarioActividadFisica(15, 4, 62.5, 'Alta'), // Ejemplo NVA
  ];

  List<UsuarioActividadFisica> EXTRAS_Principiante = [
    UsuarioActividadFisica(13, 3, 90, 'Baja'), // Ejemplo #13
    UsuarioActividadFisica(18, 4, 30, 'Alta'), // Ejemplo #14
    UsuarioActividadFisica(3, 7, 30, 'Alta'), // Ejemplo #15
    UsuarioActividadFisica(6, 5, 45, 'Baja'), // Ejemplo #16
    UsuarioActividadFisica(13, 7, 45, 'Baja'), // Ejemplo #17
    UsuarioActividadFisica(19, 7, 90, 'Baja'), // Ejemplo #18
    UsuarioActividadFisica(13, 4, 30, 'Alta'), // Ejemplo #19
    UsuarioActividadFisica(3, 6, 37.5, 'Alta'), // Ejemplo #20
    UsuarioActividadFisica(6, 3, 37.5, 'Media'), // Ejemplo #21
  ];

  List<UsuarioActividadFisica> EXTRAS_Intermedio = [
    UsuarioActividadFisica(4, 7, 75, 'Alta'), // Ejemplo #12
    UsuarioActividadFisica(7, 5, 37.5, 'Media'), // Ejemplo #13
    UsuarioActividadFisica(
        13, 6, 52.5, 'Media'), // Ejemplo #14  s-s-s-s-s-s-s- era 12
    UsuarioActividadFisica(9, 4, 37.5, 'Media'), // Ejemplo #15
    UsuarioActividadFisica(18, 7, 52.5, 'Media'), // Ejemplo #16
    UsuarioActividadFisica(19, 5, 37.5, 'Alta'), // Ejemplo #17 duplicado
    UsuarioActividadFisica(4, 6, 90, 'Alta'), // Ejemplo #18
    UsuarioActividadFisica(7, 6, 37.5, 'Alta'), // Ejemplo #19
    UsuarioActividadFisica(
        13, 7, 52.5, 'Media'), // Ejemplo #20  s-s-s-s-s-s-s- era 12
    UsuarioActividadFisica(7, 3, 37.5, 'Alta'), // Ejemplo #21
    UsuarioActividadFisica(10, 5, 75, 'Media'), // Ejemplo #22
    UsuarioActividadFisica(10, 5, 90, 'Media'), // Ejemplo #23
  ];

  List<UsuarioActividadFisica> EXTRAS_Avanzados = [
    UsuarioActividadFisica(18, 7, 75, 'Media'), // Ejemplo #10
    UsuarioActividadFisica(9, 5, 90, 'Media'), // Ejemplo #11
    UsuarioActividadFisica(13, 7, 52.5, 'Media'), // Ejemplo #12
    UsuarioActividadFisica(19, 4, 90, 'Media'), // Ejemplo #13
    UsuarioActividadFisica(9, 6, 52.5, 'Alta'), // Ejemplo #14
    UsuarioActividadFisica(12, 6, 52.5, 'Alta'), // Ejemplo #15
    UsuarioActividadFisica(18, 7, 52.5, 'Alta'), // Ejemplo #16
    UsuarioActividadFisica(9, 7, 52.5, 'Alta'), // Ejemplo #17
    UsuarioActividadFisica(13, 5, 52.5, 'Alta'), // Ejemplo #18
    UsuarioActividadFisica(19, 6, 52.5, 'Alta'), // Ejemplo #19
    UsuarioActividadFisica(12, 7, 52.5, 'Alta'), // Ejemplo #20
  ];

  testCases('NVP', NVP, formController);
  testCases('NVI', NVI, formController);
  testCases('NVA', NVA, formController);
  testCases('EXTRAS', EXTRAS, formController);
  testCases('EXTRAS_Principiante', EXTRAS_Principiante, formController);
  testCases('EXTRAS_Intermedio', EXTRAS_Intermedio, formController);
  testCases('EXTRAS_Avanzados', EXTRAS_Avanzados, formController);
}

void testCases(String caseName, List<UsuarioActividadFisica> cases,
    FormController formController) {
  print('Testing $caseName:');
  for (var usuario in cases) {
    var trainingInfo = TrainingInfo(
      activityDuration: convertActivityDuration(usuario.tiempoActividadMeses),
      trainingDuration: convertTrainingDuration(usuario.duracionSesiones),
      trainingFrequency: convertTrainingFrequency(usuario.frecuenciaSemanal),
      trainingIntensity: convertTrainingIntensity(usuario.intensidad),
    );
    var level = formController.determineTrainingLevel(trainingInfo);
    print('User: ${jsonEncode(trainingInfo.toJson())}, Level: $level');
  }
}

String convertActivityDuration(double meses) {
  if (meses <= 3) return 'activity_duration_1to3';
  if (meses <= 6) return 'activity_duration_3to6';
  if (meses <= 9) return 'activity_duration_6to9';
  if (meses <= 12) return 'activity_duration_9to12';
  if (meses <= 18) return 'activity_duration_12to18';
  if (meses <= 24) return 'activity_duration_18to24';
  return 'activity_duration_24plus';
}

String convertTrainingDuration(double duracion) {
  if (duracion <= 30) return 'training_duration_less30';
  if (duracion <= 45) return 'training_duration_30to45';
  if (duracion <= 60) return 'training_duration_45to60';
  if (duracion <= 90) return 'training_duration_60to90';
  return 'training_duration_90plus';
}

String convertTrainingFrequency(int frecuencia) {
  switch (frecuencia) {
    case 1:
      return 'training_frequency_1perweek';
    case 2:
      return 'training_frequency_2perweek';
    case 3:
      return 'training_frequency_3perweek';
    case 4:
      return 'training_frequency_4perweek';
    case 5:
      return 'training_frequency_5perweek';
    case 6:
      return 'training_frequency_6perweek';
    case 7:
      return 'training_frequency_7perweek';
    default:
      return '';
  }
}

String convertTrainingIntensity(String intensidad) {
  switch (intensidad) {
    case 'Baja':
      return 'training_intensity_low';
    case 'Media':
      return 'training_intensity_medium';
    case 'Alta':
      return 'training_intensity_high';
    default:
      return '';
  }
}

*/

/*
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

*/
