part of 'auth_cubit.dart';

abstract class AuthenticationState {}

class AuthenticationInitial extends AuthenticationState {}

class AuthenticationAuthenticated extends AuthenticationState {}

class AuthenticationUnauthenticated extends AuthenticationState {}
