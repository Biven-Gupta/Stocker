import 'dart:developer';

import 'package:task/api/http_manager.dart';
import 'package:task/model/item_list.dart';

class HomeRepository {
  final String _tag = "AuthenticationRepository";

  static final HomeRepository instance = HomeRepository._privateConstructor();

  HomeRepository._privateConstructor();

  final HttpManager _httpManager = HttpManager.instance;

  Future<ItemList?> content() async {
    ItemList? response = await _httpManager.content();
    log(response.toString(), name: "$_tag home response");
    if (response != null) {
      return response;
    } else {
      return ItemList();
    }
  }
}
