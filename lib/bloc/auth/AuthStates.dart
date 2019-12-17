import 'package:myturn/core/bloc/AbstractState.dart';

enum AuthStates { AuthenticatedState, UnAuthenticatedState }

abstract class AuthState extends AbstractState {
  AuthState() : super();
}

class AuthenticatedState extends AuthState {
  final String displayName;

  AuthenticatedState(this.displayName);

  @override
  List<Object> get props => [displayName];

  @override
  name() {
    return 'Authenticated { displayName: $displayName }';
  }
}

class UnAuthenticatedState extends AuthState {
  final String displayName;

  UnAuthenticatedState(this.displayName);

  @override
  List<Object> get props => [displayName];

  @override
  name() {
    return 'UAuthenticated { displayName: $displayName }';
  }
}
