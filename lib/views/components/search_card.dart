import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../constants.dart';

class SearchCard extends StatelessWidget {
  const SearchCard({super.key, required this.title, required this.imagePath, required this.onTap});

  final String title;
  final String imagePath;
  final void Function() onTap;

  //"$kHostIP/${Uri.encodeComponent(product.images[0].path)}"

  // () {
  // Get.put(ProductController());
  // showDialog(
  // context: context,
  // barrierDismissible: false,
  // builder: (context) => ProductView(product: product),
  // );
  //}
  @override
  Widget build(BuildContext context) {
    ColorScheme cs = Theme.of(context).colorScheme;
    TextTheme tt = Theme.of(context).textTheme;
    return ListTile(
      title: Text(
        title,
        style: tt.titleMedium!.copyWith(color: cs.onSurface),
      ),
      leading: CachedNetworkImage(
        //height: 50,
        width: 50,
        imageUrl: "$kHostIP/${Uri.encodeComponent(imagePath)}",
        placeholder: (context, s) => const Center(child: CircularProgressIndicator()),
      ),
      onTap: onTap,
    );
  }
}
