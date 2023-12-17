import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokedex/constant/color.dart';
import '../cubit/auth_cubit.dart';

class SignUpForm extends StatelessWidget {
  final GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _usernnameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  void _signup(BuildContext context) {
    final authCubit = BlocProvider.of<AuthCubit>(context);
    if (_formKey.currentState!.saveAndValidate()) {
      Map<String, dynamic> formData = _formKey.currentState!.value;

      authCubit.signUp(
        formData['email'] as String,
        formData['password'] as String,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Sign Up Form',
          style: TextStyle(color: textColor),
        ),
      ),
      body: FormBuilder(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        key: _formKey,
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width * 0.1),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: MediaQuery.of(context).size.height * 0.04),
                FormBuilderTextField(
                  name: 'username',
                  controller: _usernnameController,
                  decoration: InputDecoration(
                      labelText: 'Username',
                      labelStyle: TextStyle(fontSize: 14)),
                  validator: FormBuilderValidators.compose([
                    (value) {
                      // Validate that the input only contains alphabets and spaces
                      if (value != null &&
                          !RegExp(r'^[a-zA-Z\s]+$').hasMatch(value)) {
                        return 'Please enter only alphabets and spaces';
                      }
                      return null;
                    },
                  ]),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.05),
                FormBuilderTextField(
                  name: 'email',
                  controller: _emailController,
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(),
                    FormBuilderValidators.email(),
                  ]),
                  decoration: InputDecoration(
                      labelText: 'Email', labelStyle: TextStyle(fontSize: 14)),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.05),
                FormBuilderTextField(
                  name: 'password',
                  controller: _passwordController,
                  decoration: InputDecoration(
                      labelText: 'Password',
                      labelStyle: TextStyle(fontSize: 14)),
                  obscureText: true,
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(),
                    _passwordValidator,
                  ]),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.05),
                FormBuilderTextField(
                  name: 'confirm_password',
                  controller: _confirmPasswordController,
                  decoration: InputDecoration(
                      labelText: 'Confirm Password',
                      labelStyle: TextStyle(fontSize: 14)),
                  obscureText: true,
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(),
                  ]),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.05),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: ElevatedButton(
                    onPressed: () {
                      //_signup(context);

                      _signup(context);
                    },
                    child: Text('Sign Up'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String? _passwordValidator(value) {
    if (value.isEmpty) {
      return 'Password is required';
    }

    // Check for minimum length
    if (value.length < 8) {
      return 'Password must be at least 8 characters';
    }

    // Check for uppercase letter
    if (!value.contains(RegExp(r'[A-Z]'))) {
      return 'Password must contain at least one uppercase letter';
    }

    // Check for lowercase letter
    if (!value.contains(RegExp(r'[a-z]'))) {
      return 'Password must contain at least one lowercase letter';
    }

    // Check for digit
    if (!value.contains(RegExp(r'[0-9]'))) {
      return 'Password must contain at least one digit';
    }

    // Check for special character
    if (!value.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
      return 'Password must contain at least one special character';
    }

    // Password is valid
    return null;
  }

  String? _nameValidator(value) {
    if (value.isEmpty) {
      return 'Name is required';
    }

    // Check for alphabetic characters only
    if (!RegExp(r'^[a-zA-Z]+$').hasMatch(value)) {
      return 'Name should only contain alphabets';
    }

    // Name is valid
    return null;
  }
}
