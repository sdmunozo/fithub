import 'dart:convert';
import 'package:fithub_v1/providers/form_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ResponsesModal extends StatelessWidget {
  const ResponsesModal({super.key});

  @override
  Widget build(BuildContext context) {
    final FormController formController = Get.find<FormController>();

    return AlertDialog(
      title: const Text('Respuestas del Formulario'),
      content: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: formController.responses.map((response) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 5.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Pregunta: ${response['question']}'),
                  Text('Respuesta: ${jsonEncode(response['answer'])}'),
                  const Divider(),
                ],
              ),
            );
          }).toList(),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cerrar'),
        ),
      ],
    );
  }
}



/* Primera version: Antes de estandarizacion


class ResponsesModalWidget extends StatelessWidget {
  const ResponsesModalWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final FormController formController = Get.find<FormController>();

    return AlertDialog(
      title: const Text('Respuestas del Formulario'),
      content: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (formController.userResponse.value != null) ...[
              const Text('Nombre:'),
              Text(formController.userResponse.value!.name),
              const SizedBox(height: 10),
              const Text('Correo Electrónico:'),
              Text(formController.userResponse.value!.email),
              const SizedBox(height: 10),
              const Text('Fecha de Nacimiento:'),
              Text(formController.userResponse.value!.birthDate),
              const SizedBox(height: 20),
            ],
            ...formController.responses.map((response) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 5.0),
                child: Text(jsonEncode(response)),
              );
            }),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cerrar'),
        ),
      ],
    );
  }
}

*/