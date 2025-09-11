import 'package:flutter/material.dart';
import 'package:forth_session/features/auth/presentation/views/signinview.dart';
import 'package:forth_session/features/home/presentation/views/searchView.dart';

class SearchField extends StatefulWidget {
  const SearchField({
    super.key,
    this.initialValue = "",

    this.onChanged,
    required this.isEnabled,
  });
  final String initialValue;

  final Function(String)? onChanged;
  final bool isEnabled;
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

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => SearchView(searchTitle: widget.initialValue),
          ),
        );
      },
      child: customTextFormField(
        isEnabled: widget.isEnabled,
        controller: searchController,
        pref: Icon(
          Icons.search,
          color: const Color(0xFF1B5E37),
          size: screenWidth * 0.05, // حجم متناسب مع العرض
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
