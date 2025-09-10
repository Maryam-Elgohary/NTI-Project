import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forth_session/core/services/get_it.dart';
import 'package:forth_session/features/home/domain/repos/product_repo.dart';
import 'package:forth_session/features/home/presentation/cubit/get_products/get_products_cubit.dart';
import 'package:forth_session/features/home/presentation/views/homeView.dart';
import 'package:forth_session/features/home/presentation/views/widgets/products_gridview_builder.dart';
import 'package:forth_session/features/home/presentation/views/widgets/search_field.dart';

class SearchView extends StatelessWidget {
  const SearchView({super.key, required this.searchTitle});
  final String searchTitle;
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: BlocProvider(
        create: (context) =>
            GetProductsCubit(getIt<ProductRepo>())..getProducts(),
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            shadowColor: Colors.white,

            backgroundColor: Colors.white,
            title: Text('البحث'),
            centerTitle: true,
            leading: GestureDetector(
              child: Icon(Icons.arrow_back_ios),
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => Homeview()),
                );
              },
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              spacing: 10,
              children: [
                SearchField(initialValue: searchTitle),
                Expanded(
                  child: BlocBuilder<GetProductsCubit, GetProductsState>(
                    builder: (context, state) {
                      return productsGridViewBuilder(
                        products: state is GetProductsSuccess
                            ? state.products.where((product) {
                                return product.title!.toLowerCase().contains(
                                  "${searchTitle}".toLowerCase(),
                                );
                              }).toList()
                            : [],
                        state: state,
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
