import 'package:dentist_dashboard/models/Image_model.dart';
import 'package:dentist_dashboard/models/brand_model.dart';
import 'package:dentist_dashboard/models/category_model.dart';
import 'dart:convert';

List<ProductModel> productModelFromJson(String str) =>
    List<ProductModel>.from(json.decode(str).map((x) => ProductModel.fromJson(x)));

String productModelToJson(List<ProductModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ProductModel {
  final int id;
  final String title;
  final String description;
  final double price;
  final double weight;
  final double length;
  final double width;
  final double height;
  final int quantity;
  final int sellQuantity;
  final int maxPurchaseQty;
  final int minPurchaseQty;
  final bool active;
  final String upc;
  final String sku;
  final List<ImageModel> images;
  final List<CategoryModel> categories;
  final BrandModel brand;
  final int ownerId;

  ProductModel({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.weight,
    required this.length,
    required this.width,
    required this.height,
    required this.quantity,
    required this.sellQuantity,
    required this.maxPurchaseQty,
    required this.minPurchaseQty,
    required this.active,
    required this.upc,
    required this.sku,
    required this.images,
    required this.categories,
    required this.brand,
    required this.ownerId,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
        id: json["id"],
        title: json["title"],
        description: json["description"],
        price: json["price"]?.toDouble(),
        weight: json["weight"]?.toDouble(),
        length: json["length"]?.toDouble(),
        width: json["width"]?.toDouble(),
        height: json["height"]?.toDouble(),
        quantity: json["quantity"],
        sellQuantity: json["sell_quantity"],
        maxPurchaseQty: json["max_purchase_qty"],
        minPurchaseQty: json["min_purchase_qty"],
        active: json["active"],
        upc: json["upc"],
        sku: json["sku"],
        images: List<ImageModel>.from(json["images"].map((x) => ImageModel.fromJson(x))),
        categories: List<CategoryModel>.from(json["categories"].map((x) => CategoryModel.fromJson(x))),
        brand: BrandModel.fromJson(json["brand"]),
        ownerId: json["owner_id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "description": description,
        "price": price,
        "weight": weight,
        "length": length,
        "width": width,
        "height": height,
        "quantity": quantity,
        "sell_quantity": sellQuantity,
        "max_purchase_qty": maxPurchaseQty,
        "min_purchase_qty": minPurchaseQty,
        "active": active,
        "upc": upc,
        "sku": sku,
        "images": List.from(images.map((x) => x.toJson())),
        "categories": List.from(categories.map((x) => x.toJson())),
        "brand": brand.toJson(),
        "owner_id": ownerId,
      };
}
