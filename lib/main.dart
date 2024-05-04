import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:phone_store_clean_architectutre/app_bloc_observer.dart';
import 'package:phone_store_clean_architectutre/features/phone_store/blocs/login/login_bloc.dart';
import 'config/themes/app_themes.dart';
import 'features/phone_store/views/screens/auth/signin_or_signup.dart';
import 'features/phone_store/views/widgets/bottom_nav_bar/bottom_tab_bar.dart';

void main() {
  Bloc.observer = AppBlocObserver();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginBloc(),
      child: MaterialApp(
          title: 'SPhone',
          debugShowCheckedModeBanner: false,
          home: const SignInOrSignUp(),
          theme: theme(),
          routes: {
            '/HomePage': (context) => const BottomTabBar(),
          }),
    );
  }
}
