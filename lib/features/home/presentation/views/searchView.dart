import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forth_session/core/services/get_it.dart';
import 'package:forth_session/features/home/domain/repos/product_repo.dart';
import 'package:forth_session/features/home/presentation/cubit/search_products/search_products_cubit.dart';
import 'package:forth_session/features/home/presentation/views/homeView.dart';
import 'package:forth_session/features/home/presentation/views/widgets/search_field.dart';
import 'package:forth_session/features/home/presentation/views/widgets/search_products_gridview.dart';

class SearchView extends StatelessWidget {
  const SearchView({super.key, this.searchTitle});
  final String? searchTitle;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          SearchProductsCubit(productRepo: getIt<ProductRepo>())
            ..searchProductsByName(query: searchTitle ?? ""),
      child: SearchViewBody(searchTitle: searchTitle ?? ""),
    );
  }
}

class SearchViewBody extends StatefulWidget {
  const SearchViewBody({super.key, this.searchTitle});
  final String? searchTitle;

  @override
  State<SearchViewBody> createState() => _SearchViewBodyState();
}

class _SearchViewBodyState extends State<SearchViewBody> {
  late String currentSearch;

  @override
  void initState() {
    currentSearch = widget.searchTitle!;

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
                isEnabled: true,
                onChanged: (value) {
                  setState(() {
                    currentSearch = value;
                    context.read<SearchProductsCubit>().searchProductsByName(
                      query: currentSearch,
                    );
                  });
                },
              ),
              Expanded(child: SearchProductsGridviewBuilder()),
            ],
          ),
        ),
      ),
    );
  }
}
