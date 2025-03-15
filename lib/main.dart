import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freecodecamp/services/auth/bloc/auth_bloc.dart';
import 'package:freecodecamp/services/auth/bloc/auth_event.dart';
import 'package:freecodecamp/services/auth/bloc/auth_state.dart';
import 'package:freecodecamp/services/auth/firebase_auth_provider.dart';
import 'package:freecodecamp/views/login_view.dart';
import 'package:freecodecamp/views/notes/create_update_note_view.dart';
import 'package:freecodecamp/views/register_view.dart';
import 'package:freecodecamp/views/verify_email_view.dart';
import 'constants/routes.dart';
import 'views/notes/notes_view.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: BlocProvider<AuthBloc>(
        create: (context) => AuthBloc(FirebaseAuthProvider()),
        child: const HomePage(),
      ),
      routes: {
        createOrUpdateNoteRoute: (context) => const CreateUpdateNoteView(),
      },
    ),
  );
}
 class HomePage extends StatelessWidget {
   const HomePage({super.key});

   @override
   Widget build(BuildContext context) {
     context.read<AuthBloc>().add(const AuthEventInitialize());
     return BlocBuilder<AuthBloc,AuthState>(
       builder: (context,state){
           if(state is AuthStateLoggedIn){
             return const NotesView();
           }else if (state is AuthStateNeedsVerification){
             return const VerifyEmailView();
           }else if(state is AuthStateLoggedOut){
             return const LoginView();
           }else if (state is AuthStateRegistering){
             return const RegisterView();
           }else{
             return const Scaffold(
               body: CircularProgressIndicator(),
             );
           }
        },
     );
   }
 }


