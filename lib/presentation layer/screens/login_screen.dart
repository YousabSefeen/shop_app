import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../Business%20Logic%20Layer/cubits/cubit_shop_app.dart';
import '../../Business%20Logic%20Layer/cubits/cubit_theme_bottom_na.dart';

import '../../presentation%20layer/constants/constants.dart';
import '../../presentation%20layer/screens/home_screen.dart';

import '../../presentation%20layer/screens/register_screen.dart';
import '../../presentation%20layer/widgets/custom_button_login.dart';

import '../../Business Logic Layer/cubits/cubit_login.dart';
import '../../Business Logic Layer/states/state_login.dart';
import '../widgets/custom_text_field.dart';
import '../widgets/login_register_background.dart';

class LogIngScreen extends StatelessWidget {
  static const route = 'LogIngScreen';

  final _emailController = TextEditingController();

  final _passwordController = TextEditingController();

  final _globalKer = GlobalKey<FormState>();

  LogIngScreen({super.key});

  @override
  Widget build(BuildContext context) {
    ShopAppCubit shopCubit = ShopAppCubit.getObject(context);
    LoginCubit loginCubit = LoginCubit.getObject(context);
    ThemeAndBNCubit themeCubit = ThemeAndBNCubit.getObject(context);
    return BlocConsumer<LoginCubit, LoginStates>(
      listener: (context, state) async {
        if (state is LoginSuccessState) {
          if (state.logInModel.status!) {
            /// If the case is correct, then the registration is complete
            Navigator.of(context).pushReplacementNamed(HomeScreen.route);
            SharedPreferences pref = await SharedPreferences.getInstance();

            pref.setString('token', state.logInModel.data!.token!);
            token = state.logInModel.data!.token!;

            shopCubit.getDataFavorites();
            shopCubit.getHomeData();
            loginCubit.getUserData();
            themeCubit.currentIndex = 0;

            myToast(
              context: context,
              message: '${state.logInModel.message}',
              color: Colors.green,
            );
          } else {
            myToast(
              context: context,
              message: '${state.logInModel.message}',
              color: Colors.red,
            );
          }
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: LayoutBuilder(
            builder: (context, constraints) => Stack(
               alignment: Alignment.center,
              children: [
                const LoginRegBackground(),
                Form(
                  key: _globalKer,
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 20.w,
                    ),
                    child: SingleChildScrollView(
                      child: Column(
                       // mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Center(
                            child: Text(
                              'Welcome Back',
                              style: TextStyle(
                                  fontSize: 40.sp,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white,
                                  fontFamily: 'styleOne'),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          SizedBox(height: 10.h),
                          Center(
                            child: Text(
                              'Login to your account',
                              style: TextStyle(
                                fontSize: 20.sp,
                                color: Colors.white,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          SizedBox(height: 20.h),
                          CustomTextField(
                            controller: _emailController,
                            isLoginScreen: true,
                            hint: 'Email-Address',
                            prefixIcon: Icons.email_rounded,
                            obscureText: false,
                            radius: 12.r,
                            textInputType: TextInputType.emailAddress,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'field email must be not empty';
                              } else if (!value.contains('@')) {
                                return 'Invalid Email';
                              } else {
                                return null;
                              }
                            },
                          ),
                          CustomTextField(
                            controller: _passwordController,
                            isLoginScreen: true,
                            hint: 'Password',
                            prefixIcon: Icons.lock_clock_outlined,
                            radius: 12,
                            textInputType: TextInputType.visiblePassword,
                            validator: (value) {
                              if (value!.isEmpty || value.length < 5) {
                                return 'Password is too short';
                              } else {
                                return null;
                              }
                            },
                            obscureText: loginCubit.isShowPass ? true : false,
                            suffixIcon: IconButton(
                              onPressed: () {
                                loginCubit.toggleIconPass();
                              },
                              icon: Icon(
                                loginCubit.icon,
                                size: 20.h,
                                color: const Color.fromARGB(255, 38, 38, 115),
                              ),
                            ),
                          ),
                          SizedBox(height: 10.h),
                          Center(
                            child: ConditionalBuilder(
                              condition: state is! LoginLoadingState,
                              fallback: (context) => const Center(
                                child: CircularProgressIndicator(),
                              ),
                              builder: (context) => FittedBox(
                                child: CustomButtonLogin(
                                  text: 'LOGIN',
                                  onTap: () {
                                    if (_globalKer.currentState!.validate()) {
                                      FocusScope.of(context).unfocus();
                                      loginCubit.userLogin(
                                        email: _emailController.text,
                                        password: _passwordController.text,
                                      );
                                    }
                                  },
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 7.h),
                          Row(
                            children: [
                              Text(
                                'Don\'t have an account ?',
                                style: TextStyle(
                                  fontSize: 15.sp,
                                  color: Colors.black,
                                ),
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context)
                                      .pushNamed(RegisterScreen.route);
                                },
                                child: Text(
                                  'Sign Up',
                                  style: TextStyle(
                                    fontSize: 25.sp,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

