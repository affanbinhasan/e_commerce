import 'dart:convert';

import 'package:flutter/cupertino.dart';

List<Novel> postFromJson(String str) =>
    List<Novel>.from(json.decode(str).map((x) => Novel.fromMap(x)));

class Novel {
  final int id;
  final String name;
  final String image;
  final String one_week_rent_price;
  final String mrp;

  Novel(
      {required this.id,
      required this.image,
      required this.name,
      required this.one_week_rent_price,
      required this.mrp});

  factory Novel.fromMap(Map<String, dynamic> json) {
    return Novel(
        id: json['id'],
        name: json['name'],
        image: json['image'],
        one_week_rent_price: json['one_week_rent_price'],
        mrp: json['mrp']);
  }
}
