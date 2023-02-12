import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Business Logic Layer/cubits/cubit_login.dart';
import '../../Business Logic Layer/cubits/cubit_shop_app.dart';
import '../../Business Logic Layer/cubits/cubit_theme_bottom_na.dart';
import '../../Business Logic Layer/states/state_login.dart';
import '../../presentation%20layer/widgets/custom_text_field.dart';

import '../constants/constants.dart';
import '../widgets/login_register_background.dart';
import '../widgets/custom_button_login.dart';
import 'home_screen.dart';

class RegisterScreen extends StatelessWidget {
  static const route = 'RegisterScreen';

  RegisterScreen({Key? key}) : super(key: key);

  final _globalKer = GlobalKey<FormState>();

  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  final _phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    ShopAppCubit shopCubit = ShopAppCubit.getObject(context);
    LoginCubit loginCubit = LoginCubit.getObject(context);
    ThemeAndBNCubit themeCubit = ThemeAndBNCubit.getObject(context);
    return BlocConsumer<LoginCubit, LoginStates>(
      listener: (context, state) async {
        if (state is RegisterSuccessState) {
          if (state.registerModel.status!) {
            // If the case is correct, then the registration is complete
            Navigator.of(context).pushReplacementNamed(HomeScreen.route);
            themeCubit.currentIndex = 0;
            var pref = await SharedPreferences.getInstance();

            pref.setString('token', state.registerModel.data!.token!);

            token = state.registerModel.data!.token!;
            shopCubit.getHomeData();
            shopCubit.getDataFavorites();
            loginCubit.getUserData();
            myToast(
              context: context,
              message: '${state.registerModel.message}',
              color: Colors.green,
            );


          } else {
            myToast(
              context: context,
              message: '${state.registerModel.message}',
              color: Colors.red,
            );
          }
        }
      },
      builder: (context, state) {
        var cubit = LoginCubit.getObject(context);
        return Scaffold(
          body: Stack(
            alignment: Alignment.center,
            children: [
              const LoginRegBackground(),
              Form(
                key: _globalKer,
                child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: 15.h,
                      horizontal: 20.w,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Align(
                          alignment: Alignment.topLeft,
                          child: IconButton(
                            onPressed: () => Navigator.pop(context),
                            icon: Icon(
                              Icons.arrow_back_ios,
                              size: 25.h,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        Center(
                          child: Text(
                            'Register',
                            style: TextStyle(
                                fontSize: 50.sp,
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                                fontFamily: 'styleOne'),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Center(
                          child: Text(
                            'Create your account',
                            style: TextStyle(
                              fontSize: 18.sp,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        SizedBox(height: 10.h),
                        CustomTextField(
                          controller: _nameController,
                          isLoginScreen: true,
                          hint: 'User Name',
                          obscureText: false,
                          prefixIcon: Icons.person,
                          radius: 20,
                          textInputType: TextInputType.text,
                          validator: (value) {
                            if (value == '') {
                              return 'Please enter your name';
                            } else {
                              return null;
                            }
                          },
                        ),




                        CustomTextField(
                          controller: _phoneController,
                          isLoginScreen: true,
                          hint: 'Phone Number',
                          obscureText: false,
                          prefixIcon: Icons.phone,
                          radius: 20,
                          textInputType: TextInputType.phone,
                          validator: (value) {
                            if (value == '') {
                              return 'Please enter your phone number';
                            } else {
                              return null;
                            }
                          },
                        ),

                        CustomTextField(
                          controller: _emailController,
                          isLoginScreen: true,
                          hint: 'Email-Address',
                          obscureText: false,
                          prefixIcon: Icons.email_outlined,
                          radius: 20,
                          textInputType: TextInputType.emailAddress,
                          validator: (value) {
                            if (value == '') {
                              return 'Please enter your name';
                            } else if (!value!.contains('@')) {
                              return 'The email format is incorrect';
                            } else {
                              return null;
                            }
                          },
                        ),
                        CustomTextField(
                          controller: _passwordController,
                          isLoginScreen: true,
                          hint: 'password',
                          prefixIcon: Icons.lock_clock_outlined,
                          radius: 20,
                          textInputType: TextInputType.visiblePassword,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'please enter your password';
                            } else if (value.length < 6) {
                              return 'Password is too short';
                            } else {
                              return null;
                            }
                          },
                          obscureText: cubit.isShowPass ? true : false,
                          suffixIcon: IconButton(
                            onPressed: () {
                              cubit.toggleIconPass();
                            },
                            icon: Icon(
                              cubit.icon,
                              size: 20.h,
                              color: const Color.fromARGB(255, 38, 38, 115),
                            ),
                          ),
                        ),
                        CustomTextField(
                          hint: 'Confirm Password',
                          isLoginScreen: true,
                          prefixIcon: Icons.lock_clock_outlined,
                          radius: 20,
                          textInputType: TextInputType.visiblePassword,
                          validator: (value) {
                            if (value != _passwordController.text) {
                              return 'password do not match';
                            } else {
                              return null;
                            }
                          },
                          obscureText: cubit.isShowPass ? true : false,
                          suffixIcon: IconButton(
                            onPressed: () {
                              cubit.toggleIconPass();
                            },
                            icon: Icon(
                              cubit.icon,
                              size: 20.h,
                              color: const Color.fromARGB(255, 38, 38, 115),
                            ),
                          ),
                        ),
                        SizedBox(height: 10.h),
                        Center(
                          child: ConditionalBuilder(
                            condition: state is! RegisterLoadingState,
                            fallback: (_) => const CircularProgressIndicator(),
                            builder: (_) => CustomButtonLogin(
                              text: 'REGISTER NOW',
                              onTap: () {
                                if (_globalKer.currentState!.validate()) {
                                  FocusScope.of(context).unfocus();
                                  cubit.userRegister(
                                    name: _nameController.text,
                                    email: _emailController.text,
                                    password: _passwordController.text,
                                    phone: _phoneController.text,
                                  );
                                }
                              },
                            ),
                          ),
                        ),
                        SizedBox(height: 10.h),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
