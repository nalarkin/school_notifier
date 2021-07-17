part of 'parent_profile_bloc.dart';

abstract class ParentProfileEvent extends Equatable {
  const ParentProfileEvent();

  @override
  List<Object> get props => [];
}

class ParentProfileChanged extends ParentProfileEvent {
  Parent parent;

  ParentProfileChanged(this.parent);

  @override
  List<Object> get props => [parent];
}
