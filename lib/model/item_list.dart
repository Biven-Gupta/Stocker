import 'package:task/model/home_response.dart';

class ItemList {
  final List<HomeResponse>? items;

  ItemList({ this.items});

  factory ItemList.fromJson(List<dynamic> json) {
    List<HomeResponse> items = json.map((item) => HomeResponse.fromJson(item)).toList();
    return ItemList(items: items);
  }

  @override
  String toString() {
    return 'ItemList{items: $items}';
  }
}