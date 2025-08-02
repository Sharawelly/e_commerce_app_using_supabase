import 'package:e_commerce_app_using_supabase/core/app_colors.dart';
import 'package:e_commerce_app_using_supabase/core/functions/navigate_to.dart';
import 'package:e_commerce_app_using_supabase/core/sensitive_data.dart';
import 'package:e_commerce_app_using_supabase/views/home/ui/search_view.dart';
import 'package:flutter/material.dart';
import 'package:e_commerce_app_using_supabase/core/components/custom_search_field.dart';
import 'package:e_commerce_app_using_supabase/core/components/products_list.dart';
import 'package:e_commerce_app_using_supabase/views/home/ui/widgets/categories_list.dart';
import 'package:pay_with_paymob/pay_with_paymob.dart';

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
    PaymentData.initialize(
      apiKey: SensitiveData
          .payMobApiKey, // Required: Found under Dashboard -> Settings -> Account Info -> API Key
      iframeId: SensitiveData
          .payMobIframeId, // Required: Found under Developers -> iframes
      integrationCardId: SensitiveData
          .payMobIntegrationCardId, // Required: Found under Developers -> Payment Integrations -> Online Card ID
      integrationMobileWalletId: SensitiveData
          .payMobIntegrationMobileWalletId, // Required: Found under Developers -> Payment Integrations -> Mobile Wallet ID
      // Optional User Data
      userData: UserData(
        email: "User Email", // Optional: Defaults to 'NA'
        phone: "User Phone", // Optional: Defaults to 'NA'
        name: "User First Name", // Optional: Defaults to 'NA'
        lastName: "User Last Name", // Optional: Defaults to 'NA'
      ),

      // Optional Style Customizations
      style: Style(
        primaryColor: AppColors.kPrimaryColor, // Default: Colors.blue
        appBarBackgroundColor: AppColors.kPrimaryColor, // Default: Colors.blue
        buttonStyle: ElevatedButton.styleFrom(
          backgroundColor: AppColors.kPrimaryColor,
          foregroundColor: Colors.white,
        ), // Default: ElevatedButton.styleFrom()
        circleProgressColor: AppColors.kPrimaryColor, // Default: Colors.blue
        unselectedColor: Colors.grey, // Default: Colors.grey
      ),
    );
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
