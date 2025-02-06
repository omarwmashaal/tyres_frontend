import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:tyres_frontend/core/Widgets/CustomTextFormField.dart';
import 'package:tyres_frontend/core/Widgets/MainText.dart';
import 'package:tyres_frontend/core/Widgets/PrimaryButton.dart';
import 'package:tyres_frontend/core/Widgets/SecondaryButton.dart';
import 'package:tyres_frontend/core/Widgets/TitleText.dart';
import 'package:tyres_frontend/core/service_injector.dart';
import 'package:tyres_frontend/features/Authentication/data/models/registerModel.dart';
import 'package:tyres_frontend/features/Authentication/presenation/blocs/authentication_bloc.dart';
import 'package:tyres_frontend/features/Authentication/presenation/blocs/authentication_blocEvents.dart';
import 'package:tyres_frontend/features/Authentication/presenation/blocs/authentication_blocStates.dart'; // For accessing GetIt instance

class RegisterPage extends StatelessWidget {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // Access the AuthenticationBloc from GetIt
    final authenticationBloc = BlocProvider.of<AuthenticationBloc>(context);

    return Scaffold(
      appBar: AppBar(
        title: TitleText(title: 'Register'), // Using TitleText widget
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // Main Text above the form
            MainText(text: 'Create a new account'), // Using MainText widget

            SizedBox(height: 16),

            // Name Input Field
            CustomTextFormField(
              controller: nameController,
              labelText: 'Name',
            ),

            SizedBox(height: 16),

            // Email Input Field
            CustomTextFormField(
              controller: emailController,
              labelText: 'Email',
            ),

            SizedBox(height: 16),

            // Password Input Field
            CustomTextFormField(
              controller: passwordController,
              labelText: 'Password',
              isPassword: true,
            ),

            SizedBox(height: 16),

            // Confirm Password Input Field
            CustomTextFormField(
              controller: confirmPasswordController,
              labelText: 'Confirm Password',
              isPassword: true,
            ),

            SizedBox(height: 16),

            // Register Button
            BlocConsumer<AuthenticationBloc, AuthenticationState>(
              listener: (context, state) {
                if (state is AuthenticationRegisterSuccessState) {
                  // Navigate to login page after successful registration
                  Navigator.pop(context);
                } else if (state is AuthenticationErrorState) {
                  // Show error message if registration failed
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(state.message)),
                  );
                }
              },
              builder: (context, state) {
                if (state is AuthenticationLoadingState) {
                  return CircularProgressIndicator();
                }

                return PrimaryButton(
                  text: 'Register',
                  onPressed: () {
                    // Dispatch the RegisterEvent when the button is pressed
                    final name = nameController.text;
                    final email = emailController.text;
                    final password = passwordController.text;
                    final confirmPassword = confirmPasswordController.text;

                    if (name.isNotEmpty && email.isNotEmpty && password.isNotEmpty && confirmPassword.isNotEmpty) {
                      if (password == confirmPassword) {
                        BlocProvider.of<AuthenticationBloc>(context).add(
                          RegisterEvent(
                            registerModel: Registermodel(
                              name: name,
                              email: email,
                              password: password,
                            ),
                          ),
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Passwords do not match')),
                        );
                      }
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Please fill in all fields')),
                      );
                    }
                  },
                );
              },
            ),

            SizedBox(height: 16),

            // Navigate to Login Page
            SecondaryButton(
              text: 'Already have an account? Login here',
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
