import 'dart:convert';

import 'package:http/http.dart' as http;

class ShopData {
  Future<dynamic> getAvailableProducts() async {
    var url = Uri.https('api.escuelajs.co',
        '/api/v1/products'); // Split the URL into scheme, authority, and path.

    final response = await http.get(url);

    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body);
      return jsonData;
    } else {
      throw Exception('Failed to load data');
    }
  }
}
