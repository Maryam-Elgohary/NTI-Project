import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:forth_session/features/home/domain/entities/product_entity.dart';
import 'package:forth_session/features/home/presentation/cubit/get_products/get_products_cubit.dart';
import 'package:forth_session/features/home/presentation/views/widgets/product_card.dart';

class productsGridViewBuilder extends StatelessWidget {
  productsGridViewBuilder({
    super.key,
    required this.products,
    required this.state,
  });
  final List<ProductEntity> products;
  final GetProductsState state;
  @override
  Widget build(BuildContext context) {
    if (state is GetProductsSuccess) {
      return GridView.builder(
        shrinkWrap: true,
        physics: AlwaysScrollableScrollPhysics(),
        itemCount: products.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          childAspectRatio: 0.8,
        ),
        itemBuilder: (context, index) {
          final product = products[index];
          return ProductCard(productEntity: product);
        },
      );
    } else if (state is GetProductsFailed) {
      log("Failed");
    } else if (state is GetProductsLoading) {
      CircularProgressIndicator();
    } else {
      return Center(child: Text("No Products"));
    }
    return Container();
  }
}
