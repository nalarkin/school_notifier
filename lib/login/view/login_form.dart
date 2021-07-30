import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:school_notifier/login/login.dart';
import 'package:school_notifier/sign_up/sign_up.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:formz/formz.dart';
import 'package:school_notifier/token/token.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state.status.isSubmissionFailure) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              const SnackBar(content: Text('Authentication Failure')),
            );
        }
      },
      child: Align(
        alignment: const Alignment(0, -1 / 3),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Academic Advisor',
                style: Theme.of(context).textTheme.headline4,
              ),
              const SizedBox(height: 40.0),
              _EmailInput(),
              const SizedBox(height: 8.0),
              _PasswordInput(),
              const SizedBox(height: 8.0),
              _LoginButton(),
              const SizedBox(height: 40.0),
              _SignUpButton(),
              const SizedBox(height: 4.0),
              _DebugLogin(),
              _DebugLogin2(),
              _DebugLogin3(),
            ],
          ),
        ),
      ),
    );
  }
}

class _EmailInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
      buildWhen: (previous, current) => previous.email != current.email,
      builder: (context, state) {
        return TextField(
          key: const Key('loginForm_emailInput_textField'),
          onChanged: (email) => context.read<LoginCubit>().emailChanged(email),
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
            labelText: 'email',
            helperText: '',
            errorText: state.email.invalid ? 'invalid email' : null,
          ),
        );
      },
    );
  }
}

class _PasswordInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
      buildWhen: (previous, current) => previous.password != current.password,
      builder: (context, state) {
        return TextField(
          key: const Key('loginForm_passwordInput_textField'),
          onChanged: (password) =>
              context.read<LoginCubit>().passwordChanged(password),
          obscureText: true,
          decoration: InputDecoration(
            labelText: 'password',
            helperText: '',
            errorText: state.password.invalid ? 'invalid password' : null,
          ),
        );
      },
    );
  }
}

class _LoginButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BlocBuilder<LoginCubit, LoginState>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        return state.status.isSubmissionInProgress
            ? const CircularProgressIndicator()
            : ElevatedButton(
                key: const Key('loginForm_continue_raisedButton'),
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  primary: const Color(0xFFFFD600),
                ),
                onPressed: state.status.isValidated
                    ? () => context.read<LoginCubit>().logInWithCredentials()
                    : null,
                child: Text(
                  'LOGIN',
                  style: theme.textTheme.button,
                ),
              );
      },
    );
  }
}

class _SignUpButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ElevatedButton(
      key: const Key('loginForm_toTokenNavigation_flatButton'),
      // onPressed: () => Navigator.of(context).push<void>(SignUpPage.route()),
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        primary: const Color(0xFFFFD600),
      ),
      onPressed: () => Navigator.pushNamed(context, TokenPage.routeName),
      // style: TextButton.styleFrom(
      //   // shape: ,
      //   primary: theme.primaryColor,
      // ),
      // onPressed: () => Navigator.of(context).push(SignUpPage.route()),
      child: Text(
        'SIGN UP',
        // style: TextStyle(color: theme.primaryColor),
        style: theme.textTheme.button,
      ),
    );
  }
}
// class _SignUpButton extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     final theme = Theme.of(context);
//     return TextButton(
//       key: const Key('loginForm_createAccount_flatButton'),
//       // onPressed: () => Navigator.of(context).push<void>(SignUpPage.route()),
//       onPressed: () => Navigator.pushNamed(context, SignUpPage.routeName),
//       // onPressed: () => Navigator.of(context).push(SignUpPage.route()),
//       child: Text(
//         'CREATE ACCOUNT',
//         style: TextStyle(color: theme.primaryColor),
//       ),
//     );
//   }
// }

class _DebugLogin extends StatelessWidget {
  final String debugEmail = 'abc@gmail.com';
  final String debugPassword = 'arstarst';

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return TextButton(
      key: const Key('loginForm_debugLogin_textButton'),
      onPressed: () {
        context.read<LoginCubit>().emailChanged(debugEmail);
        context.read<LoginCubit>().passwordChanged(debugPassword);
        context.read<LoginCubit>().logInWithCredentials();
      },
      child: Text(
        'EXAMPLE TEACHER',
        style: TextStyle(color: theme.primaryColor),
      ),
    );
  }
}

class _DebugLogin2 extends StatelessWidget {
  final String debugEmail = '09446@gmail.com';
  final String debugPassword = 'arstarst';

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return TextButton(
      key: const Key('loginForm_debugLogin_textButton'),
      onPressed: () {
        context.read<LoginCubit>().emailChanged(debugEmail);
        context.read<LoginCubit>().passwordChanged(debugPassword);
        context.read<LoginCubit>().logInWithCredentials();
      },
      child: Text(
        'PARENT EXAMPLE',
        style: TextStyle(color: theme.primaryColor),
      ),
    );
  }
}

class _DebugLogin3 extends StatelessWidget {
  final String debugEmail = '432@gmail.com';
  final String debugPassword = 'arstarst';

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return TextButton(
      key: const Key('loginForm_debugLogin_textButton'),
      onPressed: () {
        context.read<LoginCubit>().emailChanged(debugEmail);
        context.read<LoginCubit>().passwordChanged(debugPassword);
        context.read<LoginCubit>().logInWithCredentials();
      },
      child: Text(
        'STUDENT EXAMPLE',
        style: TextStyle(color: theme.primaryColor),
      ),
    );
  }
}
