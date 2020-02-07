import 'package:flutter_simple_dependency_injection/Injector.dart';
import 'package:myturn/bloc/auth/auth_bloc.dart';
import 'package:myturn/injection/MainModule.dart';
import 'package:myturn/repo/FirebaseAuthRepo.dart';

//all modules are singletons
class AuthModule extends AbstractModule {
  static final AuthModule _authModule = AuthModule._internal();

  factory AuthModule() {
    return _authModule;
  }

  AuthModule._internal();

  @override
  void configure(Injector injector) {
    //states
    injector.map<UninitializedState>((i) => UninitializedState(), isSingleton: false);
    injector.mapWithParams<AuthenticatedState>((i, p) => AuthenticatedState(user: p['user']));
    injector.map<UnAuthenticatedState>((i) => UnAuthenticatedState(), isSingleton: false);
    injector.map<CodeSentState>((i) => CodeSentState(), isSingleton: false);

    //events
    injector.map<AppStart>((i) => AppStart());
    injector.mapWithParams<SendCode>((i, p) => SendCode(phoneNumber: p['phoneNumber']));
    injector.mapWithParams<ResendCode>((i, p) => ResendCode(phoneNumber: p['phoneNumber']));
    injector.mapWithParams<VerifyPhoneNumber>((i, p) => VerifyPhoneNumber(smsCode: p['smsCode']));

    //bloc
    injector.map<AuthBloc>((i) => AuthBloc(authRepo: i.get<FirebaseAuthRepo>()), isSingleton: true);
  } // end of configure method

}
