import 'dart:developer';

import 'package:task/model/home_response.dart';
import 'package:rxdart/rxdart.dart';
import 'package:task/model/item_list.dart';
import 'package:task/repository/home_repository.dart';

class HomeViewModel {
  final String _tag = "HomeViewModel";

  //Singleton
  static final HomeViewModel instance = HomeViewModel._privateConstructor();

  //Private constructor
  HomeViewModel._privateConstructor();

  final HomeRepository _homeRepository = HomeRepository.instance;
  final BehaviorSubject<ItemList?> _contentResponseBehaviorSubject = BehaviorSubject<ItemList?>();

  Future<void> content() async {
    ItemList? contentResponse = await _homeRepository.content();
    log(contentResponse.toString(), name: "$_tag home contentResponse");
    if (contentResponse != null) {
      _contentResponseBehaviorSubject.add(contentResponse);
    } else {
      _contentResponseBehaviorSubject.addError(contentResponse!);
      log(contentResponse.toString(), name: "$_tag home ErrorResponse");
    }
  }

  void dispose() {
    _contentResponseBehaviorSubject.add(null);
  }

  BehaviorSubject<ItemList?> get contentResponseBehaviorSubject => _contentResponseBehaviorSubject;
}
