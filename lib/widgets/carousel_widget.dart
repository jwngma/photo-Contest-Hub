import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:photocontesthub/utils/Constants.dart';

Widget corouselCard(String img_url) {
  return CachedNetworkImage(
    imageUrl: img_url,
    fit: BoxFit.cover,
    placeholder: (context, url) =>
        Image.asset(Constants.gallery_placeholder),
    errorWidget: (context, url, error) => Icon(Icons.error),
  );
}