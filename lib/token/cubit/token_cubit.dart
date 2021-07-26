import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:form_inputs/form_inputs.dart';
import 'package:formz/formz.dart';
import 'package:key_repository/key_repository.dart';

part 'token_state.dart';

class TokenCubit extends Cubit<TokenState> {
  TokenCubit(this._keyRepository) : super(const TokenState());

  final KeyRepository _keyRepository;

  void tokenChanged(String value) {
    final token = Token.dirty(value);
    emit(state.copyWith(
      token: token,
      status: Formz.validate([
        token,
      ]),
    ));
  }

  // Future<void> tokenSubmitted(FirestoreKey key) async {
  Future<void> tokenSubmitted() async {
    if (!state.status.isValidated) return;
    emit(state.copyWith(status: FormzStatus.submissionInProgress));
    try {
      FirestoreKey? key = await _keyRepository.getKey(state.token.value);
      if (key != null && key.isValid) {
        emit(state.copyWith(status: FormzStatus.submissionSuccess, key: key));
      } else {
        emit(state.copyWith(status: FormzStatus.submissionFailure));
      }
    } catch (e) {
      print('Exception thrown in token_cubit.dart. $e');
      emit(state.copyWith(status: FormzStatus.submissionFailure));
    }
  }
}
