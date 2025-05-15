import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mybookstore/core/themes/app_colors.dart';
import 'package:mybookstore/core/wrappers/form_validation_manager.dart';

class AppTextFormField extends StatefulWidget {
  final TextEditingController controller;
  final String labelText;
  final bool obscureText;
  final Widget? suffix;
  final TextInputType? keyboardType;
  final TextCapitalization? textCapitalization;
  final VoidCallback? onTapOutside;
  final int? maxLength;
  final void Function(String)? onChanged;
  final void Function(String)? onFieldSubmitted;
  final VoidCallback? updateFields;
  final String? Function(String?) validator;
  final String fieldKey;
  final List<TextInputFormatter>? inputFormatters;
  final FormValidationManager formValidationManager;

  const AppTextFormField({
    super.key,
    required this.controller,
    required this.labelText,
    required this.fieldKey,
    required this.formValidationManager,
    required this.validator,
    this.obscureText = false,
    this.suffix,
    this.keyboardType,
    this.textCapitalization,
    this.maxLength,
    this.onChanged,
    this.onFieldSubmitted,
    this.inputFormatters,
    this.onTapOutside,
    this.updateFields,
  });

  @override
  State<AppTextFormField> createState() => _AppTextFormFieldState();
}

class _AppTextFormFieldState extends State<AppTextFormField> {
  bool _showClearIcon = false;

  void _requestFocus() {
    widget.formValidationManager.getFocusNodeForField(widget.fieldKey).requestFocus();
    widget.updateFields?.call();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _requestFocus,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        decoration: BoxDecoration(
          color: widget.formValidationManager.getFocusNodeForField(widget.fieldKey).hasFocus
              ? AppColors.background
              : AppColors.field,
          borderRadius: BorderRadius.circular(16),
          border: widget.formValidationManager.getFocusNodeForField(widget.fieldKey).hasFocus
              ? Border.all(color: Colors.black, width: 2)
              : null,
        ),
        child: TextFormField(
          onTap: _requestFocus,
          onChanged: (value) {
            if (widget.suffix == null && value.isEmpty) {
              setState(() {
                _showClearIcon = false;
              });
            }
            if (widget.suffix == null && value.length == 1) {
              setState(() {
                _showClearIcon = true;
              });
            }
            if (widget.onChanged != null) widget.onChanged!(value);
          },
          maxLength: widget.maxLength,
          controller: widget.controller,
          obscureText: widget.obscureText,
          keyboardType: widget.keyboardType,
          inputFormatters: widget.inputFormatters,
          onFieldSubmitted: widget.onFieldSubmitted,
          style: Theme.of(context).textTheme.titleMedium,
          maxLengthEnforcement: MaxLengthEnforcement.enforced,
          textCapitalization: widget.textCapitalization ?? TextCapitalization.words,
          focusNode: widget.formValidationManager.getFocusNodeForField(widget.fieldKey),
          validator: widget.formValidationManager.wrapValidator(widget.fieldKey, widget.validator),
          onTapOutside: (_) {
            widget.onTapOutside?.call();
            FocusScope.of(context).unfocus();
          },
          decoration: InputDecoration(
            suffixIcon: widget.suffix ??
                Visibility(
                  visible: _showClearIcon,
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        widget.controller.clear();
                        _showClearIcon = false;
                      });
                    },
                    child: const Icon(Icons.close_rounded),
                  ),
                ),
            labelText: widget.labelText,
          ),
        ),
      ),
    );
  }
}
