import 'package:equatable/equatable.dart';
import '../../domain/entities/user_entity.dart';

abstract class ProfileEvent extends Equatable {
  const ProfileEvent();

  @override
  List<Object?> get props => [];
}

class LoadProfileEvent extends ProfileEvent {}

class LoginEvent extends ProfileEvent {
  final String email;
  final String password;
  const LoginEvent(this.email, this.password);

  @override
  List<Object?> get props => [email, password];
}

class RegisterUserEvent extends ProfileEvent {
  final UserEntity user;
  const RegisterUserEvent(this.user);

  @override
  List<Object?> get props => [user];
}

class GuestLoginEvent extends ProfileEvent {}

class SignOutEvent extends ProfileEvent {}

class SaveProfileEvent extends ProfileEvent {
  final UserEntity user;
  const SaveProfileEvent(this.user);

  @override
  List<Object?> get props => [user];
}
