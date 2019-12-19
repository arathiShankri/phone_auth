import 'package:flutter/material.dart';
import 'package:myturn/bloc/auth/auth_bloc.dart';
import 'package:bloc/bloc.dart';
import 'package:myturn/core/repo/AbstractUserRepo.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AbstractUserRepo _userRepo;

  AuthBloc({@required AbstractUserRepo userRepository})
      : assert(userRepository != null),
        _userRepo = userRepository;

  @override
  AuthState get initialState => UninitializedState();

  @override
  Stream<AuthState> mapEventToState(AuthEvent event) async* {
    switch (event.name()) {
      case AuthEvents.AppStart:
        yield* mapAppStartToState();
        break;
      case AuthEvents.LogIn:
        yield* mapLoginToState(event);
        break;
    }
  }

  /// This method checks if the user is authenticated/logged in and sends back the corresponding state
  Stream<AuthState> mapAppStartToState() async* {
    try {
      final isAuthenticated = await _userRepo.isAuthenticated();
      if (isAuthenticated) {
        yield AuthenticatedState(await _userRepo.getUser());
      } else {
        yield UnAuthenticatedState();
      }
    } catch (_) {
      yield UnAuthenticatedState();
    }
  }

  /// This method sets the state to Authenticated, the actual method that creates Firebase User record is different
  Stream<AuthState> mapLoginToState(AuthEvent event) async* {
    yield AuthenticatedState(await _userRepo.getUser());
  }
}
