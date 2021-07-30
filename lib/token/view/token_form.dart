import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:school_notifier/login/login.dart';
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
              .add(NavigationTokenAuthorized(state.key));
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
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Academic Advisor',
                style: Theme.of(context).textTheme.headline4,
              ),
              const SizedBox(height: 25.0),
              _TokenPageDescription(),
              const SizedBox(height: 16.0),
              _TokenInput(),
              const SizedBox(height: 8.0),
              _SubmitTokenButton(),
              const SizedBox(
                height: 8.0,
              ),
              _LoginPageButton(),
              const SizedBox(
                height: 25,
              ),
              _DebugCreateParent(),
              const SizedBox(
                height: 8.0,
              ),
              _DebugCreateTeacher(),
              const SizedBox(
                height: 8.0,
              ),
              _DebugCreateStudent(),
            ],
          ),
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
        style: theme.textTheme.headline6);
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
    final theme = Theme.of(context);
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
                  primary: const Color(0xFFFFD600),
                ),
                onPressed: state.status.isValidated
                    ? () => context.read<TokenCubit>().tokenSubmitted()
                    : null,
                child: Text(
                  'SUBMIT TOKEN',
                  style: theme.textTheme.button,
                ),
              );
      },
    );
  }
}

class _DebugCreateParent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ElevatedButton(
      key: const Key('signUpForm_continue_raisedButton'),
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        primary: Colors.orangeAccent,
      ),
      onPressed: () {
        context.read<TokenCubit>().tokenChanged('MFqeALmMrCsWwYjaRdgC');
        context.read<TokenCubit>().tokenSubmitted();
      },
      child: Text(
        'Use Debug Parent Token',
        style: theme.textTheme.button,
      ),
    );
  }
}

class _DebugCreateTeacher extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ElevatedButton(
      key: const Key('signUpForm_continue_raisedButton'),
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        primary: Colors.orangeAccent,
      ),
      onPressed: () {
        context.read<TokenCubit>().tokenChanged('IMqRRwos9ox3DpFXmnFi');
        context.read<TokenCubit>().tokenSubmitted();
      },
      child: Text(
        'Use Debug Teacher Token',
        style: theme.textTheme.button,
      ),
    );
  }
}

class _DebugCreateStudent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ElevatedButton(
      key: const Key('signUpForm_continue_raisedButton'),
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        primary: Colors.orangeAccent,
      ),
      onPressed: () {
        context.read<TokenCubit>().tokenChanged('qPPRwy6OsmNpiLn1jEEN');
        context.read<TokenCubit>().tokenSubmitted();
      },
      child: Text(
        'Use Debug Student Token',
        style: theme.textTheme.button,
      ),
    );
  }
}

class _LoginPageButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ElevatedButton(
      key: const Key('tokenForm_toSigninNavigation_flatButton'),
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        primary: const Color(0xFFFFD600),
      ),
      // onPressed: () => Navigator.of(context).push<void>(SignUpPage.route()),
      onPressed: () => Navigator.pushNamed(context, LoginPage.routeName),
      // onPressed: () => Navigator.of(context).push(SignUpPage.route()),
      child: Text(
        'LOGIN PAGE',
        style: theme.textTheme.button,
      ),
    );
  }
}
