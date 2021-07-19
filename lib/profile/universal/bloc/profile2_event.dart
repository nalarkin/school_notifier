part of 'profile2_bloc.dart';

abstract class Profile2Event extends Equatable {
  const Profile2Event();

  @override
  List<Object> get props => [];
}

class Profile2Changed extends Profile2Event {
  Parent parent;

  Profile2Changed(this.parent);

  @override
  List<Object> get props => [parent];
}
