import 'package:analytics_app/blocs/auth/auth_cubit.dart';
import 'package:analytics_app/ui/screens/signup_screen_2.dart';
import 'package:analytics_app/widgets/app_rounded_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../blocs/auth/auth_state.dart';
import '../../styles/app_colors.dart';
import '../../utils/ui_helper.dart';
import '../../widgets/app_rounded_button.dart';
import 'home_screen.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  String? username;
  String? password;
  bool progress = false;
  late AuthCubit authCubit;

  @override
  void initState() {
    authCubit = BlocProvider.of<AuthCubit>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                    child: Image.asset(
                  'images/logo.png',
                  height: 150,
                )),
                Text(
                  'Analytic App',
                  style: TextStyle(fontSize: 30, letterSpacing: 3),
                ),
                const SizedBox(
                  height: 10,
                ),
                Divider(),
                Container(
                  padding: const EdgeInsets.all(25),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Sign In',
                        style: TextStyle(
                            fontSize: 25,
                            letterSpacing: 2.5,
                            fontWeight: FontWeight.bold,
                            color: AppColors.primaryColor),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      const Text(
                        'Please fill in the credentials',
                        style: TextStyle(
                            color: Colors.black54,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 0.7),
                      ),
                      const SizedBox(
                        height: 45,
                      ),
                      Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            AppRoundedTextField(
                                label: 'Email',
                                validator: (value) {
                                  if (value == '') {
                                    return 'Please enter the email';
                                  }
                                  return null;
                                },
                                prefixIconData: Icons.person,
                                hintText: 'Enter the Email',
                                onChanged: (val) {
                                  username = val;
                                }),
                            const SizedBox(
                              height: 30,
                            ),
                            AppRoundedTextField(
                                label: 'Password',
                                hintText: 'Enter the password',
                                obsureText: true,
                                prefixIconData: Icons.key,
                                validator: (value) {
                                  if (value == '') {
                                    return 'Please enter the password';
                                  }
                                  return null;
                                },
                                onChanged: (val) {
                                  password = val;
                                }),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      BlocConsumer<AuthCubit, AuthState>(
                        listener: (context, state) {
                          if (state is LoginSuccessState) {
                            UIHelper.gotoScreen(context, HomeScreen(),
                                removePreviousStack: true);
                          } else if (state is LoginErrorState) {
                            UIHelper.showAlertDialog(context, state.msg);
                          }
                        },
                        builder: (context, state) {
                          if (state is LoginLoadingState) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                          return AppRoundedButton(
                            label: 'SIGN IN',
                            onPressed: onPressedLogin,
                            fitWidth: true,
                          );
                        },
                      ),
                      Container(
                        width: double.infinity,
                        margin: const EdgeInsets.only(top: 55),
                        child: const Text(
                          "Don't have an account?",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.black54,
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      GestureDetector(
                        onTap: onTapSignup,
                        child: const SizedBox(
                          width: double.infinity,
                          child: Text(
                            "Sign Up",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: AppColors.primaryColor,
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void onTapSignup() {
    UIHelper.gotoScreen(context, SignupScreen2());
  }

  void onPressedLogin() async {
    if (username == '' || username == null) {
      UIHelper.showAlertDialog(context, 'Please enter the email');
      return;
    }
    if (password == '' || password == null) {
      UIHelper.showAlertDialog(context, 'Please enter the password');
      return;
    }
    authCubit.login(email: username!, password: password!);
  }
}
