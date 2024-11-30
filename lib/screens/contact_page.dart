import 'package:flutter/material.dart';

class ContactPage extends StatefulWidget {
  const ContactPage({super.key});

  @override
  State<ContactPage> createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
  // create form key for validation and saving
  final _formKey = GlobalKey<FormState>();

  // form field controllers
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _messageController = TextEditingController();

  @override
  void dispose() {
    // clean up controllers when widget is disposed
    _nameController.dispose();
    _emailController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  // handle form submission
  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      // show success message
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Your form has been submitted successfully!')),
      );
      // clear form
      _formKey.currentState!.reset();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Contact Us!'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Get in Touch',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _nameController,
                autofocus: true,
                keyboardType: TextInputType.name,
                textInputAction: TextInputAction.next,
                decoration: const InputDecoration(
                  icon: Icon(Icons.person),
                  labelText: 'Name',
                  hintText: 'Please enter your full name.',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your name properly!';
                  }
                  return null;
                },
                onSaved: (value) {
                  // save name value
                  print('Name saved: $value');
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.next,
                decoration: const InputDecoration(
                  icon: Icon(Icons.email),
                  labelText: 'Email',
                  hintText: 'please enter your email address.',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Whoops, please enter your email!';
                  }
                  if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                      .hasMatch(value)) {
                    return 'Oh no, please enter a valid email address!';
                  }
                  return null;
                },
                onSaved: (value) {
                  // save email value
                  print('Email saved: $value');
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _messageController,
                keyboardType: TextInputType.multiline,
                textInputAction: TextInputAction.newline,
                maxLines: 5,
                decoration: const InputDecoration(
                  icon: Icon(Icons.message),
                  labelText: 'Message',
                  hintText: 'Enter your message here, make it nice!',
                  alignLabelWithHint: true,
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your message.';
                  }
                  if (value.length < 10) {
                    return 'Message must be at least 10 characters long.';
                  }
                  return null;
                },
                onSaved: (value) {
                  // save message value
                  print('Message saved: $value');
                },
              ),
              const SizedBox(height: 24),
              Center(
                child: ElevatedButton(
                  onPressed: _submitForm,
                  child: const Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 24.0,
                      vertical: 12.0,
                    ),
                    child: Text('Submit'),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
