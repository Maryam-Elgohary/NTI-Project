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
}
