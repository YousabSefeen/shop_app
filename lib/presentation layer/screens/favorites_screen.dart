import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../Business Logic Layer/cubits/cubit_shop_app.dart';

import '../../Business Logic Layer/states/state_shop_app.dart';
import '../widgets/favorite_product_item.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopAppCubit, ShopAppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        ShopAppCubit cubit = ShopAppCubit.getObject(context);
        return ConditionalBuilder(
          condition: cubit.favoritesModels != null,
          fallback: (_) => const Center(
            child: CircularProgressIndicator(),
          ),
          builder: (_) => cubit.favoritesModels!.data!.data!.isEmpty
              ? Center(
                  child: Text(
                    'Your favorites list is empty.',
                    style: Theme.of(context).textTheme.bodyLarge,
                    textAlign: TextAlign.center,
                  ),
                )
              : ListView.builder(
                  shrinkWrap: true,
                  physics: const BouncingScrollPhysics(),
                  itemCount: cubit.favoritesModels!.data!.data!.length,
                  itemBuilder: (context, index) => FavoriteProductItem(
                    product: cubit.favoritesModels!.data!.data![index].product!,
                    position: index,
                  ),
                ),
        );
      },
    );
  }
}
