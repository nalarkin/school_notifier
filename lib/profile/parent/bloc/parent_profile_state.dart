part of 'parent_profile_bloc.dart';

abstract class ParentProfileState extends Equatable {
  const ParentProfileState({this.parent = Parent.empty});
  final Parent parent;

  @override
  List<Object> get props => [];
}

class ParentProfileInitial extends ParentProfileState {}

class ParentProfileSuccess extends ParentProfileState {
  final Parent parent;

  ParentProfileSuccess(this.parent);

  @override
  List<Object> get props => [parent];
}
