import 'package:cached_network_image/cached_network_image.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../Business Logic Layer/cubits/cubit_theme_bottom_na.dart';
import '../../presentation%20layer/widgets/my_drawer.dart';

import '../../Business Logic Layer/cubits/cubit_shop_app.dart';
import '../../Business Logic Layer/states/state_shop_app.dart';

class CategoriesScreen extends StatelessWidget {
  static const route = 'CategoriesScreen';

  const CategoriesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size deviceSize = MediaQuery.of(context).size;
    bool isDark = ThemeAndBNCubit.getObject(context).tm == ThemeMode.dark;
    TextTheme textContext = Theme.of(context).textTheme;

    return BlocConsumer<ShopAppCubit, ShopAppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        ShopAppCubit cubit = ShopAppCubit.getObject(context);
        return Scaffold(
          appBar: AppBar(
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
          ),
          drawer: const MyDrawer(),
          body: ConditionalBuilder(
            condition: cubit.categoriesModel != null,
            fallback: (context) =>
                const Center(child: CircularProgressIndicator()),
            builder: (_) => ListView.separated(
              padding: EdgeInsets.symmetric(vertical: 18.h, horizontal: 12.w),
              scrollDirection: Axis.vertical,
              physics: const BouncingScrollPhysics(),
              shrinkWrap: true,
              itemCount: cubit.categoriesModel!.data!.dataModel!.length,
              separatorBuilder: (ctx, _) => Divider(
                color: isDark ? Colors.grey : Colors.black,
              ),
              itemBuilder: (ctx, index) {
                return Padding(
                  padding:
                      EdgeInsets.symmetric(vertical: 15.h, horizontal: 5.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      CachedNetworkImage(
                        imageUrl: cubit
                            .categoriesModel!.data!.dataModel![index].image!,
                        errorWidget: (context, s, _) =>
                            Image.asset('assets/images/imageError.png'),
                        placeholder: (context, _) =>
                            Image.asset('assets/images/loading.gif'),
                        fit: BoxFit.cover,
                        width: deviceSize.width * 0.4,
                        height: deviceSize.height * 0.2,
                      ),
                      SizedBox(
                        width: deviceSize.width * 0.4,
                        child: Text(
                          cubit.categoriesModel!.data!.dataModel![index].name!,
                          style: textContext.titleSmall!.copyWith(
                            fontSize: 25.sp,
                          ),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                        ),
                      ),
                      Icon(
                        Icons.arrow_forward_ios_outlined,
                        size: 20.h,
                        color: textContext.titleSmall!.color,
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }
}
