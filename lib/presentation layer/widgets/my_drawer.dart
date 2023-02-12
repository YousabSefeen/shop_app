import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../Business%20Logic%20Layer/cubits/cubit_theme_bottom_na.dart';
import '../../presentation%20layer/screens/home_screen.dart';
import '../../presentation%20layer/screens/theme_screen.dart';

import '../screens/categories_screen.dart';
import '../screens/login_screen.dart';

class MyDrawer extends StatefulWidget {
  const MyDrawer({Key? key}) : super(key: key);

  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  @override
  Widget build(BuildContext context) {
    bool isDark = ThemeAndBNCubit.getObject(context).tm == ThemeMode.dark;
    Size deviceSize = MediaQuery.of(context).size;
    return Drawer(
      backgroundColor: isDark ? Colors.black : Colors.white,
      child: ListView(
        children: [
          Container(
            height: deviceSize.height * 0.2,
            width: double.infinity,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color.fromARGB(255, 0, 0, 51),
                  Color.fromARGB(255, 230, 92, 0),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                stops: [0, 1],
              ),
            ),
            child: Center(
              child: Text(
                'Hello Friend',
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontFamily: 'styleOne',
                  color: Colors.white,
                  fontSize: deviceSize.width * 0.08,
                ),
              ),
            ),
          ),
          SizedBox(height: deviceSize.height * 0.05),
          buildListTile(
            context: context,
            title: 'Products',
            leadingIcon: Icons.home,
            onTap: () {
              Navigator.of(context).pushReplacementNamed(HomeScreen.route);
            },
          ),
          SizedBox(height: deviceSize.height * 0.02),
          const Divider(color: Colors.black),
          buildListTile(
            context: context,
            title: 'Categories',
            leadingIcon: Icons.category_outlined,
            onTap: () {
              Navigator.of(context)
                  .pushReplacementNamed(CategoriesScreen.route);
            },
          ),
          SizedBox(height: deviceSize.height * 0.02),
          const Divider(color: Colors.black),
          buildListTile(
            context: context,
            title: 'Themes',
            leadingIcon: Icons.color_lens_outlined,
            onTap: () {
              Navigator.of(context).pushReplacementNamed(ThemeScreen.route);
            },
          ),
          SizedBox(height: deviceSize.height * 0.02),
          const Divider(color: Colors.black),
          buildListTile(
            context: context,
            title: 'Logout',
            leadingIcon: Icons.login_outlined,
            onTap: () async {
              Navigator.of(context).pushReplacementNamed(LogIngScreen.route);

              var pref = await SharedPreferences.getInstance();

              pref.remove('token');
            },
          ),
          SizedBox(height: deviceSize.height * 0.02),
        ],
      ),
    );
  }

  ListTile buildListTile({
    required BuildContext context,
    required String title,
    required IconData leadingIcon,
    required void Function()? onTap,
  }) {
    bool isDark = ThemeAndBNCubit.getObject(context).tm == ThemeMode.dark;
    return ListTile(
      onTap: onTap,
      leading: Icon(
        leadingIcon,
        size: 25.h,
        color: isDark ? Colors.grey : Colors.black,
      ),
      title: Text(
        title,
        style: TextStyle(
          fontSize: 27.sp,
          color: isDark ? Colors.grey : Colors.black,
          fontWeight: FontWeight.w900,
        ),
      ),
      trailing: Icon(
        Icons.arrow_forward_ios_outlined,
        size: 25.h,
        color: isDark ? Colors.grey : const Color.fromARGB(255, 38, 38, 115),
      ),
    );
  }
}
