import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mybookstore/core/configs/app_config.dart';
import 'package:mybookstore/core/mixins/validator_mixin.dart';
import 'package:mybookstore/core/routes/route_names.dart';
import 'package:mybookstore/core/widgets/app_elevated_button.dart';
import 'package:mybookstore/core/widgets/app_logo_header.dart';
import 'package:mybookstore/core/widgets/app_snackbar.dart';
import 'package:mybookstore/core/widgets/app_text_form_field.dart';
import 'package:mybookstore/core/widgets/obscure_eye_widget.dart';
import 'package:mybookstore/core/wrappers/form_validation_manager.dart';
import 'package:mybookstore/features/auth/ui/bloc/auth_bloc.dart';
import 'package:mybookstore/features/login/ui/blocs/login_bloc.dart';
import 'package:validadores/Validador.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> with ValidatorMixin {
  final _controllerEmail = TextEditingController();
  final _controllerPassword = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  AutovalidateMode _autoValidateMode = AutovalidateMode.disabled;
  final _formValidationManager = FormValidationManager();

  @override
  void dispose() {
    _controllerEmail.dispose();
    _controllerPassword.dispose();
    super.dispose();
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
      child: PopScope(
        canPop: false,
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                spacing: 64,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const AppLogoHeader(),
                  _SignInForm(
                    formKey: _formKey,
                    autoValidateMode: _autoValidateMode,
                    formValidationManager: _formValidationManager,
                    controllerEmail: _controllerEmail,
                    controllerPassword: _controllerPassword,
                  ),
                  _LoginButton(
                    formKey: _formKey,
                    autoValidateMode: _autoValidateMode,
                    formValidationManager: _formValidationManager,
                    controllerEmail: _controllerEmail,
                    controllerPassword: _controllerPassword,
                    onSetAutoValidate: () {
                      setState(() => _autoValidateMode = AutovalidateMode.always);
                    },
                  ),
                  const _CreateAccountInfo(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _SignInForm extends StatefulWidget {
  final GlobalKey<FormState> formKey;
  final AutovalidateMode autoValidateMode;
  final FormValidationManager formValidationManager;
  final TextEditingController controllerEmail;
  final TextEditingController controllerPassword;

  const _SignInForm({
    required this.formKey,
    required this.autoValidateMode,
    required this.formValidationManager,
    required this.controllerEmail,
    required this.controllerPassword,
  });

  @override
  State<_SignInForm> createState() => _SignInFormState();
}

class _SignInFormState extends State<_SignInForm> with ValidatorMixin {
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
            labelText: 'E-mail',
            controller: widget.controllerEmail,
            fieldKey: 'sign_in_email',
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
            labelText: 'Senha',
            controller: widget.controllerPassword,
            fieldKey: 'sign_in_password',
            formValidationManager: widget.formValidationManager,
            obscureText: isObscurePassword,
            keyboardType: TextInputType.visiblePassword,
            textCapitalization: TextCapitalization.none,
            inputFormatters: [LengthLimitingTextInputFormatter(9)],
            updateFields: _updateFocus,
            validator: validatePassword(),
            suffix: ObscureEyeWidget(
              isObscurePassword: isObscurePassword,
              onTap: () => setState(() => isObscurePassword = !isObscurePassword),
            ),
          ),
          Visibility(
            visible: !AppConfig.isProd,
            child: Align(
              alignment: Alignment.centerRight,
              child: InkWell(
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                      AppSnackbar(message: 'Ops... Ainda estamos trabalhando nessa feature', context: context));
                },
                child: Text('Esqueceu sua senha?', style: Theme.of(context).textTheme.titleSmall),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _LoginButton extends StatelessWidget with ValidatorMixin {
  final GlobalKey<FormState> formKey;
  final AutovalidateMode autoValidateMode;
  final FormValidationManager formValidationManager;
  final TextEditingController controllerEmail;
  final TextEditingController controllerPassword;
  final VoidCallback onSetAutoValidate;

  const _LoginButton({
    required this.formKey,
    required this.autoValidateMode,
    required this.formValidationManager,
    required this.controllerEmail,
    required this.controllerPassword,
    required this.onSetAutoValidate,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      builder: (context, state) {
        return AppElevatedButton(
          isLoading: state is LoginLoading,
          onPressed: () {
            var isValid = validateFormState(
              context,
              formKey.currentState!,
              formValidationManager,
              autoValidateMode,
              onSetAutoValidate,
            );

            if (!isValid) return;

            context.read<LoginBloc>().add(
                  SignInButtonPressed(controllerEmail.text, controllerPassword.text),
                );
          },
          child: Text('Entrar', style: Theme.of(context).textTheme.bodySmall),
        );
      },
    );
  }
}

class _CreateAccountInfo extends StatelessWidget {
  const _CreateAccountInfo();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: InkWell(
        onTap: () => Navigator.pushNamed(context, RouteName.signUp),
        child: Text('Cadastre sua loja ', style: Theme.of(context).textTheme.displayMedium),
      ),
    );
  }
}
