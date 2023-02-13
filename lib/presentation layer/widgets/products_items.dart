import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

import '../../Business Logic Layer/cubits/cubit_shop_app.dart';
import '../../Business Logic Layer/states/state_shop_app.dart';

import '../../Data layer/Models/home_model.dart';
import '../constants/constants.dart';
import '../screens/product_details_screen.dart';

class ProductItem extends StatelessWidget {
  const ProductItem({super.key});

  @override
  Widget build(BuildContext context) {
    HomeModel? homeMode = ShopAppCubit.getObject(context).homeModel;
    Size deviceSize = MediaQuery.of(context).size;
    TextTheme textContext = Theme.of(context).textTheme;
    return LayoutBuilder(
      builder: (context, constraints) => GridView.builder(
        shrinkWrap: true,

        /// It is very important that someone else can get me an error
        physics: const NeverScrollableScrollPhysics(),
        padding: EdgeInsets.only(bottom: 20.h),
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 200,
          childAspectRatio: 3 / 5,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20,
        ),
        itemCount: homeMode!.data!.products!.length,

        itemBuilder: (ctx, index) {
          ShopAppCubit cubit = ShopAppCubit.getObject(context);
          return AnimationConfiguration.staggeredGrid(
             position: index,
            duration: const Duration(seconds: 1),

            columnCount: homeMode.data!.products!.length,
            child: SlideAnimation(
              horizontalOffset: 300,
              child: FadeInAnimation(
                child: InkWell(
                  onTap: () {
                    Navigator.of(ctx).pushNamed(
                      ProductDetails.route,
                      arguments: homeMode.data!.products![index].id,
                    );
                  },
                  child: GridTile(
                    footer: ListTile(
                      trailing: BlocConsumer<ShopAppCubit, ShopAppStates>(
                        listener: (context, state) {
                          if (state is ChangeFavoritesSuccessState) {
                            if (state.favoritesMode.status!) {
                              buildSnackBar(
                                context: context,
                                message: state.favoritesMode.message!,
                                textColor: Colors.white,
                              );
                            } else {
                              buildSnackBar(
                                context: context,
                                message: state.favoritesMode.message!,
                                textColor: Colors.red,
                              );
                            }
                          }
                        },
                        builder: (ctx, state) => Padding(
                          padding: EdgeInsets.only(top: 10.h),
                          child: IconButton(
                            onPressed: () {
                              cubit.changeFavorite(
                                  homeMode.data!.products![index].id!);
                            },
                            icon: Icon(
                              cubit.favorites[homeMode.data!.products![index].id] ??
                                      false
                                  ? Icons.favorite
                                  : Icons.favorite_border_outlined,
                              size: 25.h,
                              color: Colors.amber,
                            ),
                          ),
                        ),
                      ),
                    ),
                    child: Card(
                      child: Column(
                        children: [
                          Stack(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(12.r),
                                child: Hero(
                                  tag: homeMode.data!.products![index].id!,
                                  child: CachedNetworkImage(
                                    imageUrl:
                                        homeMode.data!.products![index].image!,
                                    errorWidget: (context, s, _) =>
                                        Image.asset('assets/images/imageError.png'),
                                    placeholder: (context, _) =>
                                        Image.asset('assets/images/loading.gif'),
                                    height: deviceSize.height * 0.15,
                                    width: double.infinity,
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              ),
                              if (homeMode.data!.products![index].discount != 0)
                                Container(
                                  padding: EdgeInsets.only(
                                      top: 3.h, bottom: 3.h, left: 7.w, right: 2.w),
                                  decoration: BoxDecoration(
                                    color: Colors.red,
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(12.r),
                                    ),
                                  ),
                                  child: RichText(
                                    text: TextSpan(
                                      text: 'Discount ',
                                      style: textContext.labelSmall,
                                      children: [
                                        TextSpan(
                                          text:
                                              '${homeMode.data!.products![index].discount}%',
                                          style: textContext.labelMedium,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                            ],
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                              vertical: deviceSize.height * 0.015,
                              horizontal: deviceSize.width * 0.015,
                            ),
                            child: Column(
                              children: [
                                Text(
                                  homeMode.data!.products![index].name!,
                                  style: textContext.titleSmall,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Chip(
                                      label: Text(
                                        '${homeMode.data!.products![index].price}',
                                        style: textContext.labelLarge,
                                      ),
                                    ),
                                    if (homeMode.data!.products![index].discount !=
                                        0)
                                      Container(
                                        constraints: BoxConstraints(
                                          maxWidth: 45.w,
                                        ),
                                        child: FittedBox(
                                          child: Text(
                                            '${homeMode.data!.products![index].oldPrice}',
                                            style: textContext.bodyMedium,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                      ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
