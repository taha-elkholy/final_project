import 'package:final_project/core/const/constants.dart';
import 'package:final_project/core/presentations/widgets/app_elevated_button.dart';
import 'package:final_project/core/presentations/widgets/app_text_form_field.dart';
import 'package:final_project/core/style/colors.dart';
import 'package:final_project/features/auth/domain/entities/register_param.dart';
import 'package:final_project/features/auth/presentation/bloc/auth_cubit/auth_cubit.dart';
import 'package:final_project/features/auth/presentation/bloc/auth_cubit/auth_states.dart';
import 'package:final_project/features/auth/presentation/pages/login_screen.dart';
import 'package:final_project/features/auth/presentation/widgets/auth_custom_paint.dart';
import 'package:final_project/features/home/presentation/pages/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final formKey = GlobalKey<FormState>();

  late TextEditingController nameController;
  late TextEditingController emailController;
  late TextEditingController passwordController;
  late TextEditingController passwordConfirmationController;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    passwordConfirmationController = TextEditingController();
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    passwordConfirmationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthStates>(
      listener: (context, state) {
        state.whenOrNull(
          registerLoaded: () {
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => const HomeScreen()));
          },
          registerError: (error) {
            ScaffoldMessenger.of(context)
                .showSnackBar(const SnackBar(content: Text('Register Error')));
          },
        );
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
                  'Create New Account',
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
                  child: Column(
                    children: [
                      AppTextFormField(
                        controller: nameController,
                        validate: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Name must be filled';
                          }
                          return null;
                        },
                        inputType: TextInputType.name,
                        label: 'User Name',
                        icon: Icons.person,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      AppTextFormField(
                        controller: emailController,
                        validate: (value) {
                          if (value != null) {
                            bool validation = emailRegExp.hasMatch(value);
                            if (!validation) return 'Invalid Email';
                          }
                          return null;
                        },
                        inputType: TextInputType.emailAddress,
                        label: 'Email',
                        icon: Icons.email,
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
                          isPassword: true),
                      const SizedBox(
                        height: 20,
                      ),
                      AppTextFormField(
                          controller: passwordConfirmationController,
                          validate: (value) {
                            if (value != passwordController.text) {
                              return 'Password confirmation not matches';
                            }
                            return null;
                          },
                          inputType: TextInputType.visiblePassword,
                          label: 'Password Confirmation',
                          icon: Icons.lock,
                          isPassword: true),
                      const SizedBox(
                        height: 20,
                      ),
                      BlocBuilder<AuthCubit, AuthStates>(
                          builder: (context, state) {
                        return state.maybeWhen(
                          orElse: () {
                            return AppElevatedButton(
                                isLoading: state.maybeWhen(
                                  orElse: () => false,
                                  registerLoading: () => true,
                                  registerLoaded: () => true,
                                ),
                                onPressed: () {
                                  if (formKey.currentState!.validate()) {
                                    FocusManager.instance.primaryFocus
                                        ?.unfocus();
                                    BlocProvider.of<AuthCubit>(context)
                                        .register(
                                      registerParam: RegisterParam(
                                          name: nameController.text.trim(),
                                          email: emailController.text.trim(),
                                          password: passwordController.text,
                                          passwordConfirmation:
                                              passwordConfirmationController
                                                  .text),
                                    );
                                  }
                                },
                                text: 'Register');
                          },
                        );
                      }),
                    ],
                  ),
                ),
              ),
              TextButton(
                child: Text(
                  'Already Have Account? Login',
                  textAlign: TextAlign.start,
                  style: Theme.of(context)
                      .textTheme
                      .subtitle1!
                      .copyWith(color: appMainColor),
                ),
                onPressed: () {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const LoginScreen()));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
