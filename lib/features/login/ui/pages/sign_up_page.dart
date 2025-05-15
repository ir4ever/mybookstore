import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mybookstore/core/mixins/validator_mixin.dart';
import 'package:mybookstore/core/widgets/app_elevated_button.dart';
import 'package:mybookstore/core/widgets/app_logo_header.dart';
import 'package:mybookstore/core/widgets/app_snackbar.dart';
import 'package:mybookstore/core/widgets/app_text_form_field.dart';
import 'package:mybookstore/core/widgets/custom_app_bar.dart';
import 'package:mybookstore/core/widgets/obscure_eye_widget.dart';
import 'package:mybookstore/core/wrappers/form_validation_manager.dart';
import 'package:mybookstore/features/auth/ui/bloc/auth_bloc.dart';
import 'package:mybookstore/features/login/ui/blocs/login_bloc.dart';
import 'package:mybookstore/features/store/domain/entities/admin_store_entity.dart';
import 'package:mybookstore/features/user/domain/entities/admin_user_entity.dart';
import 'package:validadores/Validador.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> with ValidatorMixin {
  final _formKey = GlobalKey<FormState>();
  AutovalidateMode _autoValidateMode = AutovalidateMode.disabled;
  final _formValidationManager = FormValidationManager();

  final _controllerEmail = TextEditingController();
  final _controllerStoreName = TextEditingController();
  final _controllerSlogan = TextEditingController();
  final _controllerBanner = TextEditingController();
  final _controllerAdmName = TextEditingController();
  final _controllerAdmPhoto = TextEditingController();
  final _controllerPassword = TextEditingController();
  final _controllerConfirmPassword = TextEditingController();

  @override
  void dispose() {
    _controllerEmail.dispose();
    _controllerStoreName.dispose();
    _controllerSlogan.dispose();
    _controllerBanner.dispose();
    _controllerAdmName.dispose();
    _controllerAdmPhoto.dispose();
    _controllerPassword.dispose();
    _controllerConfirmPassword.dispose();
    super.dispose();
  }

  AdminStoreEntity _createAdminStoreEntity() {
    return AdminStoreEntity(
      name: _controllerStoreName.text,
      slogan: _controllerSlogan.text,
      banner: _controllerBanner.text,
      admin: AdminUserEntity(
        name: _controllerAdmName.text,
        userName: _controllerEmail.text,
        photo: _controllerAdmPhoto.text,
        password: _controllerPassword.text,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state is LoginError) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(AppSnackbar(message: state.message, context: context));
        }
        if (state is LoginSuccess) {
          context.read<AuthBloc>().add(AuthSignInEvent());
        }
      },
      child: Scaffold(
        appBar: CustomAppBar(text: 'Cadastrar loja'),
        bottomNavigationBar: _SignUpButton(
          formKey: _formKey,
          formValidationManager: _formValidationManager,
          autoValidateMode: _autoValidateMode,
          adminStoreEntity: _createAdminStoreEntity,
          onEnableAutoValidate: () => setState(() => _autoValidateMode = AutovalidateMode.always),
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                spacing: 32,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const AppLogoHeader(),
                  _SignUpForm(
                    formKey: _formKey,
                    autoValidateMode: _autoValidateMode,
                    formValidationManager: _formValidationManager,
                    controllerEmail: _controllerEmail,
                    controllerStoreName: _controllerStoreName,
                    controllerSlogan: _controllerSlogan,
                    controllerBanner: _controllerBanner,
                    controllerAdmName: _controllerAdmName,
                    controllerAdmPhoto: _controllerAdmPhoto,
                    controllerPassword: _controllerPassword,
                    controllerConfirmPassword: _controllerConfirmPassword,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _SignUpButton extends StatelessWidget with ValidatorMixin {
  final GlobalKey<FormState> formKey;
  final FormValidationManager formValidationManager;
  final AutovalidateMode autoValidateMode;
  final VoidCallback onEnableAutoValidate;
  final AdminStoreEntity Function() adminStoreEntity;

  const _SignUpButton({
    required this.formKey,
    required this.formValidationManager,
    required this.autoValidateMode,
    required this.onEnableAutoValidate,
    required this.adminStoreEntity,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(builder: (context, state) {
      return Padding(
        padding: const EdgeInsets.all(24),
        child: AppElevatedButton(
          isLoading: state is LoginLoading,
          onPressed: () {
            final isValid = validateFormState(
              context,
              formKey.currentState!,
              formValidationManager,
              autoValidateMode,
              onEnableAutoValidate,
            );

            if (!isValid) return;

            final adminStore = adminStoreEntity();
            context.read<LoginBloc>().add(SignUpButtonPressed(adminStore));
          },
          child: Text('Salvar', style: Theme.of(context).textTheme.bodySmall),
        ),
      );
    });
  }
}

class _SignUpForm extends StatefulWidget {
  final GlobalKey<FormState> formKey;
  final AutovalidateMode autoValidateMode;
  final FormValidationManager formValidationManager;
  final TextEditingController controllerEmail;
  final TextEditingController controllerStoreName;
  final TextEditingController controllerSlogan;
  final TextEditingController controllerBanner;
  final TextEditingController controllerAdmName;
  final TextEditingController controllerAdmPhoto;
  final TextEditingController controllerPassword;
  final TextEditingController controllerConfirmPassword;

  const _SignUpForm({
    required this.formKey,
    required this.autoValidateMode,
    required this.formValidationManager,
    required this.controllerStoreName,
    required this.controllerEmail,
    required this.controllerSlogan,
    required this.controllerBanner,
    required this.controllerAdmName,
    required this.controllerAdmPhoto,
    required this.controllerPassword,
    required this.controllerConfirmPassword,
  });

  @override
  State<_SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<_SignUpForm> with ValidatorMixin {
  bool isObscurePassword = true;

  //NAO EH O IDEAL MAS NAO DA PRA GASTAR TEMPO AQUI
  //O FORMVALIDATIONMANAGER FOI PENSANDO PARA USAR DIRETAMENTE NO TEXTFORMFIELD
  //COMO ESTA EMBRULHADO ACABA CAUSANDO ESSA NECESSIDADE DE ESTADO
  void _updateFocus() => setState(() {});

  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKey,
      autovalidateMode: widget.autoValidateMode,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 16,
        children: [
          AppTextFormField(
            labelText: 'Nome da loja',
            controller: widget.controllerStoreName,
            fieldKey: 'sign_up_store_name',
            formValidationManager: widget.formValidationManager,
            keyboardType: TextInputType.name,
            updateFields: _updateFocus,
            inputFormatters: [LengthLimitingTextInputFormatter(128)],
            validator: (value) => Validador().add(Validar.OBRIGATORIO, msg: 'Campo obrigatório').valido(value),
          ),
          AppTextFormField(
            labelText: 'Slogan da loja',
            controller: widget.controllerSlogan,
            fieldKey: 'sign_up_slogan',
            formValidationManager: widget.formValidationManager,
            textCapitalization: TextCapitalization.sentences,
            keyboardType: TextInputType.text,
            updateFields: _updateFocus,
            inputFormatters: [LengthLimitingTextInputFormatter(128)],
            validator: (value) => Validador().add(Validar.OBRIGATORIO, msg: 'Campo obrigatório').valido(value),
          ),
          AppTextFormField(
            labelText: 'Banner da loja',
            controller: widget.controllerBanner,
            fieldKey: 'sign_up_banner',
            formValidationManager: widget.formValidationManager,
            textCapitalization: TextCapitalization.none,
            keyboardType: TextInputType.text,
            updateFields: _updateFocus,
            validator: (value) => Validador().add(Validar.OBRIGATORIO, msg: 'Campo obrigatório').valido(value),
          ),
          AppTextFormField(
            labelText: 'E-mail do administrador',
            controller: widget.controllerEmail,
            fieldKey: 'sign_up_email',
            formValidationManager: widget.formValidationManager,
            keyboardType: TextInputType.emailAddress,
            textCapitalization: TextCapitalization.none,
            updateFields: _updateFocus,
            inputFormatters: [LengthLimitingTextInputFormatter(128)],
            validator: (valor) => Validador()
                .add(Validar.OBRIGATORIO, msg: 'Campo obrigatório')
                .add(Validar.EMAIL, msg: 'E-mail inválido')
                .valido(valor),
          ),
          AppTextFormField(
            labelText: 'Nome do administrador',
            controller: widget.controllerAdmName,
            fieldKey: 'sign_up_adm_name',
            formValidationManager: widget.formValidationManager,
            keyboardType: TextInputType.name,
            updateFields: _updateFocus,
            inputFormatters: [LengthLimitingTextInputFormatter(128)],
            validator: (value) => Validador().add(Validar.OBRIGATORIO, msg: 'Campo obrigatório').valido(value),
          ),
          AppTextFormField(
            labelText: 'Foto do administrador',
            controller: widget.controllerAdmPhoto,
            fieldKey: 'sign_up_adm_photo',
            textCapitalization: TextCapitalization.none,
            formValidationManager: widget.formValidationManager,
            keyboardType: TextInputType.text,
            updateFields: _updateFocus,
            validator: (value) => Validador().add(Validar.OBRIGATORIO, msg: 'Campo obrigatório').valido(value),
          ),
          AppTextFormField(
            labelText: 'Senha',
            controller: widget.controllerPassword,
            fieldKey: 'sign_up_password',
            obscureText: isObscurePassword,
            updateFields: _updateFocus,
            formValidationManager: widget.formValidationManager,
            keyboardType: TextInputType.visiblePassword,
            textCapitalization: TextCapitalization.none,
            inputFormatters: [LengthLimitingTextInputFormatter(9)],
            validator: validatePassword(),
            suffix: ObscureEyeWidget(
              isObscurePassword: isObscurePassword,
              onTap: () => setState(() => isObscurePassword = !isObscurePassword),
            ),
          ),
          AppTextFormField(
            labelText: 'Repetir senha',
            controller: widget.controllerConfirmPassword,
            fieldKey: 'sign_up_confirm_password',
            obscureText: isObscurePassword,
            updateFields: _updateFocus,
            formValidationManager: widget.formValidationManager,
            keyboardType: TextInputType.visiblePassword,
            textCapitalization: TextCapitalization.none,
            inputFormatters: [LengthLimitingTextInputFormatter(9)],
            validator: validatePassword(confirmPassword: widget.controllerPassword.text),
            suffix: ObscureEyeWidget(
              isObscurePassword: isObscurePassword,
              onTap: () => setState(() => isObscurePassword = !isObscurePassword),
            ),
          ),
        ],
      ),
    );
  }
}
