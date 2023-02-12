class SearchModel {
  bool? status;

  SearchData? searchData;

  SearchModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];

    searchData =
        json['data'] != null ? SearchData.fromJson(json['data']) : null;
  }
}

class SearchData {
  dynamic currentPage;

  List<DataSearch> data = [];

  SearchData.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];

    json['data'].forEach((e) {
      data.add(DataSearch.fromJson(e));
    });
  }
}

class DataSearch {
  int? id;
  dynamic price;
  String? image;
  String? name;
  String? description;
  List<dynamic>? images;
  bool? inFavorites;
  bool? inCart;

  DataSearch.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    price = json['price'];
    image = json['image'];
    name = json['name'];
    description = json['description'];
    images = json['images'];
    inFavorites = json['in_favorites'];
    inCart = json['in_cart'];
  }
}
