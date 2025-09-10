import 'package:flutter/material.dart';
import 'package:forth_session/features/home/domain/entities/product_entity.dart';
import 'package:forth_session/features/home/presentation/cubit/get_products/get_products_cubit.dart';
import 'package:forth_session/features/home/presentation/views/homeView.dart';
import 'package:forth_session/features/home/presentation/views/widgets/products_gridview_builder.dart';
import 'package:forth_session/features/home/presentation/views/widgets/search_field.dart';

class SearchView extends StatefulWidget {
  const SearchView({
    super.key,
    required this.searchTitle,
    required this.products,
    required this.state,
  });
  final String searchTitle;
  final List<ProductEntity> products;
  final GetProductsState state;

  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  late String currentSearch;

  @override
  void initState() {
    currentSearch = widget.searchTitle;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
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
              SearchField(
                initialValue: currentSearch,
                products: widget.products,
                state: widget.state,
                onChanged: (value) {
                  setState(() {
                    currentSearch = value;
                  });
                },
              ),
              Expanded(
                child: productsGridViewBuilder(
                  products: widget.products.where((product) {
                    final title = product.title ?? "";
                    return title.toLowerCase().contains(
                      currentSearch.toLowerCase(),
                    );
                  }).toList(),

                  state: widget.state,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
