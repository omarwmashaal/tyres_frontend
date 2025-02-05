import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tyres_frontend/core/Widgets/CustomTextFormField.dart';
import 'package:tyres_frontend/core/Widgets/HomePagesParent.dart';
import 'package:tyres_frontend/core/Widgets/MainText.dart';
import 'package:tyres_frontend/core/Widgets/PrimaryButton.dart';
import 'package:tyres_frontend/core/Widgets/SecondaryButton.dart';
import 'package:tyres_frontend/core/Widgets/TitleText.dart';
import 'package:tyres_frontend/core/service_injector.dart';
import 'package:tyres_frontend/features/Authentication/data/models/loginModel.dart';
import 'package:tyres_frontend/features/Authentication/presenation/blocs/authentication_bloc.dart';
import 'package:tyres_frontend/features/Authentication/presenation/blocs/authentication_blocEvents.dart';
import 'package:tyres_frontend/features/Authentication/presenation/blocs/authentication_blocStates.dart';
import 'package:tyres_frontend/features/Trucks/presenation/pages/TruckSearchPage.dart'; // For accessing GetIt instance

class LoginPage extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // Access the AuthenticationBloc from GetIt
    final authenticationBloc = BlocProvider.of<AuthenticationBloc>(context);
    Future.value(si<SharedPreferences>().get("token")).then((value) => {
          if (value != "" && value != null)
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => Homepagesparent(),
                ))
        });
    return Scaffold(
      appBar: AppBar(
        title: TitleText(title: 'Login'), // Using TitleText widget
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // Main Text above the form
            MainText(text: 'Enter your credentials to log in'), // Using MainText widget

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

            // Login Button
            BlocConsumer<AuthenticationBloc, AuthenticationState>(
              listener: (context, state) {
                if (state is AuthenticationLoginSuccessState) {
                  // Navigate to another page on successful login
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Homepagesparent(),
                      ));
                  //context.go('/trucks');
                } else if (state is AuthenticationErrorState) {
                  // Show error message if login failed
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
                  text: 'Login',
                  onPressed: () {
                    // Dispatch the LoginEvent when the button is pressed
                    final email = emailController.text;
                    final password = passwordController.text;

                    if (email.isNotEmpty && password.isNotEmpty) {
                      authenticationBloc.add(
                        LoginEvent(
                          loginModel: Loginmodel(email: email, password: password),
                        ),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Please enter email and password')),
                      );
                    }
                  },
                );
              },
            ),

            SizedBox(height: 16),

            // Navigate to Register Page
            SecondaryButton(
              text: 'Don’t have an account? Register here',
              onPressed: () {
                context.go('/register');
              },
            ),
          ],
        ),
      ),
    );
  }
}
