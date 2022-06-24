import 'package:analytics_app/blocs/auth/auth_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:analytics_app/ui/screens/login_screen.dart';
import 'package:analytics_app/ui/screens/signup_screen.dart';
import 'package:analytics_app/widgets/app_rounded_button.dart';
import 'package:analytics_app/widgets/app_rounded_text_field.dart';
import 'package:provider/provider.dart';

import '../../blocs/auth/auth_cubit.dart';
import '../../styles/app_colors.dart';
import '../../utils/ui_helper.dart';
import 'home_screen.dart';

class SignupScreen extends StatefulWidget {
  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _formKey = GlobalKey<FormState>();
  String? email, pass, repass;
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                    alignment: Alignment.center,
                    child: Column(
                      children: [
                        Image.asset(
                          'images/logo.png',
                          height: 150,
                        ),
                        Text(
                          'Analytic App',
                          style: TextStyle(fontSize: 30, letterSpacing: 3),
                        ),
                      ],
                    )),
                const SizedBox(
                  height: 10,
                ),
                GestureDetector(
                  onTap: onTapBackClicked,
                  child: Container(
                      margin: const EdgeInsets.only(left: 10),
                      child: const Icon(
                        Icons.arrow_back,
                        size: 35,
                      )),
                ),
                Container(
                  padding: const EdgeInsets.all(25),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Sign Up',
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
                        height: 25,
                      ),
                      Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            AppRoundedTextField(
                                label: 'Email',
                                hintText: 'Enter the Email',
                                prefixIconData: Icons.mail,
                                validator: (value) {
                                  if (value == '') {
                                    return 'Please enter the Email';
                                  }
                                  return null;
                                },
                                onChanged: (val) {
                                  email = val;
                                }),
                            const SizedBox(
                              height: 30,
                            ),
                            AppRoundedTextField(
                                label: 'Password',
                                hintText: 'Enter the Password',
                                prefixIconData: Icons.vpn_key,
                                obsureText: true,
                                validator: (value) {
                                  if (value == '') {
                                    return 'Please enter the password';
                                  }
                                  return null;
                                },
                                onChanged: (val) {
                                  pass = val;
                                }),
                            const SizedBox(
                              height: 30,
                            ),
                            AppRoundedTextField(
                                label: 'Re-Enter Password',
                                hintText: 'Re-Enter the Password',
                                prefixIconData: Icons.vpn_key,
                                obsureText: true,
                                validator: (value) {
                                  if (value == '') {
                                    return 'Please re-enter password';
                                  }
                                  return null;
                                },
                                onChanged: (val) {
                                  repass = val;
                                }),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      BlocConsumer<AuthCubit, AuthState>(
                        listener: (context, state) {
                          if (state is SignupSuccessState) {
                            //UIHelper.showShortToast(state.msg);
                            UIHelper.gotoScreen(context, HomeScreen());
                          } else if (state is SignupErrorState) {
                            UIHelper.showAlertDialog(context, state.msg);
                          }
                        },
                        builder: (context, state) {
                          if (state is SignupLoadingState) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                          return AppRoundedButton(
                            label: 'SIGN UP',
                            onPressed: onPressedSignup,
                            fitWidth: true,
                          );
                        },
                      ),
                      /*Container(
                          width: double.infinity,
                          margin: const EdgeInsets.only(top: 55),
                          child: const Text(
                            "Already have an account?",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.black54,
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                          ),
                        ),*/
                      /*const SizedBox(
                          height: 10,
                        ),
                        GestureDetector(
                          onTap: onTapSignIn,
                          child: SizedBox(
                            width: double.infinity,
                            child: Text(
                              "Sign In",
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
                        ),*/
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

  void onTapBackClicked() {
    Navigator.pop(context);
  }

  void onTapSignIn() {
    UIHelper.gotoScreen(context, LoginScreen());
  }

  void onPressedSignup() async {
    //UIHelper.gotoScreen(context, ChangePasswordSignupScreen3());
    if (email == null || email == '') {
      UIHelper.showAlertDialog(context, 'Please enter the email!');
      return;
    }
    if (pass == null || pass == '') {
      UIHelper.showAlertDialog(context, 'Please enter the password!');
      return;
    }
    if (repass == null || repass == '') {
      UIHelper.showAlertDialog(context, 'Please re-enter the password!');
      return;
    }
    if (pass != repass) {
      UIHelper.showAlertDialog(
          context, 'Repeat password should be same new password!');
      return;
    }
    authCubit.signUp(email: email!, password: pass!);
  }
}
