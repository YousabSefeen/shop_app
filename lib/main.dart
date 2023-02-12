import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shop_app/presentation%20layer/widgets/theme_mode.dart';

import '../../presentation%20layer/constants/constants.dart';
import '../../presentation%20layer/screens/categories_screen.dart';
import '../../presentation%20layer/screens/home_screen.dart';
import '../../presentation%20layer/screens/login_screen.dart';
import '../../presentation%20layer/screens/onBoarding_screen.dart';
import '../../presentation%20layer/screens/profile_screen.dart';
import '../../presentation%20layer/screens/register_screen.dart';
import '../../presentation%20layer/screens/search_screen.dart';
import '../../presentation%20layer/screens/theme_screen.dart';
import '../../presentation%20layer/screens/product_details_screen.dart';
import 'Business Logic Layer/bloc_observer.dart';
import 'Business Logic Layer/cubits/cubit_login.dart';

import 'Business Logic Layer/cubits/cubit_search.dart';
import 'Business Logic Layer/cubits/cubit_shop_app.dart';
import 'Business Logic Layer/cubits/cubit_theme_bottom_na.dart';
import 'Business Logic Layer/states/state_theme_bottom_na.dart';
import 'Data layer/dio_helper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  DioHelper.dioInit();
  var pref = await SharedPreferences.getInstance();
  token = pref.getString('token');

  if (kDebugMode) {
    print('Token= $token}');
  }

  bool isWatchOnBoard = pref.getBool('isWatchOnBoard') ?? false;

  late Widget mainScreen;

  if (isWatchOnBoard) {
    if (token == null) {
      mainScreen = LogIngScreen();
    }
    if (token != null) {
      mainScreen = const HomeScreen();
    }
  } else {
    mainScreen = const OnBoardingScreen();
  }

  runApp(MyApp(mainScreen));
}

class MyApp extends StatelessWidget {
  final Widget mainScreen;

  const MyApp(this.mainScreen, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => LoginCubit()..getUserData(),
        ),
        BlocProvider(
          create: (context) => SearchCubit(),
        ),
        BlocProvider(
          create: (context) => ThemeAndBNCubit()..getThemePref(),
        ),
        BlocProvider(
          create: (context) => ShopAppCubit()
            ..getHomeData()
            ..getDataCategories()
            ..getDataFavorites(),
        ),
      ],
      child: BlocConsumer<ThemeAndBNCubit, ThemeAndBNStates>(
        listener: (context, state) {},
        builder: (context, state) {
          ThemeAndBNCubit cubit = ThemeAndBNCubit.getObject(context);

          return ScreenUtilInit(
            designSize: const Size(360, 690),
            minTextAdapt: true,
            splitScreenMode: true,
            builder: (context, _) => MaterialApp(
              builder: DevicePreview.appBuilder,
              debugShowCheckedModeBanner: false,
              themeMode: cubit.tm,
              theme: Themes.light,
              darkTheme: Themes.dark,
              routes: {
                '/': (context) => mainScreen,
                ProductDetails.route: (context) => const ProductDetails(),
                ThemeScreen.route: (context) => const ThemeScreen(),
                ProfileScreen.route: (context) => ProfileScreen(),
                HomeScreen.route: (context) => const HomeScreen(),
                CategoriesScreen.route: (context) => const CategoriesScreen(),
                SearchScreen.route: (context) => SearchScreen(),
                RegisterScreen.route: (context) => RegisterScreen(),
                LogIngScreen.route: (context) => LogIngScreen(),
              },
            ),
          );
        },
      ),
    );
  }
}
