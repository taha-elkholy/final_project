import 'package:final_project/core/const/strings.dart';
import 'package:final_project/core/di/injector/injector.dart';
import 'package:final_project/core/presentations/widgets/custom_text_form_field.dart';
import 'package:final_project/features/auth/presentation/bloc/login_cubit/login_cubit.dart';
import 'package:final_project/features/auth/presentation/bloc/login_cubit/login_states.dart';
import 'package:final_project/features/auth/presentation/pages/register_screen.dart';
import 'package:final_project/features/home/presentation/pages/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final formKey = GlobalKey<FormState>();
  late TextEditingController emailController;

  late TextEditingController passwordController;

  @override
  void initState() {
    emailController = TextEditingController();
    passwordController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      body: BlocProvider(
        create: (context) => getIt<LoginCubit>(),
        child:
            BlocConsumer<LoginCubit, LoginStates>(listener: (context, state) {
          if (state is LoginLoadedState) {
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => const HomeScreen()));
          }
        }, builder: (context, state) {
          var cubit = getIt<LoginCubit>();
          return state.maybeWhen(
            orElse: () {
              return SingleChildScrollView(
                child: Form(
                  key: formKey,
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const SizedBox(
                            height: 70,
                          ),
                          Text(
                            login,
                            style: Theme.of(context).textTheme.headline6,
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          CustomTextFormField(
                            controller: emailController,
                            icon: Icons.email_outlined,
                            inputType: TextInputType.emailAddress,
                            hint: email,
                            validate: (value) {
                              if (value == null || !value.contains('@')) {
                                //RegExp('source')
                                return 'Invalid Email';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          CustomTextFormField(
                              controller: passwordController,
                              icon: Icons.lock,
                              inputType: TextInputType.visiblePassword,
                              hint: password,
                              obscureText: true,
                              validate: (value) {
                                if (value == null || value.length < 6) {
                                  return 'Invalid Password';
                                }
                                return null;
                              }),
                          const SizedBox(
                            height: 8,
                          ),
                          TextButton(
                              onPressed: () {
                                Navigator.of(context).pushReplacement(MaterialPageRoute(
                                    builder: (context) =>
                                        const RegisterScreen()));
                              },
                              child: const Text('Create new account $register')),
                          SizedBox(
                            width: double.infinity,
                            height: 50,
                            child: ElevatedButton(
                                onPressed: () {
                                  if (formKey.currentState!.validate()) {
                                    cubit.login(
                                        email: emailController.text.trim(),
                                        password: passwordController.text);
                                  }
                                },
                                child: const Text(login)),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
            loading: () => const Center(
              child: CircularProgressIndicator(),
            ),
            error: (error) => const Center(
              child: Text('Login Error'),
            ),
          );
        }),
      ),
    );
  }
}