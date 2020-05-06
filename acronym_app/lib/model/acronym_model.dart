
class CategoryList {
  final List<Category> categories;


  CategoryList({
    this.categories,
  });

  factory CategoryList.fromJson(List<dynamic> json) {
    List<Category> categories = new List<Category>();
    categories = json.map((i) => Category.fromJson(i)).toList();

    return new CategoryList(
      categories: categories
    );
  }

}


/// PODO for Category
class Category {
  final String title;
  final List<Acronym> items;

  Category({this.title, this.items});

  factory Category.fromJson(Map<String, dynamic> json) {

    var list = json['acronyms'] as List;
    List<Acronym> acronyms = list.map((i) => Acronym.fromJson(i)).toList();

    return Category(
      title: json['category'],
      items: acronyms,
    );
  }
}

class Acronym {
  final String title;
  final String description;
  final String category = "";

  Acronym({this.title, this.description});

  factory Acronym.fromJson(Map<String, dynamic> json) {
    return Acronym(
      title: json['title'] as String,
      description: json['description'] as String
    );
  }

  Map<String, dynamic> toJson() =>
      {
        'title': title,
        'description': description,
      };
}

class PrefixTree {

}