import 'package:chatview/chatview.dart';
import 'package:example/service_locator.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class UserFormScreen extends StatefulWidget {
  const UserFormScreen({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _UserFormScreenState createState() => _UserFormScreenState();
}

class _UserFormScreenState extends State<UserFormScreen> {
  final profileManager = serviceLocator
      .get<ChatViewController>()
      .chatViewExtension
      ?.serviceExtension
      ?.dataManager
      ?.profileManager as SqfliteUserProfileService;

  final uuid = const Uuid();

  final _formKey = GlobalKey<FormState>();
  String _firstName = '';
  String _lastName = '';
  String _imageUrl = '';

  void _createUser() {
    if (_formKey.currentState!.validate()) {
      profileManager.createChatUser(ChatUser(
          id: uuid.v4(),
          firstName: _firstName,
          lastName: _lastName,
          imageUrl: _imageUrl,
          createdAt: DateTime.now().millisecondsSinceEpoch));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create User'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'First Name',
                ),
                onChanged: (value) => _firstName = value,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a first name';
                  }
                  return null;
                },
                onSaved: (value) {
                  _firstName = value!;
                },
              ),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Last Name',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a last name';
                  }
                  return null;
                },
                onChanged: (value) => _lastName = value,
                onSaved: (value) {
                  _lastName = value!;
                },
              ),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Image URL',
                ),
                onChanged: (value) => _imageUrl = value,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter an image URL';
                  }
                  return null;
                },
                onSaved: (value) {
                  _imageUrl = value!;
                },
              ),
              const SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: _createUser,
                child: const Text('Create User'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
