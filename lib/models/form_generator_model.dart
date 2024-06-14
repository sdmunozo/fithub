// ignore: implementation_imports
import 'package:flutter/src/widgets/basic.dart';
// ignore: implementation_imports
import 'package:flutter/src/widgets/form.dart';
// ignore: implementation_imports
import 'package:flutter/src/widgets/framework.dart';

class NewForm {
  String id;
  String title;
  String description;
  List<Question> questions;

  NewForm(
      {required this.id,
      required this.title,
      required this.description,
      required this.questions,
      required GlobalKey<FormState> key,
      required Column child});
}

class Question {
  String id;
  String questionText;
  QuestionType questionType;
  List<String> options;

  Question(
      {required this.id,
      required this.questionText,
      required this.questionType,
      required this.options});
}

// ignore: constant_identifier_names
enum QuestionType { Text, MultipleChoice, Checkbox }

class Response {
  String id;
  String formId;
  List<Answer> answers;

  Response({required this.id, required this.formId, required this.answers});
}

class Answer {
  String id;
  String questionId;
  String answerText;

  Answer(
      {required this.id, required this.questionId, required this.answerText});
}
