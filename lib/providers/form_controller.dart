import 'package:fithub_v1/models/heart_rate.dart';
import 'package:fithub_v1/models/height.dart';
import 'package:fithub_v1/models/training_info.dart';
import 'package:fithub_v1/models/user_response.dart';
import 'package:fithub_v1/models/weight.dart';
import 'package:get/get.dart';
import 'dart:convert';

class FormController extends GetxController {
  var currentWidgetIndex = 0.obs;
  //final totalQuestions = 9;
  final totalWidgets = 6;

  Rx<UserResponse?> userResponse = Rx<UserResponse?>(null);
  final responses = <Map<String, dynamic>>[].obs;
  Rx<TrainingInfo?> trainingInfo = Rx<TrainingInfo?>(null);

  void nextQuestion() {
    if (currentWidgetIndex.value < totalWidgets) {
      currentWidgetIndex.value++;
    }
  }
/*
  void nextQuestion() {
    if (currentQuestionIndex.value < totalQuestions) {
      currentQuestionIndex.value++;
    }
  }*/

  void previousQuestion() {
    if (currentWidgetIndex.value > 0) {
      currentWidgetIndex.value--;
    }
  }

  void updateUserResponse(UserResponse response) {
    userResponse.value = response;
    responses
        .add({'question': 'User Information', 'answer': response.toJson()});
  }

  void updateHeight(Height height) {
    responses.add({'question': 'Height', 'answer': height.toJson()});
  }

  void updateWeight(Weight weight) {
    responses.add({'question': 'Weight', 'answer': weight.toJson()});
  }

  void updateHeartRate(HeartRate heartRate) {
    responses.add({'question': 'Heart Rate', 'answer': heartRate.toJson()});
  }

  void updateTrainingInfo(TrainingInfo info) {
    if (info.activityDuration.isNotEmpty &&
        info.trainingDuration.isNotEmpty &&
        info.trainingFrequency.isNotEmpty &&
        info.trainingIntensity.isNotEmpty) {
      info.trainingLevel = determineTrainingLevel(info);
    }

    trainingInfo.value = info;
    responses.add({'question': 'Training Info', 'answer': info.toJson()});
  }

  void printResponses() {
    for (var response in responses) {
      print(jsonEncode(response));
    }
  }

  String determineTrainingLevel(TrainingInfo info) {
    int activityDuration = convertDuration(info.activityDuration);
    int trainingFrequency = convertFrequency(info.trainingFrequency);
    int trainingDuration = convertDurationMinutes(info.trainingDuration);
    int trainingIntensity = convertIntensity(info.trainingIntensity);
    String nvp = "PRINCIPIANTE";
    String nvi = "INTERMEDIO";
    String nva = "AVANZADO";

    if (activityDuration <= 3) {
      return nvp;
    } else if (3 < activityDuration && activityDuration <= 6) {
      if (trainingFrequency < 4 ||
          (trainingFrequency == 4 && trainingDuration <= 60) ||
          (trainingFrequency > 4 && trainingDuration <= 45)) {
        return nvp;
      }
      if (trainingFrequency > 4 &&
          60 <= trainingDuration &&
          trainingDuration <= 90) {
        return nvi;
      }
    } else if (6 < activityDuration && activityDuration <= 9) {
      if (trainingFrequency < 3 ||
          (trainingFrequency == 3 &&
              trainingDuration <= 45 &&
              trainingIntensity <= 2)) {
        return nvp;
      }
    } else if (9 < activityDuration && activityDuration <= 12) {
      if (trainingFrequency < 3 ||
          (trainingFrequency == 3 && trainingDuration < 30) ||
          (trainingFrequency > 4 &&
              trainingDuration < 45 &&
              trainingIntensity <= 2)) {
        return nvp;
      } else if (trainingFrequency == 5 &&
          trainingDuration >= 60 &&
          trainingIntensity == 2) {
        return nvi;
      } else if (trainingFrequency >= 6 &&
          trainingDuration > 60 &&
          trainingIntensity >= 2) {
        return nva;
      } else if (trainingFrequency == 5 &&
          45 <= trainingDuration &&
          trainingDuration <= 60 &&
          trainingIntensity >= 2) {
        return nvi;
      } else if (trainingFrequency == 5 &&
          trainingDuration <= 60 &&
          trainingIntensity >= 2) {
        return nva;
      } else if (trainingFrequency >= 6 &&
          trainingDuration >= 45 &&
          trainingIntensity == 3) {
        return nva;
      }
    } else if (12 <= activityDuration && activityDuration <= 18) {
      if (trainingIntensity == 1) {
        return nvp;
      }
      if (trainingFrequency < 3 ||
          (trainingFrequency <= 7 && trainingDuration <= 30)) {
        return nvp;
      }
    } else if (activityDuration > 18) {
      if (trainingIntensity == 1) {
        return nvp;
      }
      if (trainingFrequency < 3 ||
          (trainingFrequency == 4 && trainingDuration <= 30)) {
        return nvp;
      }
      if (trainingIntensity == 1) {
        return nva;
      }
    }

    if (activityDuration > 3) {
      if (trainingFrequency == 3 &&
          30 <= trainingDuration &&
          trainingDuration <= 45 &&
          trainingIntensity == 3) {
        return nvi;
      } else if (trainingFrequency == 3 &&
          trainingDuration >= 45 &&
          trainingIntensity > 1) {
        return nvi;
      } else if (3 <= trainingFrequency &&
          trainingFrequency <= 4 &&
          trainingDuration >= 45 &&
          trainingIntensity == 2) {
        return nvi;
      } else if (trainingFrequency == 4 &&
          trainingDuration > 60 &&
          trainingIntensity == 2) {
        return nvi;
      } else if (trainingFrequency >= 5 &&
          trainingDuration >= 60 &&
          trainingIntensity == 1) {
        return nvi;
      } else if (trainingFrequency >= 5 &&
          trainingDuration <= 60 &&
          trainingIntensity == 2) {
        return nvi;
      } else if (trainingFrequency == 4 &&
          trainingDuration <= 60 &&
          trainingIntensity >= 2) {
        return nvi;
      } else if (trainingFrequency >= 4 &&
          30 <= trainingDuration &&
          trainingDuration <= 45 &&
          trainingIntensity >= 2) {
        return nvi;
      }
    }

    if ((activityDuration >= 9 &&
            trainingFrequency >= 5 &&
            trainingDuration >= 45 &&
            trainingIntensity > 1) ||
        (activityDuration >= 12 &&
            trainingFrequency == 4 &&
            trainingDuration >= 45 &&
            trainingIntensity == 3)) {
      return nva;
    }

    return '- NO CAYO EN NINGUN NIVEL';
  }
}

