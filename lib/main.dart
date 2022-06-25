import 'package:analytics_app/blocs/auth/auth_cubit.dart';
import 'package:analytics_app/blocs/geo/geo_cubit.dart';
import 'package:analytics_app/repository/auth_repo.dart';
import 'package:analytics_app/ui/screens/home_screen.dart';
import 'package:analytics_app/ui/screens/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'blocs/myactivity/my_activity_cubit.dart';
import 'blocs/tracker/tracker_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthCubit>(
          create: (context) => AuthCubit(),
        ),
        BlocProvider<MyActivityCubit>(
          create: (context) => MyActivityCubit(),
        ),
        BlocProvider<GeoCubit>(
          create: (context) => GeoCubit(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: SplashScreen(),
      ),
    );
  }
}
