import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../presentation%20layer/widgets/banners_items.dart';
import '../../presentation%20layer/widgets/category_items.dart';
import '../../presentation%20layer/widgets/products_items.dart';

import '../../Business Logic Layer/cubits/cubit_shop_app.dart';
import '../../Business Logic Layer/states/state_shop_app.dart';

class CompileAllDetailsScreen extends StatelessWidget {
  const CompileAllDetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double deviceWidth = MediaQuery.of(context).size.width;
    double deviceHeight = MediaQuery.of(context).size.height;
    return BlocConsumer<ShopAppCubit, ShopAppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        ShopAppCubit cubit = ShopAppCubit.getObject(context);
        return ConditionalBuilder(
          condition: cubit.homeModel != null && cubit.categoriesModel != null,
          fallback: (context) => const Center(
            child: CircularProgressIndicator(),
          ),
          builder: (context) {
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: deviceWidth * 0.05),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: deviceHeight * 0.20,
                      child: const BannersItems(),
                    ),
                    SizedBox(
                      height: deviceHeight * 0.10,
                      child:
                          FittedBox(child: buildText('Collections', context)),
                    ),
                    SizedBox(
                      height: deviceHeight * 0.20,
                      child: const CategoryItem(),
                    ),
                    SizedBox(
                      height: deviceHeight * 0.10,
                      child:
                          FittedBox(child: buildText('Best Selling', context)),
                    ),
                    const ProductItem(),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget buildText(String text, BuildContext context) {
    Size deviceSize = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: deviceSize.height * 0.015,
      ),
      child: Text(
        text,
        style: Theme.of(context).textTheme.titleLarge,
      ),
    );
  }
}
