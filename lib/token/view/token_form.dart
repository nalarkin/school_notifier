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
            Image.asset(
              'assets/bloc_logo_small.png',
              height: 120,
            ),
            const SizedBox(height: 16.0),
            _TokenPageDescription(),
            const SizedBox(height: 16.0),
            _TokenInput(),
            const SizedBox(height: 8.0),
            _SubmitTokenButton(),
          ],
        ),
      ),
    );
  }
}

class _TokenPageDescription extends StatelessWidget {
  const _TokenPageDescription({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Text(
        "To register an account, use the token that your school emailed you.",
        style: theme.textTheme.bodyText1?.copyWith(color: theme.primaryColor));
  }
}

class _TokenInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TokenCubit, TokenState>(
      buildWhen: (previous, current) => previous.token != current.token,
      builder: (context, state) {
        return TextField(
          key: const Key('signUpForm_tokenInput_textField'),
          onChanged: (token) => context.read<TokenCubit>().tokenChanged(token),
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
            labelText: 'token',
            helperText: '',
            errorText: state.token.invalid
                ? 'invalid token, token must be 20 characters'
                : null,
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
                child: const Text('SUBMIT TOKEN'),
              );
      },
    );
  }
}