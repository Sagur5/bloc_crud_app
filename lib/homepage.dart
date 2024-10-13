// ignore_for_file: prefer_const_constructors, unused_local_variable, prefer_const_literals_to_create_immutables

import 'package:bloc_crud_app/bloc/crud_bloc_bloc.dart';
import 'package:bloc_crud_app/bloc/crud_bloc_event.dart';
import 'package:bloc_crud_app/bloc/crud_bloc_state.dart';
import 'package:bloc_crud_app/user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Homepage extends StatelessWidget {
  Homepage({super.key});

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  void showBottomSheet({
    required BuildContext context,
    bool isEdit = false,
    required int id,
  }) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Container(
            padding: const EdgeInsets.all(16.0),
            color: Colors.amber[50], // Light amber background for the bottom sheet
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: nameController,
                  decoration: InputDecoration(
                    labelText: 'Name', // Label for Name
                    prefixIcon: Icon(Icons.person, color: Colors.amber), // Name icon
                    filled: true,
                    fillColor:Color.fromARGB(255, 219, 246, 244), // Lime color for input field
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.deepOrange, width: 2.0), // Deep orange border
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Color.fromARGB(255, 21, 55, 249), width: 2.0), // Deep orange focused border
                    ),
                    contentPadding: const EdgeInsets.symmetric(vertical: 16.0), // Vertical padding inside the TextField
                  ),
                ),
                SizedBox(height: 16.0), // Spacing between fields
                TextField(
                  controller: emailController,
                  decoration: InputDecoration(
                    labelText: 'Email', // Label for Email
                    prefixIcon: Icon(Icons.email, color: Colors.amber), // Email icon
                    filled: true,
                    fillColor: Color.fromARGB(255, 219, 246, 244), // Lime color for input field
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.deepOrange, width: 2.0), // Deep orange border
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Color.fromARGB(255, 21, 55, 249), width: 2.0), // Deep orange focused border
                    ),
                    contentPadding: const EdgeInsets.symmetric(vertical: 16.0), // Vertical padding inside the TextField
                  ),
                ),
                SizedBox(height: 16.0), // Spacing before button
                ElevatedButton(
                  onPressed: () {
                    if (nameController.text.isEmpty || emailController.text.isEmpty) {
                      // Show an error message if fields are empty
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Please enter both Name and Email')),
                      );
                      return;
                    }
                    final user = User(name: nameController.text, email: emailController.text, id: id);
                    if (isEdit) {
                      BlocProvider.of<UserListBloc>(context).add(UpdateUser(user: user));
                    } else {
                      BlocProvider.of<UserListBloc>(context).add(AddUser(user: user));
                    }
                    nameController.clear(); // Clear the input field
                    emailController.clear(); // Clear the input field
                    Navigator.pop(context);
                  },
                  child: Text(isEdit ? 'Update' : 'Add User'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('CRUD : BLOC'),
      ),
      backgroundColor: Color.fromRGBO(119, 237, 153, 1), // Beautiful RGB background color
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          final state = BlocProvider.of<UserListBloc>(context).state;
          final id = state.users.length + 1;
          showBottomSheet(context: context, id: id, isEdit: false);
        },
        child: Icon(Icons.add),
      ),
      body: BlocBuilder<UserListBloc, UserListState>(
        builder: (context, state) {
          if (state is UserListUpdated && state.users.isNotEmpty) {
            final users = state.users;
            return ListView.builder(
              itemCount: users.length,
              itemBuilder: (context, index) {
                final user = users[index];
                return buildUserTile(context, user);
              },
            );
          } else {
            return const Center(
              child: Text('Add User', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 40),), // Message when the list is empty
            );
          }
        },
      ),
    );
  }

  Widget buildUserTile(BuildContext context, User user) {
    return ListTile(
      title: Text(user.name),
      subtitle: Text(user.email),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            onPressed: () {
              BlocProvider.of<UserListBloc>(context).add(DeleteUser(user: user));
            },
            icon: const Icon(Icons.delete, size: 30, color: Colors.red),
          ),
          IconButton(
            onPressed: () {
              nameController.text = user.name;
              emailController.text = user.email;
              showBottomSheet(context: context, id: user.id, isEdit: true);
            },
            icon: const Icon(Icons.edit, size: 30, color: Colors.green),
          ),
        ],
      ),
    );
  }
}
