import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:forth_session/core/errors/failure.dart';
import 'package:forth_session/core/services/api_services.dart';
import 'package:forth_session/features/home/data/models/product_model.dart';
import 'package:forth_session/features/home/domain/entities/product_entity.dart';
import 'package:forth_session/features/home/domain/repos/product_repo.dart';

class ProductRepoImplementation extends ProductRepo {
  final ApiServices apiServices;

  ProductRepoImplementation({required this.apiServices});
  @override
  Future<Either<Failure, List<ProductEntity>>> getProducts() async {
    try {
      final data = await apiServices.get(endPoint: 'products') as List<dynamic>;
      final products = data
          .map((e) => ProductModel.fromJson(e as Map<String, dynamic>))
          .toList();

      final productEntity = products.map((e) => e.toEntity()).toList();
      return right(productEntity);
    } catch (e) {
      if (e is DioException) {
        return left(ServerFailure.fromDioException(e));
      } else {
        return left(ServerFailure(e.toString()));
      }
    }
  }

  @override
  Future<Either<Failure, List<ProductEntity>>> SearchProducts({
    required String ProductName,
  }) async {
    try {
      if (ProductName.isEmpty) {
        return left(ServerFailure("Please enter a product name"));
      }

      final data = await apiServices.get(endPoint: 'products') as List<dynamic>;
      final products = data
          .map((e) => ProductModel.fromJson(e as Map<String, dynamic>))
          .toList();

      final productEntity = products.map((e) => e.toEntity()).toList();
      final query = ProductName;
      final filteredProducts = productEntity
          .where((p) => p.title!.toLowerCase().contains(query.toLowerCase()))
          .toList();
      if (filteredProducts.isEmpty) {
        return left(ServerFailure("No products found matching this name"));
      } else {
        return right(filteredProducts);
      }
    } catch (e) {
      if (e is DioException) {
        return left(ServerFailure.fromDioException(e));
      } else {
        return left(ServerFailure(e.toString()));
      }
    }
  }
}
