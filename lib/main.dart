import 'package:e_commerce_app_using_supabase/core/my_observer.dart';
import 'package:e_commerce_app_using_supabase/views/auth/logic/cubit/authentication_cubit.dart';
import 'package:flutter/material.dart';
import 'package:e_commerce_app_using_supabase/core/app_colors.dart';
import 'package:e_commerce_app_using_supabase/views/nav_bar/ui/main_home_view.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'views/auth/ui/login_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
    url: 'https://dcjaykkfynunujgbbayp.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImRjamF5a2tmeW51bnVqZ2JiYXlwIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NTMxNzEwMzgsImV4cCI6MjA2ODc0NzAzOH0.z8U3BA-iJv_SZaaUWUjLV7o_k2pRNlbqWJw-R06P0qA', // anon key => Api Key
  );
  Bloc.observer = MyObserver(); // Set the BlocObserver
  runApp(const OurMarket());
}

class OurMarket extends StatelessWidget {
  const OurMarket({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthenticationCubit(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Our Market',
        theme: ThemeData(
          scaffoldBackgroundColor: AppColors.kScaffoldColor,
          useMaterial3: true,
        ),
        home: Supabase.instance.client.auth.currentUser != null
            ? MainHomeView()
            : LoginView(),
      ),
    );
  }
}


// ! Steps for making supabase:
// ! 1) create new supabase project
// ! 2) Add dependency supabase_flutter in pubspec.yaml
// ! 3) initialize supabase in main.dart
// ! 4) create AuthenticationCubit and add it to login and signup views 