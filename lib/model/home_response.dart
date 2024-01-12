import 'package:json_annotation/json_annotation.dart';

part 'home_response.g.dart';

@JsonSerializable()
class HomeResponse {
  String? symbol;
  String? name;
  double? price;
  String? exchange;
  String? exchangeShortName;
  String? type;

  HomeResponse({this.symbol, this.name, this.price, this.exchange, this.exchangeShortName, this.type});

  factory HomeResponse.fromJson(Map<String, dynamic> json) => _$HomeResponseFromJson(json);

  @override
  String toString() {
    return 'HomeResponse{symbol: $symbol, name: $name, price: $price, exchange: $exchange, exchangeShortName: $exchangeShortName, type: $type}';
  }
}

