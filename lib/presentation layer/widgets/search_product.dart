import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../Business%20Logic%20Layer/cubits/cubit_shop_app.dart';
import '../../Business%20Logic%20Layer/states/state_shop_app.dart';
import '../../Data layer/Models/search_model.dart';
import '../../presentation%20layer/screens/product_details_screen.dart';

class SearchProduct extends StatelessWidget {
  final DataSearch product;

  const SearchProduct(this.product, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ShopAppCubit cubit = ShopAppCubit.getObject(context);
    Size deviceSize = MediaQuery.of(context).size;
    TextTheme textContext = Theme.of(context).textTheme;
    return InkWell(
      onTap: () {
        Navigator.of(context)
            .pushNamed(ProductDetails.route, arguments: product.id);
      },
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 8.w),
        child: Card(
          child: SizedBox(
            height: deviceSize.height * 0.2,
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(12.r),
                    bottomLeft: Radius.circular(12.r),
                  ),
                  child: CachedNetworkImage(
                    imageUrl: product.image!,
                    placeholder: (ctx, s) =>
                        Image.asset('assets/images/loading.gif'),
                    errorWidget: (ctx, s, _) =>
                        Image.asset('assets/images/imageError.png'),
                    height: double.infinity,
                    width: deviceSize.width * 0.35,
                    fit: BoxFit.fill,
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          product.name!,
                          style: textContext.titleSmall,
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const Spacer(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Chip(
                              label: Text(
                                product.price.toString(),
                                style: textContext.labelLarge,
                              ),
                            ),
                            BlocConsumer<ShopAppCubit, ShopAppStates>(
                              listener: (context, state) {},
                              builder: (context, state) => IconButton(
                                onPressed: () {
                                  cubit.changeFavorite(product.id!);
                                },
                                icon: Icon(
                                  cubit.favorites[product.id] ?? false
                                      ? Icons.favorite
                                      : Icons.favorite_border_outlined,
                                  color: Colors.amber,
                                  size: 25.h,
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
