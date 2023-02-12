class FavoritesModels {
  bool? status;
  String? message;
  DataFavoritesModels? data;

  FavoritesModels.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? DataFavoritesModels.fromJson(json['data']) : null;
  }
}

class DataFavoritesModels {
  int? currentPage;
  List<DataAllProducts>? data;
  String? firstPageUrl;
  int? from;
  int? lastPage;
  String? lastPageUrl;
  dynamic nextPageUrl;
  String? path;
  dynamic perPage;
  dynamic prevPageUrl;
  dynamic to;
  dynamic total;

  DataFavoritesModels.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    if (json['data'] != null) {
      data = <DataAllProducts>[];
      json['data'].forEach((v) {
        data!.add(DataAllProducts.fromJson(v));
      });
    }
    firstPageUrl = json['first_page_url'];
    from = json['from'];
    lastPage = json['last_page'];
    lastPageUrl = json['last_page_url'];
    nextPageUrl = json['next_page_url'];
    path = json['path'];
    perPage = json['per_page'];
    prevPageUrl = json['prev_page_url'];
    to = json['to'];
    total = json['total'];
  }
}

class DataAllProducts {
  int? id;
  FavoriteSingleProductModel? product;

  DataAllProducts.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    product =
        json['product'] != null ? FavoriteSingleProductModel.fromJson(json['product']) : null;
  }
}

class FavoriteSingleProductModel {
  int? id;
  dynamic price;
  dynamic oldPrice;
  dynamic discount;
  String? image;
  String? name;
  String? description;

  FavoriteSingleProductModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    price = json['price'];
    oldPrice = json['old_price'];
    discount = json['discount'];
    image = json['image'];
    name = json['name'];
    description = json['description'];
  }
}
