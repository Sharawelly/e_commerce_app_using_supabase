import 'package:e_commerce_app_using_supabase/core/functions/navigate_to.dart';
import 'package:e_commerce_app_using_supabase/views/home/ui/search_view.dart';
import 'package:flutter/material.dart';
import 'package:e_commerce_app_using_supabase/core/components/custom_search_field.dart';
import 'package:e_commerce_app_using_supabase/core/components/products_list.dart';
import 'package:e_commerce_app_using_supabase/views/home/ui/widgets/categories_list.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  late final TextEditingController _searchController;

  @override
  void initState() {
    _searchController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      // ! we used ListView instead of Column to make the view scrollable
      child: ListView(
        children: [
          SizedBox(height: 15),
          CustomSearchField(
            searchController: _searchController,
            onSearch: () {
              if (_searchController.text.isNotEmpty) {
                navigateTo(
                  context,
                  SearchView(searchQuery: _searchController.text),
                );
                _searchController.clear();
              }
            },
          ),
          const SizedBox(height: 20),
          Image.asset("assets/images/buy.jpg"),
          const SizedBox(height: 15),
          const Text("Popular Categories", style: TextStyle(fontSize: 20)),
          const SizedBox(height: 15),
          const CategoriesList(),
          const SizedBox(height: 15),
          const Text("Recently Products", style: TextStyle(fontSize: 20)),
          const SizedBox(height: 15),
          const ProductsList(),
        ],
      ),
    );
  }
}
