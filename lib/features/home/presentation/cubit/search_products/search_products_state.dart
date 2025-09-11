part of 'search_products_cubit.dart';

@immutable
sealed class SearchProductsState {}

final class SearchProductsInitial extends SearchProductsState {}

final class SearchProductsLoading extends SearchProductsState {}

final class SearchProductsSuccess extends SearchProductsState {
  final List<ProductEntity> products;
  SearchProductsSuccess(this.products);
}

final class SearchProductsFailed extends SearchProductsState {
  final String message;
  SearchProductsFailed(this.message);
}
