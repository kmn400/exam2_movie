import 'dart:convert';

import 'package:exam2_movie/model/movie1.dart';
import 'package:http/http.dart' as http;

class MovieApi {
  Future<List<Results>> fetchMovies(String query1) async {
    final response = await http.get(Uri.parse(
        'https://api.themoviedb.org/3/search/movie?api_key=a64533e7ece6c72731da47c9c8bc691f&query=$query1&language=en-US'));

    if (response.statusCode == 200) {
      List jsonList = jsonDecode(response.body)['results'];
      return jsonList.map((e) => Results.fromJson(e)).toList();
    } else {
      throw Exception('Failed  to load album');
    }
  }
}
