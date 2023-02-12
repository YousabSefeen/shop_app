import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../Business Logic Layer/cubits/cubit_theme_bottom_na.dart';
import '../../Business Logic Layer/states/state_theme_bottom_na.dart';
import '../../presentation%20layer/widgets/my_drawer.dart';

class ThemeScreen extends StatelessWidget {
  static const route = 'ThemeScreen';

  const ThemeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ThemeAndBNCubit, ThemeAndBNStates>(
      listener: (context, state) {},
      builder: (context, state) {
        ThemeAndBNCubit themeCubit = ThemeAndBNCubit.getObject(context);
        bool isDark = themeCubit.tm == ThemeMode.dark;
        Size deviceSize = MediaQuery.of(context).size;
        return Scaffold(
          appBar: AppBar(
            leading: Builder(
              builder: (context) => IconButton(
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
                icon: Icon(
                  Icons.menu,
                  color: isDark ? Colors.grey : Colors.black,
                  size: deviceSize.width * 0.08,
                ),
              ),
            ),
          ),
          drawer: const MyDrawer(),
          body: Column(
            children: [
              SizedBox(height: deviceSize.height * 0.1),
              Center(
                child: Text(
                  'Choose your theme mode.',
                  style: Theme.of(context).textTheme.bodyLarge,
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: deviceSize.height * 0.1),
              buildRadioListTile(
                title: 'System Default',
                value: ThemeMode.system,
                groupValue: themeCubit.tm,
                onChanged: (newTheme) {
                  themeCubit.onChangeTheme(newTheme!);
                },
                context: context,
              ),
              buildRadioListTile(
                title: 'Light Mode',
                secondaryIcon: Icons.sunny,
                secondaryIconColor: Colors.amber,
                value: ThemeMode.light,
                groupValue: themeCubit.tm,
                onChanged: (newTheme) {
                  themeCubit.onChangeTheme(newTheme!);
                },
                context: context,
              ),
              buildRadioListTile(
                title: 'Dark Mode',
                secondaryIcon: Icons.dark_mode_rounded,
                secondaryIconColor: isDark ? Colors.grey : Colors.black,
                value: ThemeMode.dark,
                groupValue: themeCubit.tm,
                onChanged: (newTheme) {
                  themeCubit.onChangeTheme(newTheme!);
                },
                context: context,
              ),
            ],
          ),
        );
      },
    );
  }

  RadioListTile<ThemeMode> buildRadioListTile({
    required String title,
    IconData? secondaryIcon,
    Color? secondaryIconColor,
    required ThemeMode value,
    required ThemeMode groupValue,
    required void Function(ThemeMode?)? onChanged,
    required BuildContext context,
  }) {
    return RadioListTile(
      activeColor: Colors.amber,
      contentPadding: EdgeInsets.symmetric(
        vertical: 10.h,
        horizontal: 20.w,
      ),
      title: Text(
        title,
        style:
            Theme.of(context).textTheme.titleSmall!.copyWith(fontSize: 25.sp),
      ),
      secondary: Icon(
        secondaryIcon,
        size: 35.h,
        color: secondaryIconColor,
      ),
      value: value,
      groupValue: groupValue,
      onChanged: onChanged,
    );
  }
}
