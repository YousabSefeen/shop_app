import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../Business Logic Layer/cubits/cubit_shop_app.dart';
import '../../Business Logic Layer/cubits/cubit_theme_bottom_na.dart';
import '../../Business Logic Layer/states/state_shop_app.dart';
import '../../Data layer/Models/home_model.dart';

class ProductDetails extends StatelessWidget {
  static const route = 'ProductDetails';

  const ProductDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ShopAppCubit cubit = ShopAppCubit.getObject(context);

    int id = ModalRoute.of(context)!.settings.arguments as int;

    ProductModel product = cubit.homeModel!.data!.products!
        .firstWhere((element) => element.id == id);

    bool isDark = ThemeAndBNCubit.getObject(context).tm == ThemeMode.dark;
    Size deviceSize = MediaQuery.of(context).size;
    TextTheme textContext = Theme.of(context).textTheme;
    return BlocConsumer<ShopAppCubit, ShopAppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          floatingActionButtonLocation:
              FloatingActionButtonLocation.miniCenterFloat,
          floatingActionButton: FloatingActionButton.extended(
            onPressed: () {
              cubit.changeFavorite(product.id!);
            },
            backgroundColor: const Color.fromARGB(255, 38, 38, 115),
            label:   Text(
              'Favorite',
              style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w800,
                  color: Colors.white),
            ),
            icon: Icon(
              cubit.favorites[product.id!] ?? false
                  ? Icons.favorite
                  : Icons.favorite_border_outlined,
              size: 20.h,
              color: Colors.amber,
            ),
          ),
          body: CustomScrollView(
            slivers: [
              SliverAppBar(
                leading: Padding(
                  padding: EdgeInsets.only(top: 12.h, left: 12.w),
                  child: CircleAvatar(
                    backgroundColor: Colors.black54,
                    child: IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: Icon(
                        Icons.arrow_back_ios,
                        color: Colors.white,
                        size: 20.h,
                      ),
                    ),
                  ),
                ),
                expandedHeight: deviceSize.height * 0.4,
                pinned: true,
                flexibleSpace: FlexibleSpaceBar(
                  background: Hero(
                    tag: product.id!,
                    child: CachedNetworkImage(
                      imageUrl: product.image!,
                      errorWidget: (context, s, _) =>
                          Image.asset('assets/images/imageError.png'),
                      placeholder: (context, _) =>
                          Image.asset('assets/images/loading.gif'),
                      fit: BoxFit.fill,
                      width: double.infinity,
                    ),
                  ),
                ),
              ),
              SliverList(
                delegate: SliverChildListDelegate(
                  [
                    SizedBox(height: deviceSize.height * 0.05),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: 5.h,
                        horizontal: 15.w,
                      ),
                      child: Card(
                        elevation: 8,
                        color: isDark
                            ? Colors.white12
                            : const Color.fromARGB(255, 38, 38, 115),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            vertical: 8.0.h,
                            horizontal: 8.w,
                          ),
                          child: Column(
                            children: [
                              Text(
                                product.name!,
                                style: textContext.displaySmall,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 3,
                              ),
                              if (product.discount != 0)
                                Container(
                                  color: Colors.red,
                                  padding: EdgeInsets.symmetric(
                                    vertical: 5.h,
                                    horizontal: 7.w,
                                  ),
                                  margin: EdgeInsets.symmetric(vertical: 7.h),
                                  child: RichText(
                                    text: TextSpan(
                                      text: 'Discount ',
                                      style: textContext.labelSmall,
                                      children: <TextSpan>[
                                        TextSpan(
                                          text: '${product.discount}%',
                                          style: textContext.labelMedium,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        'Price: ',
                                        style: textContext.displaySmall!
                                            .copyWith(fontSize: 20.sp),
                                      ),
                                      Chip(
                                        backgroundColor: Colors.amber,
                                        label: Text(
                                          '${product.price}',
                                          style:
                                              textContext.labelLarge!.copyWith(
                                            color: Colors.black,
                                            fontWeight: FontWeight.w800,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  if (product.discount != 0)
                                    Row(
                                      children: [
                                        Text(
                                          'Old Price: ',
                                          style: textContext.displaySmall!
                                              .copyWith(fontSize: 20.sp),
                                        ),
                                        Chip(
                                          backgroundColor: Colors.grey,
                                          label: Text(
                                            '${product.oldPrice}',
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 10.sp,
                                            ),
                                          ),
                                        ),
                                      ],
                                    )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: deviceSize.height * 0.2,
                      child: ListView.builder(
                        shrinkWrap: true,
                        physics: const BouncingScrollPhysics(),
                        padding: EdgeInsets.symmetric(
                          vertical: 10.h,
                          horizontal: 15.w,
                        ),
                        scrollDirection: Axis.horizontal,
                        itemCount: product.images!.length,
                        itemBuilder: (ctx, index) {
                          return Padding(
                            padding: EdgeInsets.symmetric(
                              vertical: 8.h,
                              horizontal: 8.w,
                            ),
                            child: CachedNetworkImage(
                              imageUrl: product.images![index],
                              errorWidget: (context, s, _) =>
                                  Image.asset('assets/images/imageError.png'),
                              placeholder: (context, _) =>
                                  Image.asset('assets/images/loading.gif'),
                              fit: BoxFit.fill,
                              width: deviceSize.width * 0.5,
                            ),
                          );
                        },
                      ),
                    ),
                    Text(
                      'Description',
                      style: textContext.titleMedium,
                      textAlign: TextAlign.center,
                    ),
                    Card(
                      color: isDark
                          ? const Color.fromARGB(255, 57, 38, 115)
                          : Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r),
                        side: BorderSide(
                          color: isDark
                              ? const Color.fromARGB(255, 57, 38, 115)
                              : Colors.white,
                        ),
                      ),
                      margin: EdgeInsets.symmetric(
                        vertical: 12.h,
                        horizontal: 30.w,
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: 10.h,
                          horizontal: 20.w,
                        ),
                        child: Text(
                          product.description!,
                          style: Theme.of(context).textTheme.titleSmall,
                        ),
                      ),
                    ),
                    SizedBox(height: deviceSize.height * 0.05),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
