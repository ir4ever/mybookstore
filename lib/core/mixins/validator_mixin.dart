import 'package:flutter/material.dart';
import 'package:mybookstore/core/widgets/app_snackbar.dart';
import 'package:mybookstore/core/wrappers/form_validation_manager.dart';

mixin ValidatorMixin {
  bool validateFormState(BuildContext context, FormState state, FormValidationManager formValidationManager,
      AutovalidateMode autovalidateMode, VoidCallback setNewAutovalidateMode) {
    final isValid = state.validate();
    if (autovalidateMode != AutovalidateMode.always) setNewAutovalidateMode();
    if (!isValid) {
      ScaffoldMessenger.of(context)
          .showSnackBar(AppSnackbar(message: 'Preencha todos os dados corretamente!', context: context));
    }
    return isValid;
  }

  FormFieldValidator<String> validatePassword({
    int min = 7,
    int max = 9,
    String? confirmPassword,
  }) =>
      (valor) {
        List<String> errors = [];

        if (valor == null || valor.isEmpty) {
          errors.add('Campo obrigatório');
        }

        if (valor == null || !RegExp(r'[^a-zA-Z0-9\s]').hasMatch(valor)) {
          errors.add('Falta caracter especial');
        }

        if (valor == null || !RegExp(r'[A-Z]').hasMatch(valor)) {
          errors.add('Falta letra maiúscula');
        }

        if (valor == null || valor.length < min) {
          errors.add('Menos de $min dígitos');
        }

        if (valor != null && valor.length > max) {
          errors.add('Mais de $max dígitos');
        }

        if (confirmPassword != null && confirmPassword.isNotEmpty && valor != confirmPassword) {
          errors.add('As senhas não conferem');
        }

        return errors.isEmpty ? null : errors.toString();
      };
}
