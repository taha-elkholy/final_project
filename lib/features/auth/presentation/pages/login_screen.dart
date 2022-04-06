import 'package:final_project/core/const/constants.dart';
import 'package:final_project/core/const/strings.dart';
import 'package:final_project/core/presentations/widgets/app_elevated_button.dart';
import 'package:final_project/core/presentations/widgets/app_text_form_field.dart';
import 'package:final_project/core/style/colors.dart';
import 'package:final_project/features/auth/domain/entities/login_param.dart';
import 'package:final_project/features/auth/presentation/bloc/auth_cubit/auth_cubit.dart';
import 'package:final_project/features/auth/presentation/bloc/auth_cubit/auth_states.dart';
import 'package:final_project/features/auth/presentation/pages/register_screen.dart';
import 'package:final_project/features/auth/presentation/widgets/auth_custom_paint.dart';
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
    super.initState();
    emailController = TextEditingController();
    passwordController = TextEditingController();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthStates>(
      listener: (context, state) {
        state.whenOrNull(loginLoaded: () {
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => const HomeScreen()));
        }, loginError: (error) {
          ScaffoldMessenger.of(context)
              .showSnackBar(const SnackBar(content: Text('Login Error')));
        });
      },
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Stack(
                alignment: Alignment.centerLeft,
                children: [
                  SizedBox(
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height * .25,
                    child: CustomPaint(
                      size: Size.infinite,
                      foregroundPainter: AuthCustomPaint(color: appMainColor),
                    ),
                  ),
                  const Center(
                    child: CircleAvatar(
                      radius: 50,
                      backgroundColor: Colors.white,
                      child: Image(
                        image: AssetImage('assets/images/logo.png'),
                        width: 70,
                        height: 70,
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Center(
                child: Text(
                  'User Login',
                  style: Theme.of(context)
                      .textTheme
                      .headline1!
                      .copyWith(color: appMainColor),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: Form(
                  key: formKey,
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        AppTextFormField(
                          controller: emailController,
                          icon: Icons.email_outlined,
                          inputType: TextInputType.emailAddress,
                          label: email,
                          validate: (value) {
                            if (value != null) {
                              bool validation = emailRegExp.hasMatch(value);
                              if (!validation) return 'Invalid Email';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        AppTextFormField(
                          controller: passwordController,
                          validate: (value) {
                            if (value == null || value.length < 8) {
                              return 'Invalid Password';
                            }
                            return null;
                          },
                          inputType: TextInputType.visiblePassword,
                          label: 'Password',
                          icon: Icons.lock,
                          isPassword: true,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        BlocBuilder<AuthCubit, AuthStates>(
                          builder: (context, state) {
                            return state.maybeWhen(
                              orElse: () => AppElevatedButton(
                                  isLoading: state.maybeWhen(
                                    orElse: () => false,
                                    loginLoading: () => true,
                                    loginLoaded: () => true,
                                  ),
                                  onPressed: () {
                                    if (formKey.currentState!.validate()) {
                                      FocusManager.instance.primaryFocus
                                          ?.unfocus();
                                      BlocProvider.of<AuthCubit>(context).login(
                                          loginParam: LoginParam(
                                              email:
                                                  emailController.text.trim(),
                                              password:
                                                  passwordController.text));
                                    }
                                  },
                                  text: 'Login'),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (context) => const RegisterScreen()));
                  },
                  child: Text(
                    'Don\'t have Account yet? Register',
                    style: Theme.of(context)
                        .textTheme
                        .subtitle1!
                        .copyWith(color: appMainColor),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
