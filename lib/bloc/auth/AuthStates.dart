import 'package:myturn/core/bloc/AbstractState.dart';
import 'package:myturn/models/user.dart';

enum AuthStates { UninitializedState, AuthenticatedState, UnAuthenticatedState }

abstract class AuthState extends AbstractState {
  AuthState() : super();
}

class UninitializedState extends AuthState {
  @override
  AuthStates name() {
    return AuthStates.UninitializedState;
  }
}

/// This is the state when user is authenticated and user object is created.
class AuthenticatedState extends AuthState {
  final User user;

  // user is a required parameter to create the Authenticated state
  AuthenticatedState(this.user);

  @override
  List<Object> get props => [];

  @override
  AuthStates name() {
    return AuthStates.AuthenticatedState;
  }
}

/// state when user authentication fails, not sure if its relevant in phone authentication
class UnAuthenticatedState extends AuthState {
  UnAuthenticatedState();

  @override
  List<Object> get props => [];

  @override
  AuthStates name() {
    return AuthStates.UnAuthenticatedState;
  }
}