/*
  String determineTrainingLevel(TrainingInfo info) {
    int activityDuration = convertDuration(info.activityDuration);
    int trainingFrequency = convertFrequency(info.trainingFrequency);
    int trainingDuration = convertDurationMinutes(info.trainingDuration);
    int trainingIntensity = convertIntensity(info.trainingIntensity);

    // if usuario.tiempo_actividad_meses <= 3:
    if (activityDuration <= 3) {
      return 'PRINCIPIANTE';
    }
    // elif 3 < usuario.tiempo_actividad_meses <= 6:
    else if (3 < activityDuration && activityDuration <= 6) {
      // if usuario.frecuencia_semanal < 4 or (usuario.frecuencia_semanal == 4 and usuario.duracion_sesiones <= 60) or (usuario.frecuencia_semanal > 4 and usuario.duracion_sesiones <= 45):
      if (trainingFrequency < 4 ||
          (trainingFrequency == 4 && trainingDuration <= 60) ||
          (trainingFrequency > 4 && trainingDuration <= 45)) {
        return 'PRINCIPIANTE';
      }
      // if (usuario.frecuencia_semanal > 4 and 60 <= usuario.duracion_sesiones <= 90):
      if (trainingFrequency > 4 &&
          60 <= trainingDuration &&
          trainingDuration <= 90) {
        return 'INTERMEDIO X1';
      }
    }
    // elif 6 < usuario.tiempo_actividad_meses <= 9:
    else if (6 < activityDuration && activityDuration <= 9) {
      // if usuario.frecuencia_semanal < 3 or (usuario.frecuencia_semanal == 3 and usuario.duracion_sesiones <= 45 and intensidad_valor <= 2):
      if (trainingFrequency < 3 ||
          (trainingFrequency == 3 &&
              trainingDuration <= 45 &&
              trainingIntensity <= 2)) {
        return 'PRINCIPIANTE';
      }
    }
    // elif 9 < usuario.tiempo_actividad_meses <= 12:
    else if (9 < activityDuration && activityDuration <= 12) {
      // if usuario.frecuencia_semanal < 3 or (usuario.frecuencia_semanal == 3 and usuario.duracion_sesiones < 30) or (usuario.frecuencia_semanal > 4 and usuario.duracion_sesiones < 45 and intensidad_valor <= 2):
      if (trainingFrequency < 3 ||
          (trainingFrequency == 3 && trainingDuration < 30) ||
          (trainingFrequency > 4 &&
              trainingDuration < 45 &&
              trainingIntensity <= 2)) {
        return 'PRINCIPIANTE';
      }
      // elif (usuario.frecuencia_semanal == 5 and usuario.duracion_sesiones >= 60 and intensidad_valor == 2):
      else if (trainingFrequency == 5 &&
          trainingDuration >= 60 &&
          trainingIntensity == 2) {
        return 'INTERMEDIO X2';
      }
      // elif (usuario.frecuencia_semanal >= 6 and usuario.duracion_sesiones >= 60 and intensidad_valor >= 2):
      else if (trainingFrequency >= 6 &&
          trainingDuration >= 60 &&
          trainingIntensity >= 2) {
        return 'AVANZADO';
      }
      // elif (usuario.frecuencia_semanal == 5 and 45 <= usuario.duracion_sesiones <= 60 and intensidad_valor >= 2):
      else if (trainingFrequency == 5 &&
          45 <= trainingDuration &&
          trainingDuration <= 60 &&
          trainingIntensity >= 2) {
        return 'INTERMEDIO X3';
      }
      // elif (usuario.frecuencia_semanal == 5 and usuario.duracion_sesiones <= 60 and intensidad_valor >= 2):
      else if (trainingFrequency == 5 &&
          trainingDuration <= 60 &&
          trainingIntensity >= 2) {
        return 'AVANZADO';
      }
      // elif (usuario.frecuencia_semanal >= 6 and usuario.duracion_sesiones >= 45 and intensidad_valor == 3):
      else if (trainingFrequency >= 6 &&
          trainingDuration >= 45 &&
          trainingIntensity == 3) {
        return 'AVANZADO';
      }
    }
    // elif (12 <= usuario.tiempo_actividad_meses <= 18):
    else if (12 <= activityDuration && activityDuration <= 18) {
      // if (intensidad_valor == 1):
      if (trainingIntensity == 1) {
        return 'PRINCIPIANTE';
      }
      // if usuario.frecuencia_semanal < 3 or (usuario.frecuencia_semanal <= 7 and usuario.duracion_sesiones <= 30):
      if (trainingFrequency < 3 ||
          (trainingFrequency <= 7 && trainingDuration <= 30)) {
        return 'PRINCIPIANTE';
      }
    }
    // elif usuario.tiempo_actividad_meses > 18:
    else if (activityDuration > 18) {
      // if (intensidad_valor == 1):
      if (trainingIntensity == 1) {
        return 'PRINCIPIANTE';
      }
      // if usuario.frecuencia_semanal < 3 or (usuario.frecuencia_semanal == 4 and usuario.duracion_sesiones <= 30):
      if (trainingFrequency < 3 ||
          (trainingFrequency == 4 && trainingDuration <= 30)) {
        return 'PRINCIPIANTE';
      }
      // if (intensidad_valor == 1):
      if (trainingIntensity == 1) {
        return 'AVANZADO';
      }
    }

    // if usuario.tiempo_actividad_meses > 3:
    if (activityDuration > 3) {
      // if (usuario.frecuencia_semanal == 3 and 30 <= usuario.duracion_sesiones <= 45 and intensidad_valor == 3):
      if (trainingFrequency == 3 &&
          30 <= trainingDuration &&
          trainingDuration <= 45 &&
          trainingIntensity == 3) {
        return 'INTERMEDIO X4';
      }
      // elif (usuario.frecuencia_semanal == 3 and usuario.duracion_sesiones >= 45 and intensidad_valor > 1):
      else if (trainingFrequency == 3 &&
          trainingDuration >= 45 &&
          trainingIntensity > 1) {
        return 'INTERMEDIO X5';
      }
      // elif (3 <= usuario.frecuencia_semanal <= 4 and usuario.duracion_sesiones >= 45 and intensidad_valor == 2):
      else if (3 <= trainingFrequency &&
          trainingFrequency <= 4 &&
          trainingDuration >= 45 &&
          trainingIntensity == 2) {
        return 'INTERMEDIO X6';
      }
      // elif (usuario.frecuencia_semanal == 4 and usuario.duracion_sesiones > 60 and intensidad_valor == 2):
      else if (trainingFrequency == 4 &&
          trainingDuration > 60 &&
          trainingIntensity == 2) {
        return 'INTERMEDIO X7';
      }
      // elif (usuario.frecuencia_semanal >= 5 and usuario.duracion_sesiones >= 60 and intensidad_valor == 1):
      else if (trainingFrequency >= 5 &&
          trainingDuration >= 60 &&
          trainingIntensity == 1) {
        return 'INTERMEDIO X8';
      }
      // elif (usuario.frecuencia_semanal >= 5 and usuario.duracion_sesiones <= 60 and intensidad_valor == 2):
      else if (trainingFrequency >= 5 &&
          trainingDuration <= 60 &&
          trainingIntensity == 2) {
        return 'INTERMEDIO X9';
      }
      // elif (usuario.frecuencia_semanal == 4 and usuario.duracion_sesiones <= 60 and intensidad_valor >= 2):
      else if (trainingFrequency == 4 &&
          trainingDuration <= 60 &&
          trainingIntensity >= 2) {
        return 'INTERMEDIO X10';
      }
      // elif (usuario.frecuencia_semanal >= 4 and 30 <= usuario.duracion_sesiones <= 45 and intensidad_valor >= 2):
      else if (trainingFrequency >= 4 &&
          30 <= trainingDuration &&
          trainingDuration <= 45 &&
          trainingIntensity >= 2) {
        return 'INTERMEDIO X11';
      }
    }

    // Nivel Avanzado
    // if (usuario.tiempo_actividad_meses >= 9 and usuario.frecuencia_semanal >= 5 and usuario.duracion_sesiones >= 45 and intensidad_valor > 1) or (usuario.tiempo_actividad_meses >= 12 and usuario.frecuencia_semanal == 4 and usuario.duracion_sesiones >= 45 and intensidad_valor == 3):
    if ((activityDuration >= 9 &&
            trainingFrequency >= 5 &&
            trainingDuration >= 45 &&
            trainingIntensity > 1) ||
        (activityDuration >= 12 &&
            trainingFrequency == 4 &&
            trainingDuration >= 45 &&
            trainingIntensity == 3)) {
      return 'AVANZADO';
    }

    // Si no cumple con los criterios anteriores, asignar el nivel más bajo
    return '- NO CAYO EN NINGUN NIVEL';
  }
*/




