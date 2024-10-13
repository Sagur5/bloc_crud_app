// ignore_for_file: public_member_api_docs, sort_constructors_first, use_super_parameters
import 'package:bloc_crud_app/user_model.dart';

abstract class UserListState {
  List<User> users;
  UserListState({
    required this.users,
  });
}

class UserListInitial extends UserListState {
  UserListInitial({required List<User> users}) : super(users: users);
}

class UserListUpdated extends UserListState {
  UserListUpdated({required List<User> users}) : super(users: users);
}
