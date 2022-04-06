import 'package:final_project/core/style/style.dart';
import 'package:final_project/core/utilities/my_bloc_observer.dart';
import 'package:final_project/di/injector/injector.dart';
import 'package:final_project/features/auth/presentation/bloc/auth_cubit/auth_cubit.dart';
import 'package:final_project/features/auth/presentation/pages/startup_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await configureDependencies();
  BlocOverrides.runZoned(
    () => runApp(const MyApp()),
    blocObserver: MyBlocObserver(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<AuthCubit>()..getHomeScreen(),
      child: MaterialApp(
        theme: appThemeLight,
        debugShowCheckedModeBanner: false,
        home: const StartupScreen(),
      ),
    );
  }
}
