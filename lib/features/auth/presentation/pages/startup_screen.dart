import 'package:final_project/features/auth/presentation/bloc/auth_cubit/auth_cubit.dart';
import 'package:final_project/features/auth/presentation/bloc/auth_cubit/auth_states.dart';
import 'package:final_project/features/auth/presentation/pages/login_screen.dart';
import 'package:final_project/features/home/presentation/pages/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class StartupScreen extends StatelessWidget {
  const StartupScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthStates>(
      listener: (context, state) {
        state.whenOrNull(
            startupLoaded: () => Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => const HomeScreen())),
            startupError: (error) => Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => const LoginScreen())));
      },
      child: Scaffold(
        body: Container(),
      ),
    );
  }
}
