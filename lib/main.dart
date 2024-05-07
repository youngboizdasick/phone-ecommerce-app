import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:phone_store_clean_architectutre/app_bloc_observer.dart';
import 'package:phone_store_clean_architectutre/features/phone_store/blocs/login/login_bloc.dart';
import 'package:phone_store_clean_architectutre/features/phone_store/views/screens/cart/cart_page.dart';
import 'config/themes/app_themes.dart';
import 'features/phone_store/services/api_services.dart';
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
    final alreadyLoggedIn = ApiServices().getRefreshToken();
    return BlocProvider(
      create: (context) => LoginBloc(),
      child: MaterialApp(
        title: 'SPhone',
        debugShowCheckedModeBanner: false,
        home: _handleUserLoginOrNot(alreadyLoggedIn),
        theme: theme(),
        routes: {
          '/HomePage': (context) => const BottomTabBar(),
          '/CartPage': (context) => const CartPage(),
          '/AuthPage':(context) => const SignInOrSignUp(),
        },
      ),
    );
  }

  Widget _handleUserLoginOrNot(Future<String?> alreadyLoggedIn) {
    return FutureBuilder<String?>(
      future: alreadyLoggedIn,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final isLoggedIn = snapshot.data != null;
          return isLoggedIn ? const BottomTabBar() : const SignInOrSignUp();
        } else if (snapshot.hasError) {
          // Handle errors (optional)
          return Text('Error: ${snapshot.error}'); // Example error handling
        }
        // Show a loading indicator while waiting for data
        return const SignInOrSignUp();
      },
    );
  }
}
