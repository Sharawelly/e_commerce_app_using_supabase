import 'package:e_commerce_app_using_supabase/core/components/products_list.dart';
import 'package:e_commerce_app_using_supabase/core/functions/build_appbar.dart';
import 'package:flutter/material.dart';

class SearchView extends StatelessWidget {
  const SearchView({super.key, required this.searchQuery});

  final String searchQuery;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildCustomAppBar(context, "Search Results"),
      body: ListView(
        children: [
          SizedBox(height: 15),
          ProductsList(searchQuery: searchQuery),
        ],
      ),
    );
  }
}
