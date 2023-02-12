import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../Data layer/Models/categories_model.dart';
import '../../Data layer/Models/favorites_add_and_delete_mode.dart';
import '../../Data layer/Models/favorites_models.dart';
import '../../Data layer/Models/home_model.dart';
import '../../presentation%20layer/constants/constants.dart';

import '../../Data layer/dio_helper.dart';

import '../states/state_shop_app.dart';

class ShopAppCubit extends Cubit<ShopAppStates> {
  ShopAppCubit() : super(ShopAppInitState());

  static ShopAppCubit getObject(context) => BlocProvider.of(context);

  HomeModel? homeModel;

  Map<int, bool> favorites = {};

  void getHomeData() {
    emit(ShopAppLoadingState());

    DioHelper.getData(url: 'home', token: token).then((value) {
      homeModel = HomeModel.fromJson(value.data);

      for (var product in homeModel!.data!.products!) {
        favorites.addAll({
          product.id!: product.inFavorites!,
        });
      }

      emit(ShopAppSuccessState(homeModel!));
    }).catchError((error) {
      if (kDebugMode) {
        print('Error F getHomeData ${error.toString()}');
      }

      emit(ShopAppErrorState());
    });
  }

  FavoritesAddAndDeleteMode? favoritesAddAndDeleteMode;

  void changeFavorite(int prodId) {
    favorites[prodId] = !favorites[prodId]!;

    emit(ChangeFavoriteLoadingState());

    DioHelper.postData(
      url: 'favorites',
      data: {
        'product_id': prodId,
      },
      token: token,
    ).then((value) {
      favoritesAddAndDeleteMode =
          FavoritesAddAndDeleteMode.fromJson(value.data);

      if (!favoritesAddAndDeleteMode!.status!) {
        /// in state = false
        favorites[prodId] = !favorites[prodId]!;
      } else {
        /// in state = true
        getDataFavorites();
      }
      emit(
        ChangeFavoritesSuccessState(favoritesMode: favoritesAddAndDeleteMode!),
      );
    }).catchError((error) {
      if (!favoritesAddAndDeleteMode!.status!) {
        favorites[prodId] = !favorites[prodId]!;
      }
      if (kDebugMode) {
        print('Error F changeFavorite${error.toString()}');
      }
      emit(ChangeFavoriteErrorState());
    });
  }

  CategoriesModel? categoriesModel;

  void getDataCategories() {
    emit(GetCategoriesLoadingState());
    DioHelper.getData(url: 'categories').then((value) {
      categoriesModel = CategoriesModel.fromJson(value.data);

      emit(GetCategoriesSuccessState());
    }).catchError((error) {
      if (kDebugMode) {
        print('Error F getDataCategories${error.toString()}');
      }

      emit(GetCategoriesErrorState());
    });
  }

  FavoritesModels? favoritesModels;

  void getDataFavorites() {
    emit(GetFavoritesLoadingState());

    DioHelper.getData(url: 'favorites', token: token).then((value) {
      favoritesModels = FavoritesModels.fromJson(value.data);

      emit(GetFavoritesSuccessState());
    }).catchError((error) {
      if (kDebugMode) {
        print('Error F getDataFavorites${error.toString()}');
      }
      emit(GetFavoritesErrorState());
    });
  }
}
