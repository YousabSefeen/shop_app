import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../presentation%20layer/screens/favorites_screen.dart';
import '../../presentation%20layer/screens/compile_all_details_screen.dart';
import '../../presentation%20layer/screens/profile_screen.dart';
import '../states/state_theme_bottom_na.dart';

class ThemeAndBNCubit extends Cubit<ThemeAndBNStates> {
  ThemeAndBNCubit() : super(ThemeAndBNInitState());

  static ThemeAndBNCubit getObject(context) => BlocProvider.of(context);

  ThemeMode tm = ThemeMode.system;

  String textTheme = 'system';

  _getTheme(ThemeMode themeMode) {
    if (themeMode == ThemeMode.system) {
      textTheme = 'system';
    } else if (themeMode == ThemeMode.light) {
      textTheme = 'light';
    } else if (themeMode == ThemeMode.dark) {
      textTheme = 'dark';
    }
  }

  onChangeTheme(ThemeMode newTheme) async {
    tm = newTheme;
    _getTheme(tm);

    var pref = await SharedPreferences.getInstance();

    pref.setString('textTheme', textTheme);

    emit(OnChangeThemeState());
  }

  getThemePref() async {
    var pref = await SharedPreferences.getInstance();

    textTheme = pref.getString('textTheme') ?? 'system';

    if (textTheme == 'system') {
      tm = ThemeMode.system;
    } else if (textTheme == 'light') {
      tm = ThemeMode.light;
    } else if (textTheme == 'dark') {
      tm = ThemeMode.dark;
    }

    emit(GetThemePrefState());
  }

  List<Widget> pagesBN = [
    const CompileAllDetailsScreen(),
    const FavoritesScreen(),
    ProfileScreen(),
  ];

  int currentIndex = 0;

  void onTapNb(int index) {
    currentIndex = index;
    emit(OnTapNbState());
  }
}
