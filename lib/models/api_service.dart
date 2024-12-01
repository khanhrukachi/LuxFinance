import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class APIService {
  static Map<String, dynamic> parseExchangeRate(String responseBody) {
    var data = json.decode(responseBody) as Map<String, dynamic>;
    return data["rates"];
  }

  static Future<Map<String, dynamic>> getExchangeRate() async {
    try {
      var url = Uri.https('api.exchangerate.host', '/latest', {'q': '{https}'});
      final response = await http.get(url);
      if (response.statusCode == 200) {
        return compute(parseExchangeRate, response.body);
      } else {
        throw Exception('Failed to load json data');
      }
    } catch (_) {}
    return {};
  }

  static Future<List<Map<String, dynamic>>> parseCountry(
      String responseBody) async {
    var data = json.decode(responseBody) as Map<String, dynamic>;
    var listSymbol = await getSymbolCurrency();
    List<Map<String, dynamic>> list =
        (data["countries"]["country"] as List<dynamic>).map((e) {
      Map<String, dynamic> item = {};
      var symbol = listSymbol
          .where((element) => element["abbreviation"] == e["currencyCode"])
          .toList();
      item["countryName"] = e["countryName"];
      item["currencyCode"] = e["currencyCode"];
      item["symbol"] = symbol.isNotEmpty ? symbol[0]["symbol"] : "";
      if (item["symbol"] == null) item["symbol"] = "";
      return item;
    }).toList();
    return list;
  }

  static Future<List<Map<String, dynamic>>> getCountry() async {
    try {
      var url = Uri.https(
        'gist.githubusercontent.com',
        'khanhrukachi/fb28e3b770ad5e70dafcac5a830fb94a/raw',
        {'q': '{https}'},
      );
      final response = await http.get(url);
      if (response.statusCode == 200) {
        return compute(parseCountry, response.body);
      } else {
        throw Exception('Failed to load json data');
      }
    } catch (_) {}
    return [];
  }

  static List<Map<String, dynamic>> parseSymbolCurrency(String responseBody) {
    var data = json.decode(responseBody) as List<dynamic>;
    List<Map<String, dynamic>> list =
        data.map((e) => e as Map<String, dynamic>).toList();
    return list;
  }

  static Future<List<Map<String, dynamic>>> getSymbolCurrency() async {
    try {
      var url = Uri.https(
        'gist.githubusercontent.com',
        '/khanhrukachi/fac7fb2d7986e6dc436845760b49e9f6/raw',
        {'q': '{https}'},
      );
      final response = await http.get(url);
      if (response.statusCode == 200) {
        return compute(parseSymbolCurrency, response.body);
      } else {
        throw Exception('Failed to load json data');
      }
    } catch (_) {}
    return [];
  }
}
