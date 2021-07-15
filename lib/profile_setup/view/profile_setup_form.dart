import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flow_builder/flow_builder.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:formz/formz.dart';
import 'package:school_notifier/app/app.dart';
import 'package:school_notifier/authentication/authentication.dart';
import '../profile_setup.dart';

class ProfileSetupForm extends StatelessWidget {
  const ProfileSetupForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<ProfileSetupCubit, ProfileSetupState>(
      listener: (context, state) {
        if (state.status.isSubmissionFailure) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              const SnackBar(content: Text('Authentication Failure')),
            );
        } else if (state.status.isSubmissionSuccess) {
          // context.flow<AppStatus>().update((AppStatus) => AppStatus.parent);
          BlocProvider.of<AuthenticationBloc>(context).add(AuthenticationParentAuthenticated(state.parent));
        }
      },
      child: Align(
        alignment: const Alignment(0, -1 / 3),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(
                'assets/bloc_logo_small.png',
                height: 120,
              ),
              const SizedBox(height: 16.0),
              _FirstNameInput(),
              const SizedBox(height: 8.0),
              _LastNameInput(),
              const SizedBox(height: 8.0),
              _StudentNameInput(),
              const SizedBox(height: 8.0),
              _SubmitInfoButton(),
              // const SizedBox(height: 4.0),
              // _DebugLogin(),
            ],
          ),
        ),
      ),
    );
  }
}

class _FirstNameInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileSetupCubit, ProfileSetupState>(
      buildWhen: (previous, current) => previous.firstName != current.firstName,
      builder: (context, state) {
        return TextField(
          key: const Key('profileSetupForm_firstNameInput_textField'),
          onChanged: (firstName) =>
              context.read<ProfileSetupCubit>().firstNameChanged(firstName),
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
    return BlocBuilder<ProfileSetupCubit, ProfileSetupState>(
      buildWhen: (previous, current) => previous.lastName != current.lastName,
      builder: (context, state) {
        return TextField(
          key: const Key('profileSetupForm_lastNameInput_textField'),
          onChanged: (lastName) =>
              context.read<ProfileSetupCubit>().lastNameChanged(lastName),
          keyboardType: TextInputType.text,
          decoration: InputDecoration(
            labelText: 'last name',
            helperText: '',
            errorText: state.firstName.invalid ? 'invalid last name' : null,
          ),
        );
      },
    );
  }
}

class _StudentNameInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileSetupCubit, ProfileSetupState>(
      buildWhen: (previous, current) => previous.lastName != current.lastName,
      builder: (context, state) {
        return TextField(
          key: const Key('profileSetupForm_studentNameInput_textField'),
          onChanged: (studentName) =>
              context.read<ProfileSetupCubit>().studentNameChanged(studentName),
          keyboardType: TextInputType.text,
          decoration: InputDecoration(
            labelText: 'student name',
            helperText: '',
            errorText:
                state.studentName.invalid ? 'invalid student name' : null,
          ),
        );
      },
    );
  }
}

// class _LoginButton extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<ProfileSetupCubit, ProfileSetupState>(
//       buildWhen: (previous, current) => previous.status != current.status,
//       builder: (context, state) {
//         return state.status.isSubmissionInProgress
//             ? const CircularProgressIndicator()
//             : ElevatedButton(
//                 key: const Key('profileSetupForm_loginButton_raisedButton'),
//                 style: ElevatedButton.styleFrom(
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(30.0),
//                   ),
//                   primary: const Color(0xFFFFD600),
//                 ),
//                 onPressed: state.status.isValidated
//                     ? () =>
//                         context.read<ProfileSetupCubit>().logInWithCredentials()
//                     : null,
//                 child: const Text('LOGIN'),
//               );
//       },
//     );
//   }
// }

class _SubmitInfoButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileSetupCubit, ProfileSetupState>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        return state.status.isSubmissionInProgress
            ? const CircularProgressIndicator()
            : ElevatedButton(
                key: const Key('profileSetupForm_submitInfo_raisedButton'),
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  primary: Colors.orangeAccent,
                ),
                onPressed: state.status.isValidated
                    ? () =>
                        context.read<ProfileSetupCubit>().signUpFormSubmitted()
                    : null,
                child: const Text('SUBMIT INFO'),
              );
      },
    );
  }

// class _DebugLogin extends StatelessWidget {
//   final String debugEmail = 'abc@gmail.com';
//   final String debugPassword = 'arstarst';

//   @override
//   Widget build(BuildContext context) {
//     final theme = Theme.of(context);
//     return TextButton(
//       key: const Key('ProfileSetupForm_debugLogin_textButton'),
//       onPressed: () {
//         context.read<ProfileSetupCubit>().emailChanged(debugEmail);
//         context.read<ProfileSetupCubit>().passwordChanged(debugPassword);
//         context.read<ProfileSetupCubit>().logInWithCredentials();
//       },
//       child: Text(
//         'DEBUG LOGIN',
//         style: TextStyle(color: theme.primaryColor),
//       ),
//     );
//   }
}
