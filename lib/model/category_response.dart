import 'category.dart';

class CategoryResponse {
  List<Category>? categoryList;

  CategoryResponse({this.categoryList});

  CategoryResponse.fromList(List<dynamic> json) {
    categoryList = <Category>[];
    for (var element in json) {
      categoryList!.add(Category.fromJson(element));
    }
  }
}
