import 'package:fithub_v1/models/user_response.dart';
import 'package:get/get.dart';
import 'dart:convert';

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
    for (var response in responses) {
      print(jsonEncode(response));
    }
  }
}


/*
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
    for (var response in responses) {
      print(jsonEncode(response));
    }
  }
}

*/

/*import 'package:fithub_v1/models/user_response.dart';
import 'package:get/get.dart';
import 'dart:convert';

class FormController extends GetxController {
  var currentQuestionIndex = 0.obs;
  final totalQuestions = 3;

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
    for (var response in responses) {
      print(jsonEncode(response));
    }
  }
}*/


/*
class FormController extends GetxController {
  var currentQuestionIndex = 0.obs;
  final totalQuestions = 2;

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
    for (var response in responses) {
      print(response);
    }
  }
}

*/