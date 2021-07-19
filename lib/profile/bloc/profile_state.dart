part of 'profile_bloc.dart';

abstract class ProfileState extends Equatable {
  const ProfileState({this.parent = Parent.empty});
  final Parent parent;

  @override
  List<Object> get props => [];
}

class ProfileInitial extends ProfileState {}

class ProfileSuccess extends ProfileState {
  final Parent parent;

  ProfileSuccess(this.parent);

  @override
  List<Object> get props => [parent];
}
