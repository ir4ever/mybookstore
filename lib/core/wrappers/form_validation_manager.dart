import 'package:flutter/material.dart';

class FormValidationManager {
  final _fieldStates = <String, FormFieldValidationState>{};

  FocusNode getFocusNodeForField(String key) {
    _ensureExists(key);
    return _fieldStates[key]!.focusNode;
  }

  FormFieldValidator<T> wrapValidator<T>(String key, FormFieldValidator<T> validator) {
    _ensureExists(key);

    return (input) {
      final result = validator(input);
      _fieldStates[key]!.hasError = (result?.isNotEmpty ?? false);
      return result;
    };
  }

  List<FormFieldValidationState> get erroredFields =>
      _fieldStates.entries.where((s) => s.value.hasError).map((s) => s.value).toList();

  void validateField(String key) {
    if (_fieldStates.containsKey(key)) {
      _fieldStates[key]!.focusNode.unfocus();
      _fieldStates[key]!.focusNode.requestFocus();
    }
  }

  void _ensureExists(String key) {
    _fieldStates[key] ??= FormFieldValidationState(key: key);
  }

  void dispose() {
    for (var state in _fieldStates.values) {
      state.focusNode.dispose();
    }
  }
}

class FormFieldValidationState {
  final String key;
  bool hasError;
  FocusNode focusNode;

  FormFieldValidationState({required this.key}) : hasError = false, focusNode = FocusNode();
}
