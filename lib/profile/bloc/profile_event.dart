part of 'profile_bloc.dart';

abstract class ProfileEvent extends Equatable {
  const ProfileEvent();

  @override
  List<Object> get props => [];
}

class ProfileChanged extends ProfileEvent {
  Parent parent;

  ProfileChanged(this.parent);

  @override
  List<Object> get props => [parent];
}
