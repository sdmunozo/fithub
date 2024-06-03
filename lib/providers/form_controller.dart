import 'package:fithub_v1/models/heart_rate.dart';
import 'package:fithub_v1/models/height.dart';
import 'package:fithub_v1/models/user_response.dart';
import 'package:fithub_v1/models/weight.dart';
import 'package:get/get.dart';
import 'dart:convert';

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