import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forth_session/features/home/presentation/cubit/search_products/search_products_cubit.dart';
import 'package:forth_session/features/home/presentation/views/widgets/products_gridview.dart';

class SearchProductsGridviewBuilder extends StatelessWidget {
  SearchProductsGridviewBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchProductsCubit, SearchProductsState>(
      builder: (context, state) {
        if (state is SearchProductsSuccess) {
          return ProductsGridView(products: state.products);
        }
        if (state is SearchProductsFailed) {
          return Center(child: Text("No products found, please try again"));
        }
        if (state is SearchProductsLoading) {
          return Center(child: CircularProgressIndicator());
        }
        return Center(child: CircularProgressIndicator());
      },
    );
  }
}
