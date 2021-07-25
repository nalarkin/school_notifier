part of 'profile_bloc.dart';

abstract class ProfileState extends Equatable {
  const ProfileState({this.user = FirestoreUser.empty});
  final FirestoreUser user;

  @override
  List<Object> get props => [];
}

class ProfileInitial extends ProfileState {}

class ProfileSuccess extends ProfileState {
  const ProfileSuccess(user) : super(user: user);

  @override
  List<Object> get props => [user];
}
