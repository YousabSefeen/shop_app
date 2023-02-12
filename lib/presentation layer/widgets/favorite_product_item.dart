import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../Business%20Logic%20Layer/cubits/cubit_theme_bottom_na.dart';

import '../../Business%20Logic%20Layer/states/state_shop_app.dart';
import '../../Data layer/Models/favorites_models.dart';
import '../../presentation%20layer/constants/constants.dart';
import '../../presentation%20layer/screens/product_details_screen.dart';

import '../../Business Logic Layer/cubits/cubit_shop_app.dart';

class FavoriteProductItem extends StatelessWidget {
  final FavoriteSingleProductModel product;

  const FavoriteProductItem({Key? key, required this.product})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size deviceSize = MediaQuery.of(context).size;
    TextTheme textContext = Theme.of(context).textTheme;
    bool isDark = ThemeAndBNCubit.getObject(context).tm == ThemeMode.dark;
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 15.h, horizontal: 25.w),
      child: InkWell(
        onTap: () {
          Navigator.of(context)
              .pushNamed(ProductDetails.route, arguments: product.id);
        },
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(30.r),
              bottomRight: Radius.circular(30.r),
            ),
            side: BorderSide(
              color: isDark ? Colors.white70 : Colors.white,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                alignment: Alignment.topLeft,
                children: [
                  CachedNetworkImage(
                    imageUrl: product.image!,
                    placeholder: (ctx, s) =>
                        Image.asset('assets/images/loading.gif'),
                    errorWidget: (ctx, s, _) =>
                        Image.asset('assets/images/imageError.png'),
                    width: double.infinity,
                    height: deviceSize.height * 0.2,
                    fit: BoxFit.fill,
                  ),
                  if (product.discount != 0)
                    Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 5.h, horizontal: 6.w),
                      color: Colors.red,
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
                    )
                ],
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 8.w),
                child: Text(
                  product.name!,
                  style: textContext.titleSmall,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Chip(
                        label: Text(
                          product.price.toString(),
                          style: textContext.labelLarge,
                        ),
                      ),
                      if (product.discount != 0)
                        Padding(
                          padding: EdgeInsets.only(bottom: 5.0.h, left: 5.w),
                          child: Text(
                            product.oldPrice.toString(),
                            style: textContext.bodyMedium,
                          ),
                        ),
                    ],
                  ),
                  BlocConsumer<ShopAppCubit, ShopAppStates>(
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
                    builder: (context, state) {
                      ShopAppCubit cubit = ShopAppCubit.getObject(context);
                      return IconButton(
                        onPressed: () {
                          cubit.changeFavorite(product.id!);
                        },
                        icon: Icon(
                          Icons.favorite,
                          size: 30.h,
                          color: Colors.amber,
                        ),
                      );
                    },
                  )
                ],
              ),
              SizedBox(height: 5.h),
            ],
          ),
        ),
      ),
    );
  }
}
