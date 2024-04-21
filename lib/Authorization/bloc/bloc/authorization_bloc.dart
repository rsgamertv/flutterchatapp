import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutterchatapp/Model/UserModel/abstract_user_model.dart';
import 'package:get_it/get_it.dart';

part 'authorization_event.dart';
part 'authorization_state.dart';

class AuthorizationBloc extends Bloc<AuthorizationEvent, AuthorizationState> {
  AuthorizationBloc() : super(AuthorizationInitial()) {
    on<AuthorizationEvent>((AuthorizationEvent, AuthorizationState) async{
      emit(AuthorizationLoading());

      if(await GetIt.I<AbstractUserModel>().checkIfExists()){
        emit(AuthorizationLoaded());
      }
      else {
        emit(AuthorizationFailure());
      }
    });
  }
}
