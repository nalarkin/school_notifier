part of 'profile2_bloc.dart';

abstract class Profile2State extends Equatable {
  const Profile2State({this.parent = Parent.empty});
  final Parent parent;

  @override
  List<Object> get props => [];
}

class Profile2Initial extends Profile2State {}

class Profile2Success extends Profile2State {
  final Parent parent;

  Profile2Success(this.parent);

  @override
  List<Object> get props => [parent];
}
