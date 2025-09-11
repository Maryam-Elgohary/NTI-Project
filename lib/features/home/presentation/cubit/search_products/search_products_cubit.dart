import 'package:bloc/bloc.dart';
import 'package:forth_session/features/home/domain/entities/product_entity.dart';
import 'package:forth_session/features/home/domain/repos/product_repo.dart';
import 'package:meta/meta.dart';

part 'search_products_state.dart';

class SearchProductsCubit extends Cubit<SearchProductsState> {
  SearchProductsCubit({required this.productRepo})
    : super(SearchProductsInitial());
  final ProductRepo productRepo;

  Future<void> searchProductsByName({required String query}) async {
    emit(SearchProductsLoading());

    var result = await productRepo.SearchProducts(ProductName: query);

    result.fold(
      (Failure) => emit(SearchProductsFailed(Failure.message.toString())),
      (ProductEntity) => emit(SearchProductsSuccess(ProductEntity)),
    );
  }
}
