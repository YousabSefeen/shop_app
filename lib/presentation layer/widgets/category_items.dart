import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../Business Logic Layer/cubits/cubit_shop_app.dart';
import '../../Data layer/Models/categories_model.dart';

class CategoryItem extends StatelessWidget {
  const CategoryItem({super.key});

  @override
  Widget build(BuildContext context) {
    CategoriesModel? category = ShopAppCubit.getObject(context).categoriesModel;
    Size deviceSize = MediaQuery.of(context).size;
    return ListView.builder(
      padding: EdgeInsets.symmetric(horizontal: deviceSize.width * 0.015),
      itemCount: category!.data!.dataModel!.length,
      scrollDirection: Axis.horizontal,
      physics: const BouncingScrollPhysics(),
      itemBuilder: (ctx, index) {
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(360),
                child: CachedNetworkImage(
                  imageUrl: category.data!.dataModel![index].image!,
                  errorWidget: (context, s, _) =>
                      Image.asset('assets/images/imageError.png'),
                  placeholder: (context, _) =>
                      Image.asset('assets/images/loading.gif'),
                  fit: BoxFit.cover,
                  width: deviceSize.width * 0.3,
                  height: deviceSize.height * 0.15,
                ),
              ),
              SizedBox(
                width: deviceSize.width * 0.3,
                child: Text(
                  category.data!.dataModel![index].name!,
                  style: Theme.of(context).textTheme.bodySmall,
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

