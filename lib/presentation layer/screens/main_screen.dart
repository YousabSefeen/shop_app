import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shop_app/presentation%20layer/screens/search_screen.dart';

import '../../Business Logic Layer/cubits/cubit_theme_bottom_na.dart';
import '../../Business Logic Layer/states/state_theme_bottom_na.dart';

import '../widgets/my_drawer.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ThemeAndBNCubit, ThemeAndBNStates>(
        listener: (context, state) {},
        builder: (context, state) {
          ThemeAndBNCubit cubit = ThemeAndBNCubit.getObject(context);
          bool isDark = ThemeAndBNCubit.getObject(context).tm == ThemeMode.dark;

          return Scaffold(
              drawer: const MyDrawer(),
              appBar: AppBar(
                centerTitle: true,
                leading: Builder(
                  builder: (context) => Padding(
                    padding: EdgeInsets.only(left: 8.w),
                    child: IconButton(
                      onPressed: () => Scaffold.of(context).openDrawer(),
                      icon: Icon(
                        Icons.menu,
                        color: isDark ? Colors.grey : Colors.black,
                        size: 35.h,
                      ),
                    ),
                  ),
                ),
                actions: [
                  Padding(
                    padding: EdgeInsets.only(right: 8.w),
                    child: IconButton(
                      onPressed: () {
                        Navigator.of(context).pushNamed(SearchScreen.route);
                      },
                      icon: Icon(
                        Icons.search,
                        size: 30.h,
                        color: isDark ? Colors.grey : Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
              bottomNavigationBar: BottomNavigationBar(
                onTap: (index) {
                  cubit.onTapNb(index);
                },
                currentIndex: cubit.currentIndex,
                items: const [
                  BottomNavigationBarItem(
                    label: '',
                    icon: Icon(
                      Icons.home,
                    ),
                  ),
                  BottomNavigationBarItem(
                    label: '',
                    icon: Icon(
                      Icons.favorite,
                    ),
                  ),
                  BottomNavigationBarItem(
                    label: '',
                    icon: Icon(
                      Icons.person,
                    ),
                  ),
                ],
              ),
              body: cubit.pagesBN[cubit.currentIndex]);
        });
  }
}
