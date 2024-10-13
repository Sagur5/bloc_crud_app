// ignore_for_file: unused_import, depend_on_referenced_packages, avoid_web_libraries_in_flutter

import 'dart:html';
import 'dart:js_util';

import 'package:bloc/bloc.dart';
import 'package:bloc_crud_app/bloc/crud_bloc_event.dart';
import 'package:bloc_crud_app/bloc/crud_bloc_state.dart';

import 'package:bloc_crud_app/user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserListBloc extends Bloc<UserListEvent, UserListState> {
  UserListBloc(BuildContext context) : super(UserListInitial(users: [])) {
    on<AddUser>(_addUser);
    on<DeleteUser>(_deleteUser);
    on<UpdateUser>(_updateUser);
  }

  void _addUser(AddUser event, Emitter<UserListState> emit) {
    final updatedUsers = List<User>.from(state.users)..add(event.user);
    emit(UserListUpdated(users: updatedUsers));
  }

  void _deleteUser(DeleteUser event, Emitter<UserListState> emit) {
    final updatedUsers = List<User>.from(state.users)..remove(event.user);
    emit(UserListUpdated(users: updatedUsers));
  }

  void _updateUser(UpdateUser event, Emitter<UserListState> emit) {
    final updatedUsers = state.users.map((user) {
      return user.id == event.user.id ? event.user : user;
    }).toList();
    emit(UserListUpdated(users: updatedUsers));
  }
}
