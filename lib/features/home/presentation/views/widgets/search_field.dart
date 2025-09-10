import 'package:flutter/material.dart';
import 'package:forth_session/features/auth/presentation/views/signinview.dart';
import 'package:forth_session/features/home/presentation/views/searchView.dart';

class SearchField extends StatelessWidget {
  const SearchField({super.key, this.initialValue = ""});
  final String initialValue;
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.sizeOf(context).width;
    final screenHeight = MediaQuery.sizeOf(context).height;
    TextEditingController searchController = TextEditingController(
      text: initialValue,
    );

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
                    return SearchView(searchTitle: searchController.text);
                  },
                ),
              );
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
      ),
    );
  }
}
