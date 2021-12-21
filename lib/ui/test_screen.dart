import 'dart:convert';

import 'package:exam2_movie/model/movie.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class TestScreen extends StatefulWidget {
  const TestScreen({Key? key}) : super(key: key);

  @override
  State<TestScreen> createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {
  Future<List<Movie>> fetchMovies() async {
    // await [Future가 리턴되는 코드]
    final response = await http.get(Uri.parse(
        'https://api.themoviedb.org/3/movie/upcoming?api_key=a64533e7ece6c72731da47c9c8bc691f&language=ko-KR&page=1'));

    if (response.statusCode == 200) {
      return Movie.listToMovies(jsonDecode(response.body)['results']);
    } else {
      throw Exception('Failed to load album');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Network Sample'),
      ),
      body: Column(
        children: [
          ElevatedButton(
            onPressed: () {
              setState(() {});
            },
            child: const Text('Movie들 가져오기'),
          ),
          FutureBuilder<List<Movie>>(
            future: fetchMovies(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                print(snapshot.error.toString());
                return const Center(child: Text('네트워크 에러!!!'));
              }

              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }

              // 데이터가 없다면
              if (!snapshot.hasData) {
                return const Center(child: Text('데이터가 없습니다'));
              }

              // 데이터가 여기에서는 무조건 있는 상황
              final List<Movie> movies = snapshot.data!;

              return _buildMovies(movies);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildMovies(List<Movie> movies) {
    return Expanded(
      child: ListView.builder(
        itemCount: movies.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(movies[index].title),
          );
        },
      ),
    );
  }
}
