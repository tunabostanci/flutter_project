import 'package:flutter/material.dart';
import 'package:freecodecamp/utilities/dialogs/loading_dialog.dart';
import '../services/auth/bloc/auth_event.dart';
import '../services/auth/auth_exceptions.dart';
import '../services/auth/bloc/auth_bloc.dart';
import '../services/auth/bloc/auth_state.dart';
import '../utilities/dialogs/error_dialog.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  late final TextEditingController _email;
  late final TextEditingController _password;


  @override
  void initState() {
    super.initState();
    _email = TextEditingController();
    _password = TextEditingController();
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) async {
        print('Current state: $state');
        if (state is AuthStateLoggedOut) {

          if (state.exception != null) {
            print('AuthStateLoggedOut with exception: ${state.exception}');
            String errorMessage = 'Authentication error';
            if (state.exception is UserNotFoundAuthException) {
              errorMessage = 'User not found';
            } else if (state.exception is WrongPasswordAuthException) {
              errorMessage = 'Wrong credentials';
            } else if (state.exception is GenericAuthException) {
              errorMessage = 'Authentication error';
            }
            print('Showing error dialog: $errorMessage');
            await showErrorDialog(context, errorMessage);
          }

        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Login',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          backgroundColor: Colors.blue,
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              const Text(
                  'Please log in to your account in order to interact with and create notes!'),
              TextField(
                controller: _email,
                enableSuggestions: false,
                autocorrect: false,
                keyboardType: TextInputType.emailAddress,
                decoration:
                    const InputDecoration(hintText: 'Enter your email here'),
              ),
              TextField(
                controller: _password,
                obscureText: true,
                enableSuggestions: false,
                autocorrect: false,
                decoration:
                    const InputDecoration(hintText: 'Enter your password here'),
              ),
              TextButton(
                onPressed: () async {
                  final email = _email.text;
                  final password = _password.text;
                  context.read<AuthBloc>().add(
                        AuthEventLogIn(
                          email,
                          password,
                        ),
                      );
                },
                child: const Text('Login'),
              ),TextButton(
                onPressed: () {
                  context.read<AuthBloc>().add(
                    const AuthEventForgotPassword(),
                  );
                },
                child: const Text("I forgot my password"),
              ),
              TextButton(
                onPressed: () {
                 context.read<AuthBloc>().add(
                   const AuthEventShouldRegister(),
                 );
                },
                child: const Text("Not registered yet? Register here!"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
