import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:school_notifier/navigation/navigation.dart';
import 'package:school_notifier/token/token.dart';

class TokenForm extends StatelessWidget {
  const TokenForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<TokenCubit, TokenState>(
      listener: (context, state) {
        if (state.status.isSubmissionSuccess) {
          Navigator.of(context).pop();
          context
              .read<NavigationBloc>()
              .add(NavigationTokenAuthorized(key: state.key));
        } else if (state.status.isSubmissionFailure) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              const SnackBar(content: Text('Token Authentication Failure')),
            );
        }
      },
      child: Align(
        alignment: const Alignment(0, -1 / 3),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _TokenInput(),
            const SizedBox(height: 8.0),
            _SubmitTokenButton(),
          ],
        ),
      ),
    );
  }
}

class _TokenInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TokenCubit, TokenState>(
      buildWhen: (previous, current) => previous.token != current.token,
      builder: (context, state) {
        return TextField(
          key: const Key('signUpForm_emailInput_textField'),
          onChanged: (token) => context.read<TokenCubit>().tokenChanged(token),
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
            labelText: 'token',
            helperText: '',
            errorText: state.token.invalid ? 'invalid token' : null,
          ),
        );
      },
    );
  }
}

class _SubmitTokenButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TokenCubit, TokenState>(
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
                    ? () => context.read<TokenCubit>().tokenSubmitted()
                    : null,
                child: const Text('SIGN UP'),
              );
      },
    );
  }
}
