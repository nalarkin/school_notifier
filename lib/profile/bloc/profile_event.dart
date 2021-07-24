part of 'profile_bloc.dart';

abstract class ProfileEvent extends Equatable {
  const ProfileEvent({this.user = FirestoreUser.empty});

  final FirestoreUser user;

  @override
  List<Object> get props => [user];
}

class ProfileChanged extends ProfileEvent {
  ProfileChanged(user) : super(user: user);

  @override
  List<Object> get props => [user];
}
