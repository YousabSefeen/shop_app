class FavoritesAddAndDeleteMode {
  bool? status;

  String? message;
  FavoritesDM? data;

  FavoritesAddAndDeleteMode.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];

    data = json['data'] != null ? FavoritesDM.fromJson(json['data']) : null;
  }
}

class FavoritesDM {
  int? id;
  FavoriteSingleProductDM? productDM;

  FavoritesDM.fromJson(Map<String, dynamic> json) {
    id = json['id'];

    productDM = json['product'] != null
        ? FavoriteSingleProductDM.fromJson(json['product'])
        : null;
  }
}

class FavoriteSingleProductDM {
  int? id;
  dynamic price;
  dynamic oldPrice;
  dynamic discount;
  String? image;

  FavoriteSingleProductDM.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    price = json['price'];
    oldPrice = json['old_price'];
    discount = json['discount'];
    image = json['image'];
  }
}
