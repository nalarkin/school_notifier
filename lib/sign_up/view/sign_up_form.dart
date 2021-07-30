import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:key_repository/key_repository.dart';
import 'package:school_notifier/navigation/navigation.dart';
import 'package:school_notifier/sign_up/sign_up.dart';
import 'package:formz/formz.dart';

class SignUpForm extends StatelessWidget {
  const SignUpForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<SignUpCubit, SignUpState>(
      listener: (context, state) {
        if (state.status.isSubmissionSuccess) {
          /// can show success message if desired
        } else if (state.status.isSubmissionFailure) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              const SnackBar(content: Text('Sign Up Failure')),
            );
        }
      },
      child: Align(
        alignment: const Alignment(0, -1 / 3),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 16.0),
              _LoginInfomationText(),
              const SizedBox(height: 8.0),
              _EmailInput(),
              const SizedBox(height: 8.0),
              _PasswordInput(),
              const SizedBox(height: 8.0),
              _ConfirmPasswordInput(),
              const SizedBox(
                height: 8.0,
              ),
              _ProfileInfoText(),
              const SizedBox(height: 8.0),
              _FirstNameInput(),
              const SizedBox(height: 8.0),
              _LastNameInput(),
              const SizedBox(height: 8.0),
              // if (context.watch<NavigationBloc>().state.key?.isParent ?? false)
              //   _StudentNameInput(),
              const SizedBox(height: 8.0),
              _SignUpButton(),
            ],
          ),
        ),
      ),
    );
  }
}

class _LoginInfomationText extends StatelessWidget {
  const _LoginInfomationText({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Text("create your login info", style: theme.textTheme.bodyText1);
  }
}

class _EmailInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpCubit, SignUpState>(
      buildWhen: (previous, current) => previous.email != current.email,
      builder: (context, state) {
        return TextField(
          key: const Key('signUpForm_emailInput_textField'),
          onChanged: (email) => context.read<SignUpCubit>().emailChanged(email),
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
    return BlocBuilder<SignUpCubit, SignUpState>(
      buildWhen: (previous, current) => previous.password != current.password,
      builder: (context, state) {
        return TextField(
          key: const Key('signUpForm_passwordInput_textField'),
          onChanged: (password) =>
              context.read<SignUpCubit>().passwordChanged(password),
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

class _ConfirmPasswordInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpCubit, SignUpState>(
      buildWhen: (previous, current) =>
          previous.password != current.password ||
          previous.confirmedPassword != current.confirmedPassword,
      builder: (context, state) {
        return TextField(
          key: const Key('signUpForm_confirmedPasswordInput_textField'),
          onChanged: (confirmPassword) => context
              .read<SignUpCubit>()
              .confirmedPasswordChanged(confirmPassword),
          obscureText: true,
          decoration: InputDecoration(
            labelText: 'confirm password',
            helperText: '',
            errorText: state.confirmedPassword.invalid
                ? 'passwords do not match'
                : null,
          ),
        );
      },
    );
  }
}

class _ProfileInfoText extends StatelessWidget {
  const _ProfileInfoText({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Text("add your profile info", style: theme.textTheme.bodyText1);
  }
}

class _FirstNameInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpCubit, SignUpState>(
      buildWhen: (previous, current) => previous.firstName != current.firstName,
      builder: (context, state) {
        return TextField(
          key: const Key('signUpPage_firstNameInput_textField'),
          onChanged: (firstName) =>
              context.read<SignUpCubit>().firstNameChanged(firstName),
          keyboardType: TextInputType.text,
          decoration: InputDecoration(
            labelText: 'first name',
            helperText: '',
            errorText: state.firstName.invalid ? 'invalid first name' : null,
          ),
        );
      },
    );
  }
}

class _LastNameInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpCubit, SignUpState>(
      buildWhen: (previous, current) => previous.lastName != current.lastName,
      builder: (context, state) {
        return TextField(
          key: const Key('profileSetupForm_lastNameInput_textField'),
          onChanged: (lastName) =>
              context.read<SignUpCubit>().lastNameChanged(lastName),
          keyboardType: TextInputType.text,
          decoration: InputDecoration(
            labelText: 'last name',
            helperText: '',
            errorText: state.lastName.invalid ? 'invalid last name' : null,
          ),
        );
      },
    );
  }
}

// class _StudentNameInput extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<SignUpCubit, SignUpState>(
//       buildWhen: (previous, current) => previous.lastName != current.lastName,
//       builder: (context, state) {
//         return TextField(
//           key: const Key('profileSetupForm_studentNameInput_textField'),
//           onChanged: (studentName) =>
//               context.read<SignUpCubit>().studentNameChanged(studentName),
//           keyboardType: TextInputType.text,
//           decoration: InputDecoration(
//             labelText: 'student name',
//             helperText: '',
//             errorText:
//                 state.studentName.invalid ? 'invalid student name' : null,
//           ),
//         );
//       },
//     );
//   }
// }

class _SignUpButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpCubit, SignUpState>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        return state.status.isSubmissionInProgress
            ? const CircularProgressIndicator()
            : ElevatedButton(
                key: const Key('signUpForm_continue_raisedButton'),
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  primary: Colors.orangeAccent,
                ),
                onPressed: state.status.isValidated
                    ? () => context.read<SignUpCubit>().signUpFormSubmitted()
                    : null,
                child: const Text('SIGN UP'),
              );
      },
    );
  }
}
