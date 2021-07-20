part of 'token_cubit.dart';

class TokenState extends Equatable {
  const TokenState({
    this.token = const Token.pure(),
    this.status = FormzStatus.pure,
    this.key,
  });

  final Token token;
  final FormzStatus status;
  final FirestoreKey? key;

  @override
  List<Object> get props => [token, status];

  TokenState copyWith({
    Token? token,
    FormzStatus? status,
    FirestoreKey? key,
  }) {
    return TokenState(
      token: token ?? this.token,
      status: status ?? this.status,
      key: key ?? this.key,
    );
  }
}
