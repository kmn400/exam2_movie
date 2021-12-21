import 'dart:convert';

import 'package:exam2_movie/model/movie.dart';
import 'package:http/http.dart' as http;

class MovieApi {
  Future<List<Movie>> fetchMovies(String query) async {
    final response = await http.get(Uri.parse(
        'https://api.themoviedb.org/3/movie/upcoming?api_key=a64533e7ece6c72731da47c9c8bc691f&language=ko-KR&page=1'));

    if (response.statusCode == 200) {
      List jsonList = jsonDecode(response.body)['results'];
      return jsonList.map((e) => Movie.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load album');
    }
  }
}
