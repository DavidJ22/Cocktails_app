import 'dart:convert';

import 'package:cocktails_app/Cocktail.dart';
import 'package:http/http.dart' as http;

class DataSource {
  Future<List<Cocktail>>fetchCocktailData() async {  
    final uri = Uri.parse('https://raw.githubusercontent.com/teijo/iba-cocktails/master/recipes.json');
    final response = await http.get(uri);

    if (response.statusCode == 200) {
      final parsed = jsonDecode(response.body).cast<Map<String, dynamic>>();
      return parsed.map<Cocktail>((json) => Cocktail.fromJson(json)).toList();
    } else {
      throw Exception('Failed to fetch cocktails');   //   If the http response is anything except 200, a failed to fetch cocktails exceptions is thrown.
    }
  }
}
// This is for getting the json data in a list.