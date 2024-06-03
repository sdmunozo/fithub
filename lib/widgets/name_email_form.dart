import 'dart:convert';
import 'package:fithub_v1/models/user_response.dart';
import 'package:fithub_v1/providers/form_controller.dart';
import 'package:fithub_v1/providers/global_config_provider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NameEmailForm extends StatefulWidget {
  const NameEmailForm({super.key});

  @override
  _NameEmailFormState createState() => _NameEmailFormState();
}

class _NameEmailFormState extends State<NameEmailForm> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _birthDateController = TextEditingController();
  bool _isNextButtonEnabled = false;

  final formController = Get.find<FormController>();

  void _validateForm() {
    final isValid = _nameController.text.length > 3 &&
        RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(_emailController.text) &&
        _birthDateController.text.isNotEmpty;

    setState(() {
      _isNextButtonEnabled = isValid;
    });
  }

  void _onNextPressed() {
    if (_formKey.currentState!.validate()) {
      final userResponse = UserResponse(
        name: _nameController.text,
        email: _emailController.text,
        birthDate: _birthDateController.text,
      );
      formController.updateUserResponse(userResponse);
      formController.nextQuestion();
      print(jsonEncode(userResponse.toJson()));
    }
  }

  @override
  void initState() {
    super.initState();
    _nameController.addListener(_validateForm);
    _emailController.addListener(_validateForm);
    _birthDateController.addListener(_validateForm);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _birthDateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final currentYear = DateTime.now().year;
    final initialDate = DateTime(currentYear - 18);

    return Form(
      key: _formKey,
      child: Container(
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 10),
            TextFormField(
              controller: _nameController,
              decoration: InputDecoration(
                floatingLabelStyle:
                    TextStyle(color: GlobalConfigProvider.color4),
                labelText: 'Nombre',
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: GlobalConfigProvider.color4),
                ),
              ),
            ),
            const SizedBox(height: 5),
            TextFormField(
              controller: _emailController,
              decoration: InputDecoration(
                labelText: 'Correo electrónico',
                floatingLabelStyle:
                    TextStyle(color: GlobalConfigProvider.color4),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: GlobalConfigProvider.color4),
                ),
              ),
            ),
            const SizedBox(height: 5),
            TextFormField(
              controller: _birthDateController,
              readOnly: true,
              decoration: InputDecoration(
                labelText: 'Fecha de nacimiento',
                floatingLabelStyle:
                    TextStyle(color: GlobalConfigProvider.color4),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: GlobalConfigProvider.color4),
                ),
              ),
              onTap: () async {
                final date = await showDatePicker(
                  context: context,
                  initialDate: initialDate,
                  firstDate: DateTime(1900),
                  lastDate: DateTime(currentYear),
                );
                if (date != null) {
                  _birthDateController.text =
                      date.toLocal().toIso8601String().split('T')[0];
                }
              },
            ),
            const SizedBox(height: 30),
            IconButton(
              icon: const Icon(Icons.arrow_forward),
              onPressed: _isNextButtonEnabled ? _onNextPressed : null,
              iconSize: 50,
              color: _isNextButtonEnabled
                  ? GlobalConfigProvider.color4
                  : Colors.grey,
            ),
          ],
        ),
      ),
    );
  }
}


/*import 'dart:convert';
import 'package:fithub_v1/models/user_response.dart';
import 'package:fithub_v1/providers/form_controller.dart';
import 'package:fithub_v1/providers/global_config_provider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NameEmailForm extends StatefulWidget {
  const NameEmailForm({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _NameEmailFormState createState() => _NameEmailFormState();
}

class _NameEmailFormState extends State<NameEmailForm> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _birthDateController = TextEditingController();
  bool _isNextButtonEnabled = false;

  final formController = Get.find<FormController>();

  void _validateForm() {
    final isValid = _nameController.text.length > 3 &&
        RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(_emailController.text) &&
        _birthDateController.text.isNotEmpty;

    setState(() {
      _isNextButtonEnabled = isValid;
    });
  }

  void _onNextPressed() {
    if (_formKey.currentState!.validate()) {
      final userResponse = UserResponse(
        name: _nameController.text,
        email: _emailController.text,
        birthDate: _birthDateController.text,
      );
      formController.userResponse.value = userResponse;
      print(jsonEncode(userResponse.toJson()));
    }
  }

  @override
  void initState() {
    super.initState();
    _nameController.addListener(_validateForm);
    _emailController.addListener(_validateForm);
    _birthDateController.addListener(_validateForm);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _birthDateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final currentYear = DateTime.now().year;
    final initialDate = DateTime(currentYear - 18);

    return Form(
      key: _formKey,
      child: Container(
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 10),
            TextFormField(
              controller: _nameController,
              decoration: InputDecoration(
                floatingLabelStyle:
                    TextStyle(color: GlobalConfigProvider.color4),
                labelText: 'Nombre',
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: GlobalConfigProvider.color4),
                ),
              ),
            ),
            const SizedBox(height: 5),
            TextFormField(
              controller: _emailController,
              decoration: InputDecoration(
                labelText: 'Correo electrónico',
                floatingLabelStyle:
                    TextStyle(color: GlobalConfigProvider.color4),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: GlobalConfigProvider.color4),
                ),
              ),
            ),
            const SizedBox(height: 5),
            TextFormField(
              controller: _birthDateController,
              readOnly: true,
              decoration: InputDecoration(
                labelText: 'Fecha de nacimiento',
                floatingLabelStyle:
                    TextStyle(color: GlobalConfigProvider.color4),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: GlobalConfigProvider.color4),
                ),
              ),
              onTap: () async {
                final date = await showDatePicker(
                  context: context,
                  initialDate: initialDate,
                  firstDate: DateTime(1900),
                  lastDate: DateTime(currentYear),
                );
                if (date != null) {
                  _birthDateController.text =
                      date.toLocal().toIso8601String().split('T')[0];
                }
              },
            ),
            const SizedBox(height: 30),
            IconButton(
              icon: const Icon(Icons.arrow_forward),
              onPressed: _isNextButtonEnabled ? _onNextPressed : null,
              iconSize: 50,
              color: _isNextButtonEnabled
                  ? GlobalConfigProvider.color4
                  : Colors.grey,
            ),
          ],
        ),
      ),
    );
  }
}
*/