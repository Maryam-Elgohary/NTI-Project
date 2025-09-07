import 'package:bloc/bloc.dart';
import 'package:forth_session/features/home/domain/entities/product_entity.dart';
import 'package:forth_session/features/home/domain/repos/product_repo.dart';
import 'package:meta/meta.dart';

part 'get_products_state.dart';

class GetProductsCubit extends Cubit<GetProductsState> {
  GetProductsCubit(this.productRepo) : super(GetProductsInitial());
  final ProductRepo productRepo;

  Future<void> getProducts() async {
    emit(GetProductsLoading());

    var result = await productRepo.getProducts();

    result.fold(
      (Failure) => emit(GetProductsFailed(Failure.message)),
      (ProductEntity) => emit(GetProductsSuccess(ProductEntity)),
    );
  }
}
