import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../presentation%20layer/constants/constants.dart';
import '../../presentation%20layer/widgets/custom_button.dart';

import '../../presentation%20layer/screens/login_screen.dart';
import '../../presentation%20layer/widgets/custom_text_field.dart';

import '../../Business Logic Layer/cubits/cubit_login.dart';
import '../../Business Logic Layer/states/state_login.dart';

class ProfileScreen extends StatelessWidget {
  static const route = 'ProfileScreen';

  final _formKey = GlobalKey<FormState>();

  ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    LoginCubit cubit = LoginCubit.getObject(context);
    return BlocConsumer<LoginCubit, LoginStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          body: SafeArea(
            child: ConditionalBuilder(
              condition: LoginCubit.getObject(context).userData != null,
              fallback: (context) => const Center(
                child: CircularProgressIndicator(),
              ),
              builder: (context) => Padding(
                padding: EdgeInsets.symmetric(horizontal: 22.w),
                child: Form(
                  key: _formKey,
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (state is UpdateProfileLoadingState)
                          const LinearProgressIndicator(),
                        SizedBox(height: 18.h),
                        buildTitle(context, 'Name'),
                        CustomTextField(
                          obscureText: false,
                          prefixIcon: Icons.person,
                          radius: 20.r,
                          textInputType: TextInputType.text,
                          controller: cubit.nameController,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter your name';
                            } else {
                              return null;
                            }
                          },
                        ),
                        buildTitle(context, 'Email-Address'),
                        CustomTextField(
                          obscureText: false,
                          controller: cubit.emailController,
                          prefixIcon: Icons.alternate_email_outlined,
                          radius: 20.r,
                          textInputType: TextInputType.emailAddress,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter your name';
                            } else if (!value.contains('@')) {
                              return 'The email format is incorrect';
                            } else {
                              return null;
                            }
                          },
                        ),
                        buildTitle(context, 'Phone Number'),
                        CustomTextField(
                          obscureText: false,
                          controller: cubit.phoneController,
                          prefixIcon: Icons.phone_android_outlined,
                          radius: 20.r,
                          textInputType: TextInputType.number,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter your name';
                            } else {
                              return null;
                            }
                          },
                        ),
                        SizedBox(height: 9.h),
                        Center(
                          child: CustomButton(
                            text: 'UPDATE DATA',
                            onTap: () {
                              if (_formKey.currentState!.validate()) {
                                LoginCubit.getObject(context).updateProfile(
                                  name: cubit.nameController.text,
                                  email: cubit.emailController.text,
                                  phone: cubit.phoneController.text,
                                );
                                buildSnackBar(
                                  context: context,
                                  message: 'Profile updated',
                                  textColor: Colors.white,
                                );
                              } else {
                                buildSnackBar(
                                  context: context,
                                  message: 'Please enter the data correctly',
                                  textColor: Colors.red,
                                );
                              }
                            },
                          ),
                        ),
                        SizedBox(height: 13.h),
                        Center(
                          child: CustomButton(
                            text: 'LOGOUT',
                            onTap: () async {
                              Navigator.of(context)
                                  .pushReplacementNamed(LogIngScreen.route);
                              SharedPreferences pref = await SharedPreferences.getInstance();

                              if (kDebugMode) {
                                print(pref.getString('token'));
                                print(token);
                              }

                              pref.remove('token');
                              token = null;

                              if (kDebugMode) {
                                print(pref.getString('token'));
                                print(token);
                              }
                            },
                          ),
                        ),
                        SizedBox(height: 10.h),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Padding buildTitle(BuildContext context, String title) {
    return Padding(
      padding: EdgeInsets.only(top: 12.h),
      child: Text(
        title,
        style: Theme.of(context).textTheme.bodyLarge,
      ),
    );
  }
}

