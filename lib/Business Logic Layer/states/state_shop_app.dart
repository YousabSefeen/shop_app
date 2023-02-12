import '../../Data layer/Models/favorites_add_and_delete_mode.dart';
import '../../Data layer/Models/home_model.dart';

abstract class ShopAppStates {}

class ShopAppInitState extends ShopAppStates {}

class ShopAppLoadingState extends ShopAppStates {}

class ShopAppSuccessState extends ShopAppStates {
  final HomeModel homeModel;

  ShopAppSuccessState(this.homeModel);
}

class ShopAppErrorState extends ShopAppStates {}

class GetCategoriesLoadingState extends ShopAppStates {}

class GetCategoriesSuccessState extends ShopAppStates {}

class GetCategoriesErrorState extends ShopAppStates {}

class ChangeFavoriteLoadingState extends ShopAppStates {}

class ChangeFavoritesSuccessState extends ShopAppStates {
  final FavoritesAddAndDeleteMode favoritesMode;

  ChangeFavoritesSuccessState({
    required this.favoritesMode,
  });
}

class ChangeFavoriteErrorState extends ShopAppStates {}

class GetFavoritesLoadingState extends ShopAppStates {}

class GetFavoritesSuccessState extends ShopAppStates {}

class GetFavoritesErrorState extends ShopAppStates {}
