// ignore_for_file: prefer_const_constructors
import 'package:form_inputs/form_inputs.dart';
import 'package:school_notifier/profile_setup/cubit/profile_setup_cubit.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:formz/formz.dart';
  
void main() {
  const firstName = FirstName.dirty('firstName');
  const lastName = LastName.dirty('lastName');
  const studentName = StudentName.dirty('student');

  group('ProfileSetupState', () {
    test('supports value comparisons', () {
      expect(ProfileSetupState(), ProfileSetupState());
    });

    test('returns same object when no properties are passed', () {
      expect(ProfileSetupState().copyWith(), ProfileSetupState());
    });

    test('returns object with updated status when status is passed', () {
      expect(
        ProfileSetupState().copyWith(status: FormzStatus.pure),
        ProfileSetupState(status: FormzStatus.pure),
      );
    });

    test('returns object with updated firstName when firstName is passed', () {
      expect(
        ProfileSetupState().copyWith(firstName: firstName),
        ProfileSetupState(firstName: firstName),
      );
    });
    test('returns object with updated lastName when lastName is passed', () {
      expect(
        ProfileSetupState().copyWith(lastName: lastName),
        ProfileSetupState(lastName: lastName),
      );
    });
    test('returns object with updated studentName when studentName is passed',
        () {
      expect(
        ProfileSetupState().copyWith(studentName: studentName),
        ProfileSetupState(studentName: studentName),
      );
    });
  });
}
