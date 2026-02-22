import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/usecases/usecase.dart';
import '../../domain/usecases/get_user.dart';
import '../../domain/usecases/save_user.dart';
import '../../domain/usecases/login_user.dart';
import '../../domain/usecases/register_user.dart';
import 'profile_event.dart';
import 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final GetUser getUser;
  final SaveUser saveUser;
  final LoginUser loginUser;
  final RegisterUser registerUser;

  ProfileBloc({
    required this.getUser,
    required this.saveUser,
    required this.loginUser,
    required this.registerUser,
  }) : super(ProfileInitial()) {
    on<LoadProfileEvent>(_onLoadProfile);
    on<SaveProfileEvent>(_onSaveProfile);
    on<LoginEvent>(_onLogin);
    on<RegisterUserEvent>(_onRegister);
    on<GuestLoginEvent>(_onGuestLogin);
    on<SignOutEvent>(_onSignOut);
  }

  Future<void> _onLoadProfile(
    LoadProfileEvent event,
    Emitter<ProfileState> emit,
  ) async {
    emit(ProfileLoading());
    final result = await getUser(NoParams());
    result.fold((failure) => emit(ProfileError(failure.message)), (user) {
      if (user == null || user.isRegistered) {
        emit(Unauthenticated());
      } else {
        emit(ProfileLoaded(user));
      }
    });
  }

  Future<void> _onLogin(LoginEvent event, Emitter<ProfileState> emit) async {
    emit(ProfileLoading());
    final result = await loginUser(
      LoginParams(email: event.email, password: event.password),
    );
    result.fold(
      (failure) => emit(ProfileError(failure.message)),
      (user) => emit(Authenticated(user)),
    );
  }

  Future<void> _onRegister(
    RegisterUserEvent event,
    Emitter<ProfileState> emit,
  ) async {
    emit(ProfileLoading());
    final result = await registerUser(event.user);
    result.fold(
      (failure) => emit(ProfileError(failure.message)),
      (_) => emit(Authenticated(event.user)),
    );
  }

  void _onGuestLogin(GuestLoginEvent event, Emitter<ProfileState> emit) {
    emit(const ProfileLoaded(null));
  }

  void _onSignOut(SignOutEvent event, Emitter<ProfileState> emit) {
    emit(Unauthenticated());
  }

  Future<void> _onSaveProfile(
    SaveProfileEvent event,
    Emitter<ProfileState> emit,
  ) async {
    emit(ProfileLoading());
    final result = await saveUser(event.user);
    result.fold(
      (failure) => emit(ProfileError(failure.message)),
      (_) => add(LoadProfileEvent()),
    );
  }
}
