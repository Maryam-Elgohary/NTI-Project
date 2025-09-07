import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forth_session/features/home/domain/entities/product_entity.dart';
import 'package:forth_session/features/home/presentation/cubit/get_products/get_products_cubit.dart';
import 'package:forth_session/features/home/presentation/views/widgets/product_card.dart';

class productsGridViewBuilder extends StatelessWidget {
  productsGridViewBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    List<ProductEntity> products;
    return BlocBuilder<GetProductsCubit, GetProductsState>(
      builder: (context, state) {
        if (state is GetProductsSuccess) {
          log("${state.products.length}");
          products = state.products;
          return GridView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
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
        } else {
          return Text("No Products");
        }
        return Container();
      },
    );
  }
}
