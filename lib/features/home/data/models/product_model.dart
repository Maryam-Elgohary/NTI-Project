import 'package:forth_session/features/home/domain/entities/product_entity.dart';

class ProductModel {
  int? id;
  String? title;
  double? price;
  String? description;
  String? category;
  String? image;

  ProductModel({
    this.id,
    this.title,
    this.price,
    this.description,
    this.category,
    this.image,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
    id: json['id'] ?? 0,
    title: json['title'] ?? "",
    price: (json['price'] ?? 0)?.toDouble(),
    description: json['description'] ?? '',
    category: json['category'] ?? '',
    image: json['image'] ?? '',
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'price': price,
    'description': description,
    'category': category,
    'image': image,
  };

  ProductEntity toEntity() {
    return ProductEntity(
      category: category,
      description: description,
      id: id,
      image: image,
      price: price,
      title: title,
    );
  }
}
