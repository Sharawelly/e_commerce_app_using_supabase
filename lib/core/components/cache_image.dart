import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:e_commerce_app_using_supabase/core/components/custom_circle_pro_ind.dart';

class CacheImage extends StatelessWidget {
  const CacheImage({super.key, required this.url});

  final String url;
  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      fit: BoxFit.cover,
      height: 250,
      width: double.infinity,
      imageUrl: url,
      placeholder: (context, url) =>
          const SizedBox(height: 200, child: CustomCircleProgIndicator()),
      errorWidget: (context, url, error) => const Icon(Icons.error),
    );
  }
}
