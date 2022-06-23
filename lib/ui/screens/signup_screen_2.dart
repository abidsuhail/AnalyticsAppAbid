import 'package:analytics_app/blocs/auth/auth_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:analytics_app/ui/screens/login_screen.dart';
import 'package:analytics_app/ui/screens/signup_screen_2.dart';
import 'package:analytics_app/widgets/app_rounded_button.dart';
import 'package:analytics_app/widgets/app_rounded_text_field.dart';
import 'package:provider/provider.dart';

import '../../blocs/auth/auth_cubit.dart';
import '../../styles/app_colors.dart';
import '../../utils/ui_helper.dart';
import 'home_screen.dart';

class SignupScreen2 extends StatefulWidget {
  @override
  State<SignupScreen2> createState() => _SignupScreen2State();
}

class _SignupScreen2State extends State<SignupScreen2> {
  final _formKey = GlobalKey<FormState>();
  bool progress = false;
  String? custName, custMob, custEmail, custAddr, custPassword, otp;
  late AuthCubit authCubit;
  String? custNumModified = "";
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
                Image.asset(
                  'assets/logo2.png',
                ),
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
                      Text(
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
                                label: 'Customer Code',
                                hintText: 'Enter the Customer Code',
                                prefixIconData: Icons.person,
                                readOnly: true,
                                validator: (value) {
                                  if (value == '') {
                                    return 'Please enter the Customer Code';
                                  }
                                  return null;
                                },
                                onChanged: (val) {}),
                            const SizedBox(
                              height: 30,
                            ),
                            AppRoundedTextField(
                                label: 'Customer Name',
                                hintText: 'Enter the Customer Name',
                                prefixIconData: Icons.person,
                                readOnly: true,
                                validator: (value) {
                                  if (value == '') {
                                    return 'Please enter the Customer Name';
                                  }
                                  return null;
                                },
                                onChanged: (val) {
                                  custName = val;
                                }),
                            const SizedBox(
                              height: 30,
                            ),
                            AppRoundedTextField(
                                label: 'Mobile',
                                validator: (value) {
                                  if (value == '') {
                                    return 'Please enter the Mobile';
                                  }
                                  return null;
                                },
                                readOnly: true,
                                /*   controller: TextEditingController(
                                      text: widget
                                          .searchResponseModel.custMobile),*/
                                controller: TextEditingController(
                                    text: custNumModified),
                                prefixIconData: Icons.phone_android,
                                textInputType: TextInputType.phone,
                                // maxLength: 10,
                                hintText: 'Mobile No.',
                                onChanged: (val) {
                                  custMob = val;
                                }),
                            const SizedBox(
                              height: 30,
                            ),
                            AppRoundedTextField(
                                label: 'Email',
                                validator: (value) {
                                  if (value == '') {
                                    return 'Please enter the Email';
                                  }
                                  return null;
                                },
                                readOnly: true,
                                prefixIconData: Icons.email,
                                textInputType: TextInputType.text,
                                //maxLength: 10,
                                hintText: 'Enter the Email',
                                onChanged: (val) {
                                  custEmail = val;
                                }),
                            const SizedBox(
                              height: 30,
                            ),
                            /*AppRoundedTextField(
                                  label: 'Password',
                                  validator: (value) {
                                    if (value == '') {
                                      return 'Please enter the New Password';
                                    }
                                    return null;
                                  },
                                  prefixIconData: Icons.email,
                                  textInputType: TextInputType.text,
                                  obsureText: true,
                                  maxLength: 10,
                                  hintText: 'Enter the New Password',
                                  onChanged: (val) {
                                    custPassword = val;
                                  }),
                              const SizedBox(
                                height: 15,
                              ),*/
                            AppRoundedTextField(
                                label: 'OTP',
                                validator: (value) {
                                  if (value == '') {
                                    return 'Please enter the OTP';
                                  }
                                  return null;
                                },
                                prefixIconData: Icons.password,
                                textInputType: TextInputType.number,
                                hintText: 'Enter the OTP',
                                onChanged: (val) {
                                  otp = val;
                                }),
                            const SizedBox(
                              height: 30,
                            ),
                            AppRoundedTextField(
                                label: 'Address',
                                hintText: 'Enter the Address',
                                prefixIconData: Icons.home_work_outlined,
                                maxLines: 3,
                                readOnly: true,
                                validator: (value) {
                                  if (value == '') {
                                    return 'Please enter the Address';
                                  }
                                  return null;
                                },
                                onChanged: (val) {
                                  custAddr = val;
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
    // authCubit.register(username: widget.searchResponseModel.custNo!, otp: otp!);
  }
}
