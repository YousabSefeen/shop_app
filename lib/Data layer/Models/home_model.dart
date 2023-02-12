class HomeModel {
  bool? status;

  HomeDataModel? data;

  HomeModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null ? HomeDataModel.fromJson(json['data']) : null;
  }
}

class HomeDataModel {
  List<BannerMode>? banners;

  List<ProductModel>? products;

  HomeDataModel.fromJson(Map<String, dynamic> json) {
    if (json['banners'] != null) {
      banners = <BannerMode>[];

      json['banners'].forEach((banner) {
        banners!.add(BannerMode.fromJson(banner));
      });
    }

    if (json['products'] != null) {
      products = <ProductModel>[];

      json['products'].forEach((product) {
        products!.add(ProductModel.fromJson(product));
      });
    }
  }
}

class BannerMode {
  int? id;
  String? image;

  BannerMode.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'];
  }
}

class ProductModel {
  int? id;
  dynamic price;
  dynamic oldPrice;
  dynamic discount;
  String? image;
  String? name;

  bool? inFavorites;
  bool? inCart;
  String? description;
  List<dynamic>? images;

  ProductModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    price = json['price'];
    oldPrice = json['old_price'];
    discount = json['discount'];
    image = json['image'];
    name = json['name'];
    inFavorites = json['in_favorites'];
    inCart = json['in_cart'];
    description = json['description'];
    images = json['images'];
  }
}
