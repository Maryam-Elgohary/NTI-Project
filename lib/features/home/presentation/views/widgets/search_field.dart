import 'package:flutter/material.dart';
import 'package:forth_session/core/helps%20functions/build_snackbar.dart';
import 'package:forth_session/features/auth/presentation/views/signinview.dart';
import 'package:forth_session/features/home/domain/entities/product_entity.dart';
import 'package:forth_session/features/home/presentation/cubit/get_products/get_products_cubit.dart';
import 'package:forth_session/features/home/presentation/views/searchView.dart';

class SearchField extends StatefulWidget {
  const SearchField({
    super.key,
    this.initialValue = "",
    this.products,
    this.state,
    this.onChanged,
  });
  final String initialValue;
  final List<ProductEntity>? products;
  final GetProductsState? state;
  final Function(String)? onChanged;

  @override
  State<SearchField> createState() => _SearchFieldState();
}

class _SearchFieldState extends State<SearchField> {
  late TextEditingController searchController;

  @override
  void initState() {
    super.initState();
    searchController = TextEditingController(text: widget.initialValue);
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.sizeOf(context).width;
    final screenHeight = MediaQuery.sizeOf(context).height;

    return Container(
      child: customTextFormField(
        controller: searchController,
        pref: GestureDetector(
          onTap: () {
            if (searchController.text.isNotEmpty) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return SearchView(
                      searchTitle: searchController.text,
                      products: widget.products ?? [],
                      state: widget.state ?? GetProductsInitial(),
                    );
                  },
                ),
              );
            } else {
              BuildSnackBar(context, "يرجى ادخال كلمة للبحث");
            }
          },
          child: Icon(
            Icons.search,
            color: const Color(0xFF1B5E37),
            size: screenWidth * 0.05, // حجم متناسب مع العرض
          ),
        ),
        suff: Icon(
          Icons.filter_list,
          color: const Color(0xFF1B5E37),
          size: screenWidth * 0.05,
        ),
        hinttext: "ابحث عن ...",
        textInputType: TextInputType.text,
        hintStyle: TextStyle(
          fontSize: screenWidth * 0.035, // حجم الخط ديناميكي
          color: Colors.grey[600],
        ),
        contentPadding: EdgeInsets.symmetric(
          vertical: screenHeight * 0.015,
          horizontal: screenWidth * 0.04,
        ),
        onChanged: widget.onChanged,
      ),
    );
  }
}
