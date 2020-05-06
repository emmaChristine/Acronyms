import 'dart:async' show Future;
import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;

import 'package:acronymapp/model/acronym_model.dart';

Future<String> _loadAcronymsAsset(String assetPath) async {
  return await rootBundle.loadString(assetPath);
}

Future<CategoryList> loadAcronyms(String assetPath) async {
  String jsonAcronyms = await _loadAcronymsAsset(assetPath);

  final jsonResponse = json.decode(jsonAcronyms);
  CategoryList categoryList = CategoryList.fromJson(jsonResponse);

  print("Categories count: " + categoryList.categories.length.toString());

  return categoryList;
}

