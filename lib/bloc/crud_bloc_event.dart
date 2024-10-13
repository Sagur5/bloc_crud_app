// ignore_for_file: non_constant_identifier_names

import 'package:bloc_crud_app/user_model.dart';

abstract class UserListEvent {}

class AddUser extends UserListEvent {
  final User user;
  AddUser({required this.user});
}

class DeleteUser extends UserListEvent {
  final User user;
  DeleteUser({required this.user});
}

class UpdateUser extends UserListEvent {
  final User user;
  UpdateUser({required this.user});
}
