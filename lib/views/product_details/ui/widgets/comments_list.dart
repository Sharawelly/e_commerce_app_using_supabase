import 'package:e_commerce_app_using_supabase/core/components/custom_circle_pro_ind.dart';
import 'package:e_commerce_app_using_supabase/core/models/product_model/product_model.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class CommentsList extends StatelessWidget {
  const CommentsList({super.key, required this.productModel});

  final ProductModel productModel;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: Supabase.instance.client
          .from('comments_table')
          .stream(primaryKey: ['id'])
          .eq("for_product", productModel.productId!)
          .order("created_at", ascending: false),
      builder: (context, snapshot) {
        List<Map<String, dynamic>>? comments = snapshot.data;
        // ! we used ListView.separated to create a list of comments with dividers
        // ! ListView.separated ==> ListView.builder + Divider
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CustomCircleProgIndicator());
        } else if (snapshot.hasData) {
          return ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) =>
                UserComment(commentData: comments?[index]),
            separatorBuilder: (context, index) => const Divider(),
            itemCount: comments?.length ?? 0,
          );
        } else if (!snapshot.hasData) {
          return const Center(child: Text("No comments yet"));
        } else {
          return const Center(
            child: Text("Something went wrong, please try again"),
          );
        }
      },
    );
  }
}

class UserComment extends StatelessWidget {
  const UserComment({super.key, required this.commentData});

  final Map<String, dynamic>? commentData;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Text(
              commentData?['user_name'] ?? "User Name",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
        Row(children: [Text(commentData?['comment'] ?? "No comment yet")]),
        if (commentData?['replay'] != null)
          Column(
            children: [
              Row(
                children: [
                  Text(
                    "Replay:-",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              Row(children: [Text(commentData?['replay'] ?? "No replay yet")]),
            ],
          ),
      ],
    );
  }
}