/*
class FormController extends GetxController {
  var currentQuestionIndex = 0.obs;
  final totalQuestions = 4;

  Rx<UserResponse?> userResponse = Rx<UserResponse?>(null);
  final responses = <Map<String, dynamic>>[].obs;

  void nextQuestion() {
    if (currentQuestionIndex.value < totalQuestions) {
      currentQuestionIndex.value++;
    }
  }

  void previousQuestion() {
    if (currentQuestionIndex.value > 0) {
      currentQuestionIndex.value--;
    }
  }

  void updateUserResponse(UserResponse response) {
    userResponse.value = response;
    responses
        .add({'question': 'User Information', 'answer': response.toJson()});
  }

  void updateHeight(Height height) {
    responses.add({'question': 'Height', 'answer': height.toJson()});
  }

  void updateWeight(Weight weight) {
    responses.add({'question': 'Weight', 'answer': weight.toJson()});
  }

  void updateHeartRate(HeartRate heartRate) {
    responses.add({'question': 'Heart Rate', 'answer': heartRate.toJson()});
  }

  void printResponses() {
    for (var response in responses) {
      print(jsonEncode(response));
    }
  }
}

*/

/* Primera version: Antes de estandarizacion

class FormController extends GetxController {
  var currentQuestionIndex = 0.obs;
  final totalQuestions = 4;

  Rx<UserResponse?> userResponse = Rx<UserResponse?>(null);
  final responses = <Map<String, dynamic>>[].obs;

  void nextQuestion() {
    if (currentQuestionIndex.value < totalQuestions - 1) {
      currentQuestionIndex.value++;
    }
  }

  void previousQuestion() {
    if (currentQuestionIndex.value > 0) {
      currentQuestionIndex.value--;
    }
  }

  void updateUserResponse(UserResponse response) {
    userResponse.value = response;
  }

  void addResponse(Map<String, dynamic> response) {
    responses.add(response);
  }

  void printResponses() {
    final summary = {
      'userResponse': userResponse.value?.toJson(),
      'responses': responses
    };
    print(jsonEncode(summary));
  }

  void updateHeight(Height height) {
    addResponse(height.toJson());
  }

  void updateWeight(Weight weight) {
    addResponse(weight.toJson());
  }

  void updateHeartRate(HeartRate heartRate) {
    addResponse(heartRate.toJson());
  }
}

 */