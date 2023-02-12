import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import 'package:cached_network_image/cached_network_image.dart';

import '../../Business Logic Layer/cubits/cubit_shop_app.dart';
import '../../Data layer/Models/home_model.dart';

class BannersItems extends StatelessWidget {
  const BannersItems({super.key});

  @override
  Widget build(BuildContext context) {
    HomeModel? homeModel = ShopAppCubit.getObject(context).homeModel;
    return CarouselSlider.builder(
      itemCount: homeModel!.data!.banners!.length,
      options: CarouselOptions(
        height: double.infinity,
        autoPlay: true,
        enlargeCenterPage: true,
        scrollDirection: Axis.vertical,
      ),
      itemBuilder: (context, index, _) => CachedNetworkImage(
        imageUrl: homeModel.data!.banners![index].image!,
        errorWidget: (context, s, _) =>
            Image.asset('assets/images/imageError.png'),
        placeholder: (context, _) => Image.asset('assets/images/loading.gif'),
        width: double.infinity,
        fit: BoxFit.cover,
      ),
    );
  }
}
