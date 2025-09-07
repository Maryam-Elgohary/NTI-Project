import 'package:dartz/dartz.dart';
import 'package:forth_session/core/errors/failure.dart';
import 'package:forth_session/features/home/domain/entities/product_entity.dart';

abstract class ProductRepo {
  Future<Either<Failure, List<ProductEntity>>> getProducts();
}
