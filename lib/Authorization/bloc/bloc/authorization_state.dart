part of 'authorization_bloc.dart';

@immutable
abstract class AuthorizationState{
  @override
  List<Object> get props => [];
}

class AuthorizationInitial extends AuthorizationState {}

class AuthorizationLoading extends AuthorizationState{}

class AuthorizationLoaded extends AuthorizationState{}

class AuthorizationFailure extends AuthorizationState{}