class CategoriesModel {
  bool? states;
  CategoriesDataMode? data;

  CategoriesModel.fromJson(Map<String, dynamic> json) {
    states = json['status'];
    data =
        json['data'] != null ? CategoriesDataMode.fromJson(json['data']) : null;
  }
}

class CategoriesDataMode {
  dynamic currentPage;
  List<CategorySingleModel>? dataModel;

  String? firstPageUrl;

  dynamic from;

  dynamic lastPage;
  String? lastPageUrl;
  String? nextPageUrl;
  String? path;

  dynamic perPage;

  dynamic to;
  dynamic total;

  CategoriesDataMode.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];

    if (json['data'] != null) {
      dataModel = <CategorySingleModel>[];
      json['data'].forEach((v) {
        dataModel!.add(CategorySingleModel.fromJson(v));
      });
    }

    firstPageUrl = json['first_page_url'];

    from = json['from'];
    lastPage = json['last_page'];

    lastPageUrl = json['last_page_url'];
    nextPageUrl = json['next_page_url'];

    path = json['path'];
    perPage = json['per_page'];
    to = json['to'];
    total = json['total'];
  }
}

class CategorySingleModel {
  int? id;
  String? name;
  String? image;

  CategorySingleModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
  }
}
