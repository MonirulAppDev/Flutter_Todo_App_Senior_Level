import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final int id;
  final String name;
  final String email;
  final String? password;
  final bool isRegistered;
  final String? profileImageUrl;

  const UserEntity({
    required this.id,
    required this.name,
    required this.email,
    this.password,
    this.isRegistered = false,
    this.profileImageUrl,
  });

  @override
  List<Object?> get props => [
    id,
    name,
    email,
    password,
    isRegistered,
    profileImageUrl,
  ];
}
